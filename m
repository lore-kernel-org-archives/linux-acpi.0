From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 3/6] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Fri, 30 Jun 2006 14:21:24 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16BA7@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4526 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932079AbWF3SVZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 14:21:25 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, bcollins@ubuntu.com, "Yu, Luming" <luming.yu@intel.com>

NAK

this entry has already been added elsewhere in the table
in the acpi release tree waiting for Linus.

http://kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=comm
it;h=f831335d42a9aed26449a264266763fb542dbbe3


-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, June 30, 2006 5:15 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>randy.dunlap@oracle.com; bcollins@ubuntu.com; Yu, Luming
>Subject: [patch 3/6] acpi: Add IBM R60E laptop to proc-idle blacklist
>
>From: Randy Dunlap <randy.dunlap@oracle.com>
>
>Reference: 
>https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.1
>5/+bug/38228
>http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-d
apper.git;a=commit;h=ce5e62bc55056049d192c422b6032f6a406e0ba2
>
>Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: "Yu, Luming" <luming.yu@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/processor_idle.c |    3 +++
> 1 file changed, 3 insertions(+)
>
>diff -puN 
>drivers/acpi/processor_idle.c~acpi-add-ibm-r60e-laptop-to-proc-
>idle-blacklist drivers/acpi/processor_idle.c
>--- 
>a/drivers/acpi/processor_idle.c~acpi-add-ibm-r60e-laptop-to-pro
>c-idle-blacklist
>+++ a/drivers/acpi/processor_idle.c
>@@ -145,6 +145,9 @@ static struct dmi_system_id __cpuinitdat
> 	{ set_max_cstate, "IBM ThinkPad R40e", {
> 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
>+	{ set_max_cstate, "IBM ThinkPad R40e", {
>+	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
>+	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
> 	{ set_max_cstate, "Medion 41700", {
> 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
> 	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
>_
>
