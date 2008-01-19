From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba P105-S6207 (success using acpi_osi=!Linux) w/dmidecode,dmesg
Date: Sat, 19 Jan 2008 01:42:22 -0500
Message-ID: <200801190142.22639.lenb@kernel.org>
References: <1195043534.5511.18.camel@localhost> <200801181726.16018.lenb@kernel.org> <1200706703.12327.1.camel@aleph.morrison.iserv.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56793 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbYASGmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 01:42:36 -0500
In-Reply-To: <1200706703.12327.1.camel@aleph.morrison.iserv.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: adamtaunowilliams@gmail.com
Cc: linux-acpi@vger.kernel.org

On Friday 18 January 2008 20:38, Adam Tauno Williams wrote:
> > On Wednesday 14 November 2007 15:33, Adam Tauno Williams wrote:
> > >         Manufacturer: TOSHIBA
> > >         Product Name: Satellite P105
> > > I have a Toshiba P105-S6207 running openSUSE 10.3
> > > (2.6.22.12-0.1-default).  All the devices (to my knowledge) are working,
> > > except sound;  I've tried various things and the sound driver seems to
> > > load just fine but produce no output.  Then I noticed a message in dmesg
> > > about trying to boot with "acpi_osi=!Linux".  So I booted as:
> > > root=/dev/Aleph/Root vga=0x314 resume=/dev/sda2 splash=silent acpi_osi=!
> > > Linux
> > > and Bingo! I got sound. 
> > Okay, I've added this box to the list of systems that
> > fail with OSI(Linux).
> > Please send me the output from acpidump -- I'd like to find out why.
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> 

Thanks for the acpidump.
This is exactly the type of BIOS bug we want to avoid.
I'll blacklist this machine to disable OSI(Linux) since it breaks sound.

-Len

            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }
                Else
                {
                    Store (0x07D1, OSYS)
                    If (_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x07D2, OSYS)
                    }

                    If (_OSI ("Windows 2001.1"))
                    {
                        Store (0x07D3, OSYS)
                    }

                    If (_OSI ("Windows 2001.1 SP1"))
                    {
                        Store (0x07D4, OSYS)
                    }

                    If (_OSI ("Windows 2006"))
                    {
                        Store (0x07D6, OSYS)
                    }

                    If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                    {
                        TRAP (0x3D)
                    }
                }
            }
