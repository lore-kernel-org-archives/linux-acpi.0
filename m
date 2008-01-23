From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI dmidecode output requested in dmesg output - Dell Dimension 5150
Date: Wed, 23 Jan 2008 00:43:00 -0500
Message-ID: <200801230043.00157.lenb@kernel.org>
References: <46EBBC58.10200@takelap.com> <200801212157.47125.lenb@kernel.org> <5aedf440801220956h3f99cbffp97c664fdea0ef571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37721 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbYAWFnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 00:43:14 -0500
In-Reply-To: <5aedf440801220956h3f99cbffp97c664fdea0ef571@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graham Adams <gadams@takelap.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 22 January 2008 12:56, you wrote:
> On 1/22/08, Len Brown <lenb@kernel.org> wrote:
> > On Monday 21 January 2008 12:28, Graham Adams wrote:
> > > On 1/19/08, Len Brown <lenb@kernel.org> wrote:
> > > >
> > > > > Please find attached the output of dmidecode after booting with
> > > > > acpi_osi=!Linux as requested in dmesg output.  The system seems to be
> > > > > working OK apart from problems with STAC9221 Line In (which has never
> > > > > worked under Linux).
> > > >
> > > > > The system is a Dell Dimension 5150.
> > > >
> > > > > System Information
> > > > > Manufacturer: Dell Inc.
> > > > > Product Name: Dell DM051
> > > > > Version: Not Specified
> > > > > Serial Number: 6X8B32J
> > > > > UUID: 44454C4C-5800-1038-8042-B6C04F33324A
> > > > > Wake-up Type: Power Switch
> > > > >
> > > > > Handle 0x0200, DMI type 2, 8 bytes
> > > > > Base Board Information
> > > > > Manufacturer: Dell Inc.
> > > > > Product Name: 0WG261
> >
> > This is "different"....
> >
> > some magic happens at initialization and at wake from suspend-to-disk
> > to PCI device 00:1d -- which is apparently USB.
> >
> > The code reads as if Dell really did intend to do something special for Linux -
> > at least the version of Linux they were testing...
> >
> > for non-Linux, ISLI does some SMI magic, for Linux the SMI magic is skipped.
> >
> > Does USB work properly in both cases, both before and after suspend to disk?
> >
> > thanks,
> > -Len
> >
> >        Method (ISLI, 0, NotSerialized)
> >         {
> >             If (CondRefOf (_OSI, Local0))
> >             {
> >                 If (_OSI ("Linux"))
> >                 {
> >                     Return (One)
> >                 }
> >                 Else
> >                 {
> >                     Return (Zero)
> >                 }
> >             }
> >             Else
> >             {
> >                 Return (Zero)
> >             }
> >         }
> >
> > ...
> >     Method (GUSB, 0, NotSerialized)
> >     {
> >         If (ISLI ())    # the only reference to ISLI is this one
> >         {
> >             Return (Zero)
> >                 # return valie of GUSB is ignored,
> >                 # so this is the NO-OP path
> >         }
> >         Else
> >         {
> >             Return (SMI2 (0xBA))
> >         }
> >     }
> > ...
> > # surely this is SMI command/SMI Data method:
> > # no telling what the actual command 0xBA is, though...
> >
> >     Method (SMI2, 1, NotSerialized)
> >     {
> >         Acquire (SMIM, 0xFFFF)
> >         Store (Arg0, SMIC)
> >         Store (SMIC, Local0)
> >         Store (SMID, Local0)
> >         ShiftLeft (Local0, 0x08, Local0)
> >         Add (SMIC, Local0, Local0)
> >         Release (SMIM)
> >         Return (Local0)
> >     }
> > ...
> >     Method (_WAK, 1, NotSerialized)
> >     {
> >         If (LEqual (Arg0, 0x04))
> >         {
> > # we come here on wakeup from suspend-to-disk
> >
> >             GUSB ()
> >         }
> >
> >         If (Or (And (PMS2, One), Or (And (LNot (HACK ()),
> >             And (GLBT, 0x11)), And (LNot (HACK ()), And (THRP, 0x18
> >             )))))
> >         {
> >             Notify (\_SB.VBTN, 0x02)
> >         }
> >
> >         Return (Zero)
> >     }
> > ...
> >    Scope (_SB.PCI0)
> >     {
> >         Device (USB0)
> >         {
> >             Name (_ADR, 0x001D0000)
> >             Name (_UID, 0x05)
> >             Name (_PRW, Package (0x02)
> >             {
> >                 0x03,
> >                 0x03
> >             })
> >             OperationRegion (UPC1, PCI_Config, 0xC1, One)
> >             Field (UPC1, ByteAcc, NoLock, Preserve)
> >             {
> >                 LEGK,   8
> >             }
> >
> >             Method (_INI, 0, NotSerialized)
> >             {
> >                 If (HACK ()) {}
> >                 Else
> >                 {
> >                     Store (LEGK, Local0)
> >                     And (Local0, 0x60, Local0)
> >                     Or (Local0, 0x20, Local0)
> >                     Store (Local0, LEGK)
> >                 }
> >
> >                 GUSB ()
> >             }
> >
> > ...
> > This is different too....
> >         Method (_INI, 0, NotSerialized)
> >         {
> >             If (CondRefOf (_OSI, Local0))
> >             {
> >                 If (_OSI ("Windows 2001"))
> >                 {
> >                     Store (0x04, MSOS)
> > # yes, Linux does come here
> > # MSOS is effectively "XP" or newer
> >                 }
> >             }
> >         }
> >
> > ...
> >         Method (HACK, 0, NotSerialized)
> >         {
> >             If (LEqual (MSOS, 0x04))
> >             {
> >                 Store (CMRD (0x6F), Local0)
> >                 Or (Local0, 0x04, Local0)
> >                 CMWR (0x6F, Local0)
> > # Linux come shere b/c of OSI(Microsoft Windows 2001)
> >                 Return (One)
> >             }
> >             Else
> >             {
> >                 Store (CMRD (0x6F), Local0)
> >                 And (Local0, 0xFB, Local0)
> >                 CMWR (0x6F, Local0)
> >             }
> >
> >             Add (SizeOf (_OS), One, Local0)
> >             Store (Local0, Local1)
> >             Name (BUF0, Buffer (Local0) {})
> >             Name (BUF1, Buffer (Local0) {})
> >             Name (OSNT, One)
> >             Name (OS98, One)
> >             Store (_OS, BUF0)
> >             Store ("Microsoft Windows NT", BUF1)
> >             While (Local0)
> >             {
> > # an in-line strcmp()...
> >                 Decrement (Local0)
> >                 If (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (BUF1,
> >                     Local0)))) {}
> >                 Else
> >                 {
> >                     Store (Zero, OSNT)
> >                 }
> >             }
> >
> >             If (OSNT)
> >             {
> >                 Store (0x03, MSOS)
> >                 Return (One)
> >             }
> >             Else
> >             {
> >                 Store ("Microsoft Windows", BUF1)
> >                 While (Local1)
> >                 {
> >                     Decrement (Local1)
> >                     If (LEqual (DerefOf (Index (BUF0, Local1)), DerefOf (Index (BUF1,
> >                         Local1)))) {}
> >                     Else
> >                     {
> >                         Store (Zero, OS98)
> >                     }
> >                 }
> >
> >                 If (OS98)
> >                 {
> >                     Store (One, MSOS)
> >                     Return (Zero)
> >                 }
> >                 Else
> >                 {
> >                     Store (0x02, MSOS)
> >                     Return (Zero)
> >                 }
> >             }
> >         }
> >
> 
> 
> 
> Len,
> 
> I had to learn how to configure my desktop to suspend to disk.
> 
> Using acpi_osi=Linux  it does not resume from suspend, I get an error
> "Could not stat resume device file"
> The resume device is /dev/sda5 specified on the kermel command line
> via the grub menu.
> Using acpi_osi=!Linux the resume works (and USB devices work).

Hmmm,  so you've to 2.6.22 or earlier where the default is acpi_osi=Linux
and suspend to disk fails; but when you add "acpi_osi=!Linux" suspend
to disk works?!

I guess it is important that we stay Windows compatible
on this box and trigger whatever SMI Dell has in that path.

thanks,
-Len
