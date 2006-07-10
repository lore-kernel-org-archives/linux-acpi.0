From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch] fix boot with acpi=off
Date: Mon, 10 Jul 2006 14:37:53 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ED0026@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27689 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422756AbWGJSiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2006 14:38:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Lebedev, Vladimir P 
>Sent: Monday, July 10, 2006 2:08 PM
>To: Brown, Len; 'Pavel Machek'; 'kernel list'; 'Andrew Morton'
>Cc: 'linux-acpi@vger.kernel.org'
>Subject: RE: [patch] fix boot with acpi=off
>
>> acpi=off used to be handled by acpi_bus_register_driver()
>> for these drivers.
>
>> But now acpi_lock_ac_dir() and acpi_lock_battery_dir()
>> for procfs are inserted before that in the _init functions.
>This is fragment from SBS patch. 
>-----------------------------------------
> 	ACPI_FUNCTION_TRACE("acpi_ac_init");
> 
>-	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
>+	acpi_ac_dir = acpi_lock_ac_dir();
> 	if (!acpi_ac_dir)
> 		return_VALUE(-ENODEV);
>-	acpi_ac_dir->owner = THIS_MODULE;
> 
> 	result = acpi_bus_register_driver(&acpi_ac_driver);
> 	if (result < 0) {
>-		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
>+		acpi_unlock_ac_dir(acpi_ac_dir);
> 		return_VALUE(-ENODEV);
> 	}
>------------------------------------------
>Order of proc_mkdir and acpi_bus_register_driver is the same 
>as order of acpi_lock_ac_dir. Could you explain what you meant?
>
>>Vladimir,
>>Any reason that the procfs stuff can't be after the 
>>acpi_bus_register_driver()
>>calls?
>
>If we move it after acpi_bus_register_driver(), calls to 
>create files inside battery/ac directories (called from 
>acpi_bus_register_driver via acpi_{battery,ac}_add()) will fail. 

ic.

Dunno why acpi_lock_ac_dir() makes pavel's box fail w/ acpi=off.
maybe we should simply extend his patch to cover sbs.c and
check acpi_disabled at the start of init of these drivers?

-Len
