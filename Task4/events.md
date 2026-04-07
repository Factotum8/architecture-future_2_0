# Каталог доменных событий

## Клинические операции

| Событие                | Источник (контекст) | Семантика                            | Минимальный контракт                                                              |
|------------------------|---------------------|--------------------------------------|-----------------------------------------------------------------------------------|
| `AppointmentScheduled` | Clinical Operations | Создана запись на приём              | `appointmentId`, `patientId`, `slotStart`, `slotEnd`, `clinicId`, `schemaVersion` |
| `PatientCheckedIn`     | Clinical Operations | Пациент зарегистрирован на визит     | `visitId`, `episodeId`, `patientId`, `checkedInAt`, `schemaVersion`               |
| `CareEpisodeOpened`    | Clinical Operations | Открыт эпизод лечения (операционный) | `episodeId`, `patientId`, `openedAt`, `schemaVersion`                             |
| `CareEpisodeClosed`    | Clinical Operations | Эпизод закрыт                        | `episodeId`, `closedAt`, `reason`, `schemaVersion`                                |

**Подписчики:** Clinical Record (открытие документации), Billing (тарификация), Data Platform (агрегаты), Inventory (резервы).

---

## Клиническая запись

| Событие                  | Источник        | Семантика                                                              | Минимальный контракт                                   |
|--------------------------|-----------------|------------------------------------------------------------------------|--------------------------------------------------------|
| `ClinicalDocumentSealed` | Clinical Record | Документ подписан/закрыт для дальнейших изменений только по регламенту | `documentId`, `episodeId`, `sealedAt`, `schemaVersion` |

**Подписчики:** Billing (если выставление счёта привязано к факту), аудит, Data Platform (метаданные без текста).

---

## ИИ / Диагностика

| Событие                  | Источник    | Семантика                                                      | Минимальный контракт                                                     |
|--------------------------|-------------|----------------------------------------------------------------|--------------------------------------------------------------------------|
| `AIAssistedStudyOrdered` | Clinical AI | Заказано исследование с участием ИИ                            | `aiStudyId`, `episodeId`, `studyType`, `orderedAt`, `schemaVersion`      |
| `AIStudyCompleted`       | Clinical AI | Исследование завершено (результат зафиксирован в контексте ИИ) | `aiStudyId`, `episodeId`, `completedAt`, `modelVersion`, `schemaVersion` |

**Подписчики:** Clinical Record (ссылка на результат по политике), Billing (если тарифицируется), Data Platform (обезличенные метрики качества/лабораторной нагрузки).

---

## Биллинг

| Событие         | Источник | Семантика      | Минимальный контракт                                                         |
|-----------------|----------|----------------|------------------------------------------------------------------------------|
| `InvoiceIssued` | Billing  | Выставлен счёт | `invoiceId`, `contractId`, `amount`, `currency`, `issuedAt`, `schemaVersion` |
| `InvoicePaid`   | Billing  | Счёт оплачен   | `invoiceId`, `paidAt`, `paymentRef`, `schemaVersion`                         |

**Подписчики:** FinTech (если оплата через банк компании), Data Platform (выручка), уведомления пациенту (отдельный адаптер).

---

## Финтех

| Событие                 | Источник | Семантика                  | Минимальный контракт                                                                    |
|-------------------------|----------|----------------------------|-----------------------------------------------------------------------------------------|
| `CreditContractCreated` | FinTech  | Оформлен кредитный договор | `creditContractId`, `customerId`, `principal`, `currency`, `createdAt`, `schemaVersion` |
| `PaymentSettled`        | FinTech  | Платёж проведён и сверен   | `paymentId`, `invoiceId`, `amount`, `settledAt`, `schemaVersion`                        |

**Подписчики:** Billing (закрытие задолженности), Data Platform (финансовые витрины), риск-контур (отдельный bounded context в перспективе).

---

## Склад / оборудование

| Событие             | Источник           | Семантика                                | Минимальный контракт                                          |
|---------------------|--------------------|------------------------------------------|---------------------------------------------------------------|
| `InventoryReserved` | Supply & Equipment | Зарезервированы расходники под процедуру | `reservationId`, `episodeId`, `skuId`, `qty`, `schemaVersion` |
| `InventoryIssued`   | Supply & Equipment | Списание со склада                       | `reservationId`, `issuedAt`, `schemaVersion`                  |

**Подписчики:** Clinical Operations (статус обеспеченности), Data Platform (себестоимость/оборачиваемость на агрегированном уровне).
