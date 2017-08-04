From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: [PATCH 2/2] ACPI: SPCR: work around clock issue on xgene UART
Date: Fri,  4 Aug 2017 22:49:44 +0100
Message-ID: <20170804214944.3910-3-graeme.gregory@linaro.org>
References: <20170804214944.3910-1-graeme.gregory@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804214944.3910-1-graeme.gregory@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, lho@apm.com, gregkh@linuxfoundation.org, jcm@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

xgene v1/v2 8250 UARTs don't run at the standard clock rate expected by
the driver and there is no information on clocking available from the
SPCR table. As there has been no progress on relevant vendors updating
DBG2/SPCR specifications to fix this work around this using the previous
xgene quirk handling to avoid setting a baud rate and therefore using
the UART as configured by firmware.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/spcr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 1457ef0b0fd5..a57e2698df39 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -156,11 +156,19 @@ int __init parse_spcr(bool earlycon)
 
 	if (qdf2400_erratum_44_present(&table->header))
 		uart = "qdf2400_e44";
-	if (xgene_8250_erratum_present(table))
+	if (xgene_8250_erratum_present(table)) {
 		iotype = "mmio32";
 
-	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
-		 table->serial_port.address, baud_rate);
+		/* for xgene v1 and v2 we don't know the clock rate of the
+		 * UART so don't attempt to change to the baud rate state
+		 * in the table because driver cannot calculate the dividers
+		 */
+		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
+			 table->serial_port.address);
+	} else {
+		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
+			 table->serial_port.address, baud_rate);
+	}
 
 	pr_info("console: %s\n", opts);
 
-- 
2.13.4
