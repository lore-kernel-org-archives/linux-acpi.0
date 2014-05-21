From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: rmmod thermal, unable to handle kernel NULL pointer dereference
Date: Wed, 21 May 2014 16:22:58 +0800
Message-ID: <537C6262.5030500@intel.com>
References: <CAKx2Y1mzLesGFYz30fH8xCZTkvNGPUNYkHptYLYq_hVExoh_8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKx2Y1mzLesGFYz30fH8xCZTkvNGPUNYkHptYLYq_hVExoh_8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kui Zhang <kuizhang@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 05/21/2014 01:57 PM, Kui Zhang wrote:
> Hello,
> 
> I get following error when rmmod thermal.
> 
> rmmod  thermal
> Killed

Thanks for the report. Here is a fix patch that should solve this
problem.

From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 21 May 2014 16:00:42 +0800
Subject: [PATCH] ACPI / thermal: fix workqueue destroy order

When the thermal module is to be removed, we should destroy the wq
acpi_thermal_pm_queue after the ACPI driver's remove callback is
executed as we will need to flush the workqueue there, or a NULL pointer
access will be hit.

Reported-by: Kui Zhang <kuizhang@gmail.com>
Reference: http://www.spinics.net/lists/kernel/msg1747251.html
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c1e31a41f949..25bbc55dca89 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1278,8 +1278,8 @@ static int __init acpi_thermal_init(void)
 
 static void __exit acpi_thermal_exit(void)
 {
-	destroy_workqueue(acpi_thermal_pm_queue);
 	acpi_bus_unregister_driver(&acpi_thermal_driver);
+	destroy_workqueue(acpi_thermal_pm_queue);
 
 	return;
 }
-- 
1.9.0
