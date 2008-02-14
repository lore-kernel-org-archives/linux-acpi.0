From: Len Brown <lenb@kernel.org>
Subject: Re: DMI Information - Dell Precision M4300
Date: Wed, 13 Feb 2008 22:35:59 -0500
Message-ID: <200802132235.59396.lenb@kernel.org>
References: <20080212235359.N50592@public.nfld.com> <200802122323.06374.lenb@kernel.org> <20080213232946.N67899@public.nfld.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46582 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbYBNDhT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 22:37:19 -0500
In-Reply-To: <20080213232946.N67899@public.nfld.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gerard Hynes <ghynes@nfld.com>
Cc: linux-acpi@vger.kernel.org

> > On Tuesday 12 February 2008 22:25, Gerard Hynes wrote:
> > >
> > > ACPI: EC: Look up EC in DSDT
> > > ACPI: BIOS _OSI(Linux) query honored via cmdline
> > > ACPI: DMI System Vendor: Dell Inc.
> > > ACPI: DMI Product Name: Precision M4300
> > > ACPI: DMI Product Version:
> > > ACPI: DMI Board Name: 0UY141
> > > ACPI: DMI BIOS Vendor: Dell Inc.
> > > ACPI: DMI BIOS Date: 01/14/2008
> > > ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> >

Thanks for the acpidump output.  My review of it is inconclusive.
Please let me know if acpi_osi=Linux makes anything work better
on this box.  Mostly it looks like it shouldn't make any difference,
but there appears to be an SMM hook in the dock code where it may have an effect.

thanks,
-Len

OSID() is used throughout, but OSI(Linux) will not break it because
the comparisons are usually >= x20 etc, and Linux is assigned x40.

The excpetion is GDCK._UID, which may have an effect


    Name (W98S, "Microsoft Windows")
    Name (NT5S, "Microsoft Windows NT")
    Name (WINM, "Microsoft WindowsME: Millennium Edition")
    Name (WXP, "Windows 2001")
    Name (WLG, "Windows 2006")
    Name (LNX, "Linux")

    Method (OSID, 0, NotSerialized)
    {
        If (LEqual (MIS3, 0x00))
        {
            Store (0x01, MIS3)
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI (WXP))
                {
                    Store (0x10, MIS3)
                }

                If (\_OSI (WLG))
                {
                    Store (0x20, MIS3)
                }

                If (\_OSI (LNX))
                {
                    Store (0x40, MIS3)
# OSI(Linux) comes here

                }
            }
            Else
            {
                If (STRE (\_OS, W98S))
                {
                    Store (0x02, MIS3)
                }

                If (STRE (\_OS, NT5S))
                {
                    Store (0x08, MIS3)
                }

                If (STRE (\_OS, WINM))
                {
                    Store (0x04, MIS3)
                }
            }
        }

        Return (MIS3)
    }
...
               Device (GDCK)
                {
                    Name (_HID, EisaId ("PNP0C15"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (MIS5, 0x01))
                        {
                            Store (SMI (0x87, 0x00), Local2)
                            If (Local2)
                            {
                                Notify (\_SB.PCI0.PCIE.GDCK, 0x00)
                                Return (0x00)
                            }
                        }

                        Store (SMI (0x87, 0x00), Local0)
                        If (Local0)
                        {
                            Return (0x0F)
                        }

                        Return (0x00)
                    }

                    Method (_UID, 0, NotSerialized)
                    {
                        SX10 ()
                        SX30 (0x05)
                        SX30 (OSID ())
# OSID() output is passed to SX30
                        SX11 ()
                        Store (SX42 (), Local0)
                        SX12 ()
                        Return (Local0)
                    }
...
    Method (SX30, 1, NotSerialized)
    {
        Store (SXX2, Local0)
        Increment (Local0)
        If (LLessEqual (Local0, SizeOf (SXX0)))
        {
            CreateByteField (SXX0, SXX2, SX20)
            Store (Arg0, SX20)
            Store (Local0, SXX2)
        }
    }

I have no idea what this method and all its reference are trying todo,
but they're in with some SMI related code, so OSI(Linux) may have
an effect on SMM.

