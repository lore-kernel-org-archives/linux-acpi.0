From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI _SUN
Date: Mon, 22 Jan 2007 02:00:32 -0500
Message-ID: <200701220200.32798.lenb@kernel.org>
References: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com> <20070119163749.GU4945@poupinou.org> <80b0b9460701212125h263a625cr1a8b43853a444591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52648 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbXAVHCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jan 2007 02:02:00 -0500
In-Reply-To: <80b0b9460701212125h263a625cr1a8b43853a444591@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mohan Kumar Jami <mohan124885@gmail.com>
Cc: Bruno Ducrot <ducrot@poupinou.org>, linux-acpi@vger.kernel.org

On Monday 22 January 2007 00:25, Mohan Kumar Jami wrote:
> Hi
> 
> 
> 1) I saw the _SUN object in DSDT table as "Name (_SUN, 0x01)", is this
> means that this slot number is fixed or is that going to change at
> run-time.

fixed.

> 2) Is there any other way to get the PCI slot number using ACPI tables?

PCI doesn't have slot numbers, it has device numbers.
you can get these from PCI (eg lspci),

SUN is supposed to be some sort of human-friendly number --
eg the number that is printed on the motherboard on the chassis.
 
> 3) How do I know that a perticular slot is populated, in user space.
> Is there any system call to know that?

no

> 4) Is it possible to override the AML, if yes can you please tell us
> how to do it?

yes.
you can replace your DSDT either by loading a new one in the initrd
or compiling a new one into the kernel.

Exactly what are you thing to do?

-Len

> 
> 
> On 1/19/07, Bruno Ducrot <ducrot@poupinou.org> wrote:
> > On Fri, Jan 19, 2007 at 03:26:26PM +0530, Mohan Kumar Jami wrote:
> > > Hi,
> > >
> > > I have couple of questions related to _SUN object.
> > >
> > > 1) Is _SUN object be present DSDT tables?
> >
> > They are defined under DSDT or RSDT tables as any other ACPI objects
> > populating the ACPI namespace.
> >
> > > 2) How this DSDT table get updated?
> >
> > They can't be updated.
> >
> > > 3) Is DSDT table is static binary file or it can be dynamically updated?
> >
> > A DSDT table is not a static binary file.  On most i386 or amd64
> > architectures, DSDT and SSDT are part of the BIOS.
> > The BIOS uncompressed and copyied them into main memory at the
> > POST stage since the ROM is too limited in size.
> >
> > > 4) Who will update the DSDT tables?
> >
> > By the customer via BIOS updates obtained from the vendor.
> >
> > Cheers,
> >
> > --
> > Bruno Ducrot
> >
> > --  Which is worse:  ignorance or apathy?
> > --  Don't know.  Don't care.
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
