From: "Mohan Kumar Jami" <mohan124885@gmail.com>
Subject: Re: ACPI _SUN
Date: Mon, 22 Jan 2007 10:55:12 +0530
Message-ID: <80b0b9460701212125h263a625cr1a8b43853a444591@mail.gmail.com>
References: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com>
	 <20070119163749.GU4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:8021 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXAVFZN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jan 2007 00:25:13 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1255399wxd
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jan 2007 21:25:12 -0800 (PST)
In-Reply-To: <20070119163749.GU4945@poupinou.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: linux-acpi@vger.kernel.org

Hi


1) I saw the _SUN object in DSDT table as "Name (_SUN, 0x01)", is this
means that this slot number is fixed or is that going to change at
run-time.

2) Is there any other way to get the PCI slot number using ACPI tables?

3) How do I know that a perticular slot is populated, in user space.
Is there any system call to know that?

4) Is it possible to override the AML, if yes can you please tell us
how to do it?


On 1/19/07, Bruno Ducrot <ducrot@poupinou.org> wrote:
> On Fri, Jan 19, 2007 at 03:26:26PM +0530, Mohan Kumar Jami wrote:
> > Hi,
> >
> > I have couple of questions related to _SUN object.
> >
> > 1) Is _SUN object be present DSDT tables?
>
> They are defined under DSDT or RSDT tables as any other ACPI objects
> populating the ACPI namespace.
>
> > 2) How this DSDT table get updated?
>
> They can't be updated.
>
> > 3) Is DSDT table is static binary file or it can be dynamically updated?
>
> A DSDT table is not a static binary file.  On most i386 or amd64
> architectures, DSDT and SSDT are part of the BIOS.
> The BIOS uncompressed and copyied them into main memory at the
> POST stage since the ROM is too limited in size.
>
> > 4) Who will update the DSDT tables?
>
> By the customer via BIOS updates obtained from the vendor.
>
> Cheers,
>
> --
> Bruno Ducrot
>
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>
