From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 2/2] i2c:dw: Add APM X-Gene ACPI I2C device support
Date: Thu, 10 Dec 2015 14:19:17 -0700
Message-ID: <1449782357-22982-3-git-send-email-lho@apm.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1449782357-22982-1-git-send-email-lho@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, Ken.Xue@amd.com, Jeff.Wu@amd.com, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lenb@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>
List-Id: linux-acpi@vger.kernel.org

Enable APM X-Gene ACPI I2C device support by adding the
corresponding ACPI ID. The platform ACPI APD corresponding
change is required to provide the proper clock frequency input.

Signed-off-by: Loc Ho <lho@apm.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 809579e..423371d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -117,6 +117,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
 	{ "AMD0010", 0 },
+	{ "APMC0D0F", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.7.1
