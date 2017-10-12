From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ACPI: mark expected switch fall-throughs
Date: Thu, 12 Oct 2017 13:49:18 -0500
Message-ID: <20171012184918.GA17821@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-acpi@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
This code was tested by compilation only (GCC 7.2.0 was used).
Please, verify if the actual intention of the code is to fall through.

 drivers/acpi/ac.c             | 1 +
 drivers/acpi/acpi_processor.c | 1 +
 drivers/acpi/dock.c           | 1 +
 drivers/acpi/resource.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 8f52483..47a7ed5 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -265,6 +265,7 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
+	/* fall through */
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 86c1059..449d86d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -82,6 +82,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * PIIX4 models.
 		 */
 		errata.piix4.throttle = 1;
+		/* fall through*/
 
 	case 2:		/* PIIX4E */
 	case 3:		/* PIIX4M */
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 2305e1a..e3fc1f0 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -482,6 +482,7 @@ int dock_notify(struct acpi_device *adev, u32 event)
 		surprise_removal = 1;
 		event = ACPI_NOTIFY_EJECT_REQUEST;
 		/* Fall back */
+		/* fall through */
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		begin_undock(ds);
 		if ((immediate_undock && !(ds->flags & DOCK_IS_ATA))
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d85e010..316a0fc 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -381,6 +381,7 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 	case ACPI_ACTIVE_BOTH:
 		if (triggering == ACPI_EDGE_SENSITIVE)
 			return IRQ_TYPE_EDGE_BOTH;
+		/* fall through */
 	default:
 		return IRQ_TYPE_NONE;
 	}
-- 
2.7.4
