From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: udev broken by recent ACPI git commits
Date: Wed, 1 Nov 2006 21:00:16 +0100
Message-ID: <200611012100.16836.rjw@sisk.pl>
References: <200611010004.28483.rjw@sisk.pl> <200611011844.30280.rjw@sisk.pl> <4548F530.3000206@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:21940 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S2992795AbWKAUCC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 15:02:02 -0500
In-Reply-To: <4548F530.3000206@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Andrew Morton <akpm@osdl.org>

Hi,

On Wednesday, 1 November 2006 20:27, Alexey Starikovskiy wrote:
> Rafael,
> 
> I don't see what is wrong with failure log, do you?

No, there's nothing obviously wrong with it I think.  Still udev doesn't work
properly with this kernel.

> If only audit init number looks too big, did you try to disable it (audit)?

Yes, I did, but it had no apparent effect.

> < audit(1162401734.092:1): initialized
> ---
> > audit(18446744012389200479.076:1): initialized
> 289,290c291,292
> < ata1: SATA max UDMA/100 cmd 0xFFFFC2000000C080 ctl 0xFFFFC2000000C08A bmdma 0xFFFFC2000000C000 irq 16
> < ata2: SATA max UDMA/100 cmd 0xFFFFC2000000C0C0 ctl 0xFFFFC2000000C0CA bmdma 0xFFFFC2000000C008 irq 16
> ---
> > ata1: SATA max UDMA/100 cmd 0xFFFFC20000020080 ctl 0xFFFFC2000002008A bmdma 0xFFFFC20000020000 irq 16
> > ata2: SATA max UDMA/100 cmd 0xFFFFC200000200C0 ctl 0xFFFFC200000200CA bmdma 0xFFFFC20000020008 irq 16
> Addresses for disk seem to be different too...

Yes, and that smells bad, because theoretically there's no reason for which
they could be different.  FWIW, 2.6.19-rc4-mm1 shows the same addresses
as the 'good' one above.

Greetings,
Rafael


> Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Wednesday, 1 November 2006 14:03, Alexey Starikovskiy wrote:
> >> Rafael,
> >>
> >> Is it possible to get any log from failed and normal boot?
> > 
> > Attached are dmesg outputs for both cases.
> > 
> > The good one is 2.6.19-rc3 with
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-test-20060707-2.6.19-rc3.diff.gz
> > applied.
> > 
> > The failing one is 2.6.19-rc3 with
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.19/acpi-acpica-20061011-2.6.19-rc3.diff.gz
> > applied.
> > 
> > Greetings,
> > Rafael
> > 
> > 
> 
> 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
