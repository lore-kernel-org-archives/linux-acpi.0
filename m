From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI _SUN
Date: Mon, 22 Jan 2007 19:16:48 -0500
Message-ID: <200701221916.48740.lenb@kernel.org>
References: <80b0b9460701190156l7a7f95cdnc442787f7fb37b15@mail.gmail.com> <200701220200.32798.lenb@kernel.org> <80b0b9460701220006p4b8dc3a6i9bf274a63f679036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42048 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932560AbXAWASL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jan 2007 19:18:11 -0500
In-Reply-To: <80b0b9460701220006p4b8dc3a6i9bf274a63f679036@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mohan Kumar Jami <mohan124885@gmail.com>
Cc: Bruno Ducrot <ducrot@poupinou.org>, linux-acpi@vger.kernel.org

On Monday 22 January 2007 03:06, Mohan Kumar Jami wrote:
> Hi,
> 
> Actually we need to retrieve the slot number (Using _SUN object) for
> PCI where it is inserted.
> But when we have gone through the DSDT table (SMBIOS version 2.3) , is
> not having _SUN entry.
> Is presence of _SUN is related to BIOS issue?
> Is there any difference between SMBIOS and ACPI bios?
> Is _SUN is optional in SMBIOS version 2.5
> I didn't clear  about
>                            Name (_SUN, 0x01)
> Is that 0x01 is slot number or not?

_SUN is a number that the system vendors thinks will
mean something to a human.  Eg it may correspond
to a number painted on the outside of a machine.

It  doesn't necessarily have anything to do with electrical
or logical slot numbers on a PCI bus, or any other bus
for that matter.

SMBIOS and ACPI BIOS are independent features of a BIOS.
You can have one, the other, both, or neither.

cheers,
-Len
