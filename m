From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 0/2] Correct for ACPI 5.1->6.0 spec changes in MADT
 GICC entries
Date: Tue, 7 Jul 2015 08:40:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507070839590.3916@nanos>
References: <1436224608-27754-1-git-send-email-al.stone@linaro.org> <CAJZ5v0j+iKhOX4hw2XQEdo9CjpP2sfdxGwCz_vN5OVqithEv0Q@mail.gmail.com> <559B1324.8000301@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58651 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbGGGkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2015 02:40:39 -0400
In-Reply-To: <559B1324.8000301@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <al.stone@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, 6 Jul 2015, Al Stone wrote:
> On 07/06/2015 05:20 PM, Rafael J. Wysocki wrote:
> > Hi Al,
> > 
> > On Tue, Jul 7, 2015 at 1:16 AM, Al Stone <al.stone@linaro.org> wrote:
> >> In the ACPI 5.1 version of the spec, the struct for the GICC subtable
> >> (struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
> >> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
> >> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
> >> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
> >> subtable, it fails if 5.1 structs are in use, and there are systems in
> >> the wild that have them.
> >>
> >> Note that this was found in linux-next and these patches apply against
> >> that tree and the arm64 kernel tree; 4.1 does not appear to have this
> >> problem since it still has the 5.1 struct definition.
> >>
> >> Though there is precedent in ia64 code for ignoring the changes in size,
> >> this patch set instead verifies correctness.  The first patch adds the
> >> BAD_MADT_GICC_ENTRY() macro to check the GICC subtable only, accounting
> >> for the difference in specification versions that are possible.  The
> >> second patch replaces BAD_MADT_ENTRY usage with the BAD_MADT_GICC_ENTRY
> >> macro in arm64 code, which is currently the only architecture affected.
> >> The BAD_MADT_ENTRY() will continue to work as is for all other MADT
> >> subtables.
> >>
> >> I have tested these patches on an APM Mustang with version 1.15 firmware,
> >> where the problem was found, and they fix the problem -- i.e., the system
> >> will boot with either Linux 4.1 or linux-next kernels using the same ACPI
> >> 5.1 compatible firmware.
> > 
> > ACK for the series, but I guess it's better to let it go via ARM64, right?
> > 
> > Rafael
> 
> Thanks, Rafael.  Yeah, probably so.  Will has ACKd the one patch
> (2/2); if he and/or Catalin ACK patch 1/2, then this seems like it
> would pretty cleanly fit into ARM64.  The only question would be if
> Will or Catalin would want an ACK from Thomas on the irq-gic.c part
> in 2/2.

No objections from my side.

Thanks,

	tglx
