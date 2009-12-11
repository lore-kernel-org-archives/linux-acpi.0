From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: support customizing ACPI control methods at runtime
Date: Fri, 11 Dec 2009 10:54:57 +0100
Message-ID: <200912111054.58857.trenn@suse.de>
References: <1259731860.2029.1221.camel@rzhang1-desktop> <alpine.LFD.2.00.0912110150310.6502@localhost.localdomain> <037F493892196B458CD3E193E8EBAD4F01F03F4A2A@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbZLKJyx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2009 04:54:53 -0500
In-Reply-To: <037F493892196B458CD3E193E8EBAD4F01F03F4A2A@pdsmsx502.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 11 December 2009 08:25:49 Zhang, Rui wrote:
> Do you mean some kernel info that suggests an acpi
> control method is overridden by users?
Tainting is used for distris to verify whether the customer
still has support and shows up in kernel oopses, dmesg, etc.
It can also be useful for bugzilla logs, so that developers
quickly get an idea that the user has done something he
should not do.

With
grep TAINT include/linux/kernel.h
you see possible reasons to taint a kernel.

Adding:
   add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
when the user successfully modified an AML method should
get added.

Thanks,

    Thomas

