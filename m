From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Wed, 15 Jan 2014 22:42:31 +0800
Message-ID: <52D69E57.5020208@intel.com>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com> <5255063.SeYbBZqxVQ@vostro.rjw.lan> <20140114212406.GA25438@srcf.ucam.org> <4100200.O09E65sAKi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15839 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaAOOml (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jan 2014 09:42:41 -0500
In-Reply-To: <4100200.O09E65sAKi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org, "Zheng, Lv" <lv.zheng@intel.com>, robert.moore@intel.com

On 01/15/2014 06:17 AM, Rafael J. Wysocki wrote:
> On Tuesday, January 14, 2014 09:24:06 PM Matthew Garrett wrote:
>> On Tue, Jan 14, 2014 at 10:37:02PM +0100, Rafael J. Wysocki wrote:
>>> On Tuesday, January 14, 2014 04:06:01 PM Matthew Garrett wrote:
>>>> On Mon, Jan 06, 2014 at 11:25:53PM +0100, Rafael J. Wysocki wrote:
>>>>
>>>>> Queued up as a fix for 3.13 (I fixed up the indentation).
>>>>
>>>> Ah, sorry, I missed this chunk of the thread. If the system provides
>>>> valid _BIF data then we should possibly just fall back to that rather
>>>> than adding another quirk table.
>>>
>>> The problem is to know that _BIX is broken.  If we could figure that out
>>> upfront, we woulnd't need the quirk table in any case.
>>
>> It's obvious that it is in this case - the package is the wrong size.
>
> Then Tianyu should be able to come up with a better fix relatively easily. :-)
>
Hi Rafael&Matthew:

	I think we can evaluate _BIX before setting ACPI_BATTERY_XINFO_PRESENT 
flag. CA routine(acpi_ns_check_package) will check the package size and 
return error code when there is wrong size package.

Something like this.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fbf1ace..e98fa83 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -770,7 +770,7 @@ static int acpi_battery_add(struct acpi_device *device)
         device->driver_data = battery;
         mutex_init(&battery->lock);
         mutex_init(&battery->sysfs_lock);
-       if (acpi_has_method(battery->device->handle, "_BIX"))
+       if (acpi_evaluate_object(device->handle, "_BIX", NULL, &buffer);)
                 set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
         result = acpi_battery_update(battery);
         if (result)


-- 
Best Regards
Tianyu Lan
