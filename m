From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/9] ACPI / LPSS: allow to use specific PM domain during ->probe()
Date: Fri,  4 Dec 2015 23:49:19 +0200
Message-ID: <1449265765-9393-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is an amendment to previously pushed commit 01ac170ba29a (ACPI / LPSS:
allow to use specific PM domain during ->probe()). We can't assign anything to
the platform device on ADD_DEVICE stage since it might be changed during
unbound / bind cycle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index da0e276..6263939 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -705,9 +705,10 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	}
 
 	switch (action) {
-	case BUS_NOTIFY_BOUND_DRIVER:
+	case BUS_NOTIFY_BIND_DRIVER:
 		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
 		break;
+	case BUS_NOTIFY_DRIVER_NOT_BOUND:
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		pdev->dev.pm_domain = NULL;
 		break;
-- 
2.6.2
