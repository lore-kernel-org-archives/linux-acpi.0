From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] ACPI: support customizing ACPI control methods at
 runtime
Date: Fri, 11 Dec 2009 15:25:49 +0800
Message-ID: <037F493892196B458CD3E193E8EBAD4F01F03F4A2A@pdsmsx502.ccr.corp.intel.com>
References: <1259731860.2029.1221.camel@rzhang1-desktop>
 <200912021134.58846.trenn@suse.de>
 <alpine.LFD.2.00.0912110150310.6502@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9197 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbZLKH0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 02:26:00 -0500
In-Reply-To: <alpine.LFD.2.00.0912110150310.6502@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Do you mean some kernel info that suggests an acpi control method is overridden by users?

Thanks,
rui

-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org] 
Sent: Friday, December 11, 2009 2:51 PM
To: Thomas Renninger
Cc: Zhang, Rui; linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: support customizing ACPI control methods at runtime


On Wed, 2 Dec 2009, Thomas Renninger wrote:

> On Wednesday 02 December 2009 06:31:00 Zhang Rui wrote:
> > 
> > Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method) for ACPI,
> > which can be used to customize the ACPI control methods at runtime.
> Still no kernel tainting on a successful override?
> On purpose or unintended?

unintended.

Rui, please send a follow-on patch to taint,
just like when we override the DSDT.

thanks,
-Len Brown, Intel Open Source Technology Center

