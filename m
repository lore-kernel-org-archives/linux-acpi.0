From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RESEND] [PATCH 1/3] ACPI: battery: Fix
 CONFIG_ACPI_SYSFS_POWER=n
Date: Fri, 11 Sep 2009 05:34:42 +0300
Message-ID: <1252636482.12609.5.camel@maxim-laptop>
References: <4A4A219C.2020802@tuffmail.co.uk>
	 <1252339562.28499.13.camel@maxim-laptop> <4AA7E438.4070905@tuffmail.co.uk>
	 <1252531271.4174.5.camel@maxim-laptop>
	 <9b2b86520909100411o6dc850a5mc80792285411aff3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:33434 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZIKCeq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 22:34:46 -0400
Received: by fxm17 with SMTP id 17so532326fxm.37
        for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2009 19:34:48 -0700 (PDT)
In-Reply-To: <9b2b86520909100411o6dc850a5mc80792285411aff3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

On Thu, 2009-09-10 at 12:11 +0100, Alan Jenkins wrote: 
> On 9/9/09, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > On Wed, 2009-09-09 at 18:22 +0100, Alan Jenkins wrote:
> >> Maxim Levitsky wrote:
> >> > Hi,
> >> >
> >> > So this is newer version of this patchset.
> >> > When this will be merged?
> >> >
> >> >
> >> > Last patch doesn't apply, seems that parts of yours patch were applied.
> >> > I applied it manually.
> >> >
> >> > Will soon test.
> >> >
> >> >
> >> > Best regards,
> >> > 	Maxim Levitsky
> >> >
> >>
> >> I will submit "To: len" next time round.
> >>
> >> You're right, it no longer applies cleanly to acpi-test.  ["patch" is
> >> happy to apply it and warn about "fuzz", but git-am is more strict.  It
> >> doesn't look like there's a real conflict.]
> > I applied it on top of both vanilla and linux-next. Here it really
> > doesn't apply (with or without 'fuzz')
> >
> >>
> >> I look forward to your results.  Please tell me the diff you end up with
> >> for the last patch and what tree you applied it on top of.  That way, if
> >> I add "Tested-by: Maxim..." I can be certain we're talking about the
> >> same patch :-).
> >>
> >> Thanks!
> >> Alan
> >
> > I did that few days ago (applied patch manually, without much thinking)
> >
> > Unfortunately, resulting kernel oopses if battery is present, and
> > otherwise, if I plug batter later on, many battery statistics are
> > missing (probably some locks are held)
> >
> > I will soon investigate this issue, more deeply.
> >
> > Best regards,
> > Maxim Levitsky
> 
> I've applied the patches from the mailing list, initially on -rc8
> using git-am, then rebased them onto acpi-test without conflicts.  I
> don't have GIT hosting, so here's a git bundle.  If you're still
> having problems, you should be able to get an _exact_ copy of my tree
> with
> 
> $ git fetch alan.bundle battery-check:battery-check
> $ git checkout battery-check
> 
> so long as you have the acpi-test commit I based it on.
> 
> Thanks
> Alan

Indeed, it works.


Just one issue though, if I plug in the battery after system boot, it is
detected a an 'energy battery' (energy_battery_props are used)

ACPI seems to be ok:

                Device (BAT0)
                {
                    Name (_HID, EisaId ("PNP0C0A"))
                    Name (_UID, 0x01)
                    Name (_PCL, Package (0x01)
                    {
                        \_SB
                    })
                    Name (PBIF, Package (0x0D)
                    {
                        0x01, 
                        0x0FA0, 
                        0x0FA0, 
                        0x01, 
                        0x39D0, 
                        0x0190, 
                        0x78, 
                        0x0108, 
                        0x0EC4, 
                        "Li_Ion 4000mA ", 
                        "", 
                        "Lion", 
                        "Acer   "
                    })
                    Name (PBST, Package (0x04)
                    {
                        0x01, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0x39D0
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (ECON)
                        {
                            If (\_SB.PCI0.LPC.EC0.BAL1)
                            {
                                Sleep (0x14)
                                Return (0x1F)
                            }
                            Else
                            {
                                Sleep (0x14)
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            Sleep (0x14)
                            Return (0x1F)
                        }
                    }

                    Method (_BIF, 0, NotSerialized)
                    {
                        If (ECON)
                        {
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BDC0, Index (PBIF, 0x01))
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BFC0, Index (PBIF, 0x02))
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BDV0, Index (PBIF, 0x04))
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BDC0, Local2)
                            Divide (Local2, 0x64, Local6, Local2)
                            Multiply (Local2, 0x05, Local3)
                            Store (Local3, Index (PBIF, 0x05))
                            Multiply (Local2, 0x03, Local4)
                            Store (Local4, Index (PBIF, 0x06))
                            Store (\_SB.PCI0.LPC.EC0.BTY0, Local1)
                            Sleep (0x14)
                            If (LEqual (Local1, 0x01))
                            {
                                Store ("GC86508SAT0 ", Index (PBIF, 0x09))
                                Store ("SANYO ", Index (PBIF, 0x0C))
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store ("GC86503SY90 ", Index (PBIF, 0x09))
                                    Store ("SONY ", Index (PBIF, 0x0C))
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x04))
                                    {
                                        Store ("GC86503PAG0 ", Index (PBIF, 0x09))
                                        Store ("PANASONIC ", Index (PBIF, 0x0C))
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x05))
                                        {
                                            Store ("GC86508SM60 ", Index (PBIF, 0x09))
                                            Store ("SAMSUNG ", Index (PBIF, 0x0C))
                                        }
                                        Else
                                        {
                                            Store ("BCL3100LiON ", Index (PBIF, 0x09))
                                            Store ("COMPAL ", Index (PBIF, 0x0C))
                                        }
                                    }
                                }
                            }
                        }

                        Return (PBIF)
                    }

                    Method (_BST, 0, NotSerialized)
                    {
                        If (ECON)
                        {
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BST0, Local0)
                            And (Local0, 0x07, Local0)
                            Store (Local0, Index (PBST, 0x00))
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.GAU0, Local2)
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BPV0, Local3)
                            Sleep (0x14)
                            Store (\_SB.PCI0.LPC.EC0.BFC0, Local1)
                            Sleep (0x14)
                            If (Local2)
                            {
                                Multiply (Local2, Local1, Local2)
                                Divide (Local2, 0x64, Local6, Local2)
                                If (Local6)
                                {
                                    Increment (Local2)
                                }
                            }

                            Store (\_SB.PCI0.LPC.EC0.BAC0, Local1)
                            If (And (Local1, 0x8000, Local1))
                            {
                                Store (\_SB.PCI0.LPC.EC0.BAC0, Local1)
                                Subtract (0xFFFF, Local1, Local1)
                            }
                            Else
                            {
                                Store (0x00, Local1)
                            }

                            Sleep (0x14)
                            Store (Local1, Index (PBST, 0x01))
                            Store (Local2, Index (PBST, 0x02))
                            Store (Local3, Index (PBST, 0x03))
                        }

                        Return (PBST)
                    }
                }





PBIF at offset 0 is set correctly to 1.


Best regards,
	Maxim Levitsky

