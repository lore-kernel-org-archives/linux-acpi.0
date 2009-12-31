From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: "acpi_apic_instance=0" works better
Date: Thu, 31 Dec 2009 08:50:17 +0800
Message-ID: <1262220617.12263.1404.camel@rzhang1-desktop>
References: <7a6792140912301241m189685fk4e5081a1e12674b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63090 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbZLaAth (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Dec 2009 19:49:37 -0500
In-Reply-To: <7a6792140912301241m189685fk4e5081a1e12674b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: NewMaverick <sarthorks@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-12-31 at 04:41 +0800, NewMaverick wrote:
> Hello
> 
> Here is some DMI info from kernel log:
> Dec 31 02:03:02 sarthorks kernel: [   16.717511] ACPI: DMI System Vendor: LENOVO
> Dec 31 02:03:02 sarthorks kernel: [   16.717513] ACPI: DMI Product Name: 0769AB2
> Dec 31 02:03:02 sarthorks kernel: [   16.717515] ACPI: DMI Product
> Version: 3000 N200
> Dec 31 02:03:02 sarthorks kernel: [   16.717517] ACPI: DMI Board Name: IEL10
> Dec 31 02:03:02 sarthorks kernel: [   16.717518] ACPI: DMI BIOS Vendor: LENOVO
> Dec 31 02:03:02 sarthorks kernel: [   16.717520] ACPI: DMI BIOS Date: 12/21/2007
> 
> After one and a half years (with regular updates), my hardy started
> causing trouble at boot time, and "acpi=off" could fix the trouble.
> 
> However, after looking at the logs, i tried this
> "acpi_apic_instance=0", and now acpi is on, and there's no problem.
> Hope this helps.
> 
acpi_apic_instance is 0 by default.
did you use acpi_apic_instance=1 before?
If not, acpi_apic_instance=0 won't bring any difference.
please attach the acpidump output.

thanks,
rui

> Sarthak Parikh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


