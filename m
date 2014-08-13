From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: ACPI / dock: ThinkPad X220: \_SB_.PCI0.LPC_.EC__.BAT1: Unable
 to dock!
Date: Wed, 13 Aug 2014 11:48:55 +0200
Message-ID: <1407923335.2121.27.camel@x220>
References: <1406670374.2406.27.camel@x220>
	 <1589104.UMXrnXY9GI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:57152 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbaHMJs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Aug 2014 05:48:58 -0400
In-Reply-To: <1589104.UMXrnXY9GI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Rubin Abdi <rubin@starset.net>, linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org

On Wed, 2014-07-30 at 00:23 +0200, Rafael J. Wysocki wrote:
> Can you send me the output of acpidump from the machine in question, please?

0) That I've done some time ago. In the mean time I've decompiled the
dsdt.dat that acpidump generates. Here are my (rather verbose) notes,
that I mostly post to archive them somewhere public.

1) The interesting parts of dsdt.dsl are:
DefinitionBlock ("dsdt.aml", "DSDT", 1, "LENOVO", "TP-8D   ", 0x00001390)
{
    [...]
    Scope (\_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            [...]
            If (LGreaterEqual (\_REV, 0x02))
            {
                Store (0x01, \H8DR)
            }
            [...]
        }
        [...]
        Device (PCI0)
        {
            [...]
            Device (LPC)
            {
                [...]
                Device (EC)
                {
                    [...]
                    Field (ECOR, ByteAcc, NoLock, Preserve)
                    {
                        [...]
                        HB1A,   1, 
                        [...]
                    }
                    [...]
                    Method (BATW, 1, NotSerialized)
                    {
                        Store (\_SB.PCI0.LPC.EC.BAT1.XB1S, Local0)
                        If (\H8DR)
                        {
                            Store (HB1A, Local1)
                        }
                        Else
                        {
                            [...]
                        }

                        If (XOr (Local0, Local1))
                        {
                            Store (Local1, \_SB.PCI0.LPC.EC.BAT1.XB1S)
                            Notify (\_SB.PCI0.LPC.EC.BAT1, 0x01) // Device Check
                        }
                    }
                    [...]
                    Device (BAT1)
                    {
                        [...]
                        Name (XB1S, 0x01)
                        [...]
                        Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                        {
                            If (Arg0)
                            {
                                [...]
                                Store (0x00, XB1S) /* \_SB_.PCI0.LPC_.EC__.BAT1.XB1S */
                            }
                        }
                    }
                    [...]
                }
            }
            [...]
        }
        [...]
    }
    [...]
    Method (\_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        [...]
        \_SB.PCI0.LPC.EC.BATW (Arg0)
        [...]
    }
    [...]
    Name (H8DR, 0x00)
    [...]
}

2) Some guesswork:
- HB1A is always 1;
- H8DR will be 0x01 (because Linux currently sets _REV at 5);
- XB1S is apparently 0x00 at first resume (I don't know how that
  happens);
- so "XOr ([HB1A], [XB1S])" evaluates to 1 at the first "Wake" and XB1S
  will then be set to 1 and a "Device Check" event is fired;
- it's this "Device Check" event that triggers the error I reported;
- because HB1A and XB1S are equal after the BATW method has run at first
  resume we will not get a "Device Check" event at subsequent resumes.


Paul Bolle

