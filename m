From: Len Brown <lenb@kernel.org>
Subject: Re: DMI update - Lenovo X61x
Date: Tue, 12 Feb 2008 15:58:20 -0500
Message-ID: <200802121558.20578.lenb@kernel.org>
References: <Pine.LNX.4.64.0802071146100.30873@twin.jikos.cz> <200802071339.26113.lenb@kernel.org> <Pine.LNX.4.64.0802081538260.30873@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56444 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbYBLU6k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 15:58:40 -0500
In-Reply-To: <Pine.LNX.4.64.0802081538260.30873@twin.jikos.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-acpi@vger.kernel.org

Thanks for the acpidump (and bug report 9916)

I suspect that acpi_osi=Linux will work better than acpi_osi=!Linux on this box,
which is the case for the R61 and T61.  Perhaps you can verify that, say
by testing if sound and mute work in both cases?

It is hard to predict what acpi_osi=Linux will actuall do with this DSDT,
but it will have an effect on both the EC and SMM -- an effect
that appears to be intentional.

This is the most correct use of _OS and _OSI that I've seen --
as they set a different "interface" variable for each interface tested,
rather than trying to simply glean the latest Windows version known.

Indeed, the only thing I'd change is to move the test for "Microsoft Windows"
back with the !_OSI section with the test for NT.

Also, this may be the very first time I've seen a DSDT query for _OSI("FreeBSD").
Curiously, it sets \LNUX for it, just like for _OSI(Linux).  Which makes
me think that Lenovo is actualy booting something other than Windows
on this box -- b/c I've not seen that in any example BIOS...

thanks,
-Len


       Method (_INI, 0, NotSerialized)
        {
            If (LEqual (\SCMP (\_OS, "Microsoft Windows"), Zero))
            {
                Store (0x01, \W98F)
            }
            Else
            {
                If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x01, \WNTF)
                        Store (0x01, \WXPF)
                        Store (0x00, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x01, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x02, \WSPV)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x01, \WVIS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, \LNUX)
                    }

                    If (\_OSI ("FreeBSD"))
                    {
                        Store (0x01, \LNUX)
                    }
                }
                Else
                {
                    If (LEqual (\SCMP (\_OS, "Microsoft Windows NT"), Zero))
                    {
                        Store (0x01, \WNTF)
                    }
                    Else
                    {
                        If (LEqual (\SCMP (\_OS, "Microsoft WindowsME: Millennium Edition"), Zero))
                        {
                            Store (0x01, \WMEF)
                            Store (0x01, \W98F)
                        }
                    }
                }
            }
...
            If (\LNUX)
            {
                \_SB.PCI0.LPC.EC.SAUM (0x02)
                \UCMS (0x1C)
# UCMS is an SMI wrapper. the parameter is unique to LNUX.
            }
...
       Scope (\_SB.PCI0.LPC.EC)
        {
            Method (_Q43, 0, NotSerialized)
            {
                \UCMS (0x18)
            }

            Method (SAUM, 1, NotSerialized)
            {
                If (LGreater (Arg0, 0x03))
                {
                    Noop
                }
                Else
                {
                    If (\H8DR)
                    {
                        Store (Arg0, HAUM)
# Linux comes here
# I don't know what HAUM is, but this is the only place it is set
# and it is in EC space

                    }
                    Else
                    {
                        \MBEC (0x03, 0x9F, ShiftLeft (Arg0, 0x05))
# MBEC is an SMI entry point too
                    }
                }
            }
        }

...
            If (LGreaterEqual (\_REV, 0x02))
            {
                Store (0x01, \H8DR)
# Linux has #define ACPI_CA_SUPPORT_LEVEL 3 for _REV, so we set H8DR=1 here
            }

...
                    OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        HDBM,   1,
                            ,   1,
                            ,   1,
                        HFNE,   1,
                            ,   1,
                            ,   1,
                        HLDM,   1,
                                Offset (0x01),
                            ,   1,
                        BTCM,   1,
                            ,   1,
                            ,   1,
                            ,   1,
                        HBPR,   1,
                        BTPC,   1,
                                Offset (0x02),
                        SLIS,   1,
                                Offset (0x03),
                            ,   1,
                        HETE,   1,
                            ,   3,
                        HAUM,   2,
                                Offset (0x05),
...
    Method (UCMS, 1, NotSerialized)
    {
        Return (SMI (0x02, Arg0, 0x00, 0x00, 0x00))
    }
...
    Method (MBEC, 3, NotSerialized)
    {
        SMI (0x00, 0x05, Arg0, Arg1, Arg2)
    }
