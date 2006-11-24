From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Fri, 24 Nov 2006 14:01:20 +0800
Message-ID: <1164348080.5768.32.camel@localhost.localdomain>
References: <1158916460.11985.45.camel@localhost.localdomain>
	 <200611222307.26536.len.brown@intel.com>
	 <1164257655.5461.96.camel@localhost.localdomain>
	 <200611232338.06895.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15002 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S934429AbWKXF6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:58:00 -0500
In-Reply-To: <200611232338.06895.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2006-11-23 at 23:38 -0500, Len Brown wrote:
> On Wednesday 22 November 2006 23:54, Zhang Rui wrote:
> > This is caused by some changes in driver model.
> > I sent the updated patches to you on 31 Oct.
> > I think you forget to apply them. :)
> 
> You're right, we talked about this and you sent it to my internal
> e-mail account and not to the list, so I didn't notice it when I
> applied the series from the list.
> 
> In general, please keep the updates on the list so folks
> (besides me) know they're making progress and can follow it.
> 
> So now the T30 boots and runs, but ibm_acpi complains:
> 
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Thermal Zone [THM0] (54 C)
> ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
> ibm_acpi: http://ibm-acpi.sf.net/
> kobject_add failed for ibm/hotkey (-13)
>  [<c0230939>] kobject_add+0x15d/0x185
>  [<c023059d>] kobject_get+0x15/0x1a
>  [<c0230b37>] kobject_register+0x21/0x3e
>  [<c02b62c0>] bus_add_driver+0x51/0x16e
>  [<f891e4f9>] acpi_ibm_init+0x4a2/0x63e [ibm_acpi]
>  [<c013d643>] sys_init_module+0x16fd/0x1835
>  [<c0161d71>] sys_read+0x4b/0x71
>  [<c0102e79>] sysenter_past_esp+0x56/0x79
>  =======================
> ibm_acpi: acpi_bus_register_driver(IBM0068) failed: -13
The problem is the driver name "ibm/hotkey".
'/' and "\0" can not exist in an kobject->name.
In driver/acpi/ibm_acpi.c line 1828, please replace the '/' with '-' or
any other character and try again :)
