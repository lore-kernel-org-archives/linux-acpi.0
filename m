From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Wed, 25 Oct 2006 20:35:30 +0400
Message-ID: <453F9252.9060404@linux.intel.com>
References: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040508020004080304060003"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21025 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1423233AbWJYQfg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 12:35:36 -0400
In-Reply-To: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040508020004080304060003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here is a least intrusive patch by my opinion...
Just copy pm_disk_mode from pm_ops supplied by platform.
ACPI sets it to PM_DISK_PLATFORM if it has S4,
and it should be zero otherwise, patch does not copy it then.

Regards,
	Alex.

Yu, Luming wrote:
>> There is a problem with swsuspend and GPE events.
>> Now they are restored from acpi_pm_finish(), which is called only if we
>> suspend with "platform" option, what means that if we suspended to disk
>> with the default "shutdown" option after resume all the GPEs 
>> will be disabled.
>> This presents us with the overheating problem after resume at 
>> very least.
>> I see two solutions: one is to make "platform" to be default 
>> option if ACPI is enabled,
>> and second -- enable GPE events from some other function, 
>> which will be called in any case.
>>
>> What do you think?
>>
> 
> I prefer platform S4 as default...
> 
> --Luming
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--------------040508020004080304060003
Content-Type: text/x-patch;
 name="copy_pm_disk_mode_from_pm_ops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="copy_pm_disk_mode_from_pm_ops.patch"

Copy non-null pm_disk_mode option from pm_ops.

From:  Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>


---

 kernel/power/main.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 873228c..2085611 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -38,6 +38,8 @@ void pm_set_ops(struct pm_ops * ops)
 {
 	down(&pm_sem);
 	pm_ops = ops;
+	if (pm_ops && pm_ops->pm_disk_mode)
+		pm_disk_mode = pm_ops->pm_disk_mode;
 	up(&pm_sem);
 }
 

--------------040508020004080304060003--
