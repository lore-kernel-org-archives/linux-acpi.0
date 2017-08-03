From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 3/7] ACPI / APEI: add OSC APEI bit check for ghes_edac
Date: Thu,  3 Aug 2017 15:57:49 -0600
Message-ID: <20170803215753.30553-4-toshi.kani@hpe.com>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803215753.30553-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-acpi@vger.kernel.org

When 'osc_sb_apei_support_acked' is set, it indicates that
the platform supports APEI, firmware-first mode, as ACPI _OSC
capability bit 4, APEI Support, was set in query.  While _OSC
is an optional method, platforms with APEI support should
implement it to inform its capability to the OS properly.

Add check to 'osc_sb_apei_support_acked' before calling
ghes_edac_register() to restrict that ghes_edac is enabled
on platforms with APEI support capability set in _OSC.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/ghes.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..49d75eb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1139,9 +1139,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		goto err;
 	}
 
-	rc = ghes_edac_register(ghes, &ghes_dev->dev);
-	if (rc < 0)
-		goto err;
+	if (osc_sb_apei_support_acked) {
+		rc = ghes_edac_register(ghes, &ghes_dev->dev);
+		if (rc < 0)
+			goto err;
+	}
 
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
