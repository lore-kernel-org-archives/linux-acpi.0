From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Wed, 03 Apr 2013 00:49:08 +0200
Message-ID: <5030643.tE4LAX0txW@vostro.rjw.lan>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <515AF312.1010507@fold.natur.cuni.cz> <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50386 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab3DBWle (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Apr 2013 18:41:34 -0400
In-Reply-To: <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, huang ying <huang.ying.caritas@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Tuesday, April 02, 2013 10:30:54 AM Bjorn Helgaas wrote:
> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
> > Hi Ying,
> >
> > huang ying wrote:
> 
> >> And please give me the full dmesg for boot and incremental dmesg for
> >> operations.
> >
> >
> > The incremental bits here, the full dmesg will send only directly to your email, due to its size.
> 
> Is there a bugzilla for this issue?  Please attach the complete dmesg
> there or somewhere similar so we can all benefit.
> 
> I think we have two problems that may be relevant to this discussion.
> 
> 1) The _OSC "PCI Express Capability Structure control" bit.  I don't
> think Linux pays attention to whether the BIOS has granted us control
> over the capability, so we may do things to it that the BIOS doesn't
> expect.

Yes, it does, as far as I can say.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
