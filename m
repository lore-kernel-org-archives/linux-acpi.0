From: Thomas Renninger <trenn@suse.de>
Subject: Re: Help on a ACPI error message during kernel boot
Date: Mon, 02 Oct 2006 22:43:25 +0200
Message-ID: <1159821805.3610.461.camel@queen.suse.de>
References: <ac8af0be0609281945y7eb5129bp61e9fc7b489cf838@mail.gmail.com>
	 <200609291315.24865.luming.yu@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:51386 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964996AbWJBUeA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2006 16:34:00 -0400
In-Reply-To: <200609291315.24865.luming.yu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>, linux-acpi@vger.kernel.org

On Fri, 2006-09-29 at 13:15 +0800, Yu Luming wrote:
> >  When booting the linux on my hardware, ACPI output some error messages
> >  like this:
> >
> >  PCI: Using configuration type 1
> >      ACPI-1121: *** Error: Method execution failed [\_SB_.LNKA._STA]
> >  (Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
> >      ACPI-0098: *** Error: Method execution failed [\_SB_.LNKA._STA]
> >  (Node 0000010011dcb6c0), AE_AML_REGION_LIMIT
> >      ACPI-1121: *** Error: Method execution failed [\_SB_.LNKB._STA]
> >  (Node 0000010011dcb8c0), AE_AML_REGION_LIMIT
> >      ACPI-0098: *** Error: Method execution failed [\_SB_.LNKB._STA]
> >  (Node 0000010011dcb8c0), AE_AML_REGION_LIMIT
> 
> what's kernel version?
> Looks like a AML interpreter issue.
> Please open a bug on bugzilla.kernel.org,
> and post acpidump output.

Could you pls CC me if you open a bug.

Thanks,

   Thomas

