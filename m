From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Acer Aspire 5580
Date: Mon, 21 Jan 2008 00:52:45 -0500
Message-ID: <200801210052.45426.lenb@kernel.org>
References: <5c446fb70709021541m36a2bd6fxe41e5936771b60ef@mail.gmail.com> <200801182240.09787.lenb@kernel.org> <5c446fb70801192042g6ee810f2n12c018b5016de3cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55834 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbYAUFxA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:53:00 -0500
In-Reply-To: <5c446fb70801192042g6ee810f2n12c018b5016de3cf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anne-Simone <baleineca@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 23:42, Anne-Simone wrote:
> Attached is the acpidump file.
> 
> I haven't noticed any functional difference when setting "acpi_osi=!Linux".
>  My current kernel version is Gentoo 2.6.22-suspend2-r2 and in both cases
> (acpi_osi=Linux and acpi_osi=!Linux), I can suspend, but after resuming, the
> network connection fails after about 10 - 15 minutes.  I get "no route to
> host" to my router...
> 
> Also attached is a diff of dmesg for the different acpi_osi settings.
> 
> acpidump output was the same for the different acpi_osi settings.
> 
> Cheers,
> Anne-Simone
> 
> On Jan 18, 2008 7:40 PM, Len Brown <lenb@kernel.org> wrote:
> > On Sunday 02 September 2007 18:41, Anne-Simone wrote:
> > > System Information
> > > Manufacturer: Acer, inc.
> > > Product Name: Aspire 5580
> > > Version: Not Applicable
> > > Serial Number: LXAXW0X01471503FA42505
> > > UUID: 404E6C55-1803-D911-8BE3-001B242367DD
> > > Wake-up Type: Power Switch
> > > SKU Number: Not Specified
> > > Family: Not Specified
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > > Manufacturer: Acer, Inc.
> > > Product Name: Prespa1

thanks for the acpidump.
It shows lots of dependencies on "OSYS", which is set differently for Linux.
The dependencies show up in places like battery, AC, wakup support and docking.

Basically, it sets the DSDT to run in "unknown OS" mode, since there
is not a single test for OSYS = the value set for Linux.

I will blacklist OSI(Linux) on this box (which for 2.6.23 and later
is no change, since OSI(Linux) is off by default.  If we find incompatibilities
with how Windows exercises the box, we'll fix those -- which is a better
course than running the DSDT in "other" mode that the vendor surely
has never tested.

thanks,
-Len



  Scope (\_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
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
