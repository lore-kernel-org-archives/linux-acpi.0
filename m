From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test
Date: Mon, 4 Feb 2008 01:30:08 -0500
Message-ID: <200802040130.08938.lenb@kernel.org>
References: <20080202121718.2286.89857.stgit@pacifica> <200802022244.22917.lenb@kernel.org> <200802030945.06398.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53807 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYBDGa1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 01:30:27 -0500
In-Reply-To: <200802030945.06398.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>


> For future patches - do you want me to resend them, or send you incremental 
> patches against what is currently in your tree?

I can handle either way,
but if they are revisions of the existing patches rather
than adding additional logically independent changes,
then it is cleaner to re-send the series.

> > acer-wmi needs a MAINTAINER
> 
> Oversight on my part - will do.
> 
> > tc1100-wmi needs a MAINTAINER
> 
> I'll add myself for now; but if anyone else wants the job, I don't mind.
> 
> > I don't understand the WMI user/kernel sysfs API.
> 
> I did have some documentation on this - I'll refresh it and send another 
> patch.

okay, good.

> > I guess i had originally expected it to live in /sys/firmware/wmi,
> > but I see that they put dmi a subset of DMI under /sys/class/dmi,
> > so i guess there is precident...  I got my main wish, which was
> > to have not _not_ be under some ACPI specific directory:-)
> 
> I can probably put a symlink in for /sys/firmware/wmi, if you like?

No, don't bother.

> The /sys/class is done simply because using a class and virtual devices is far 
> simpler, and appears less prone to the sysfs-rework-of-the-week (and makes 
> autoload support based on a GUID trivial to implement).
> 
> > #2 is the better route -- move forward using workaround,
> > and revert the workaround when it is no longer needed.
> > The risk is if somebody in user-space starts actually
> > programming to 19-character GUIDS.
> 
> Ok.
> 
> > I loaded this driver on an HP nx6325 as well as a Lenovo T61.
> 
> Interesting - do Lenovo actually use WMI for anything? I thought they had 
> their own custom HID's supported by thinkpad-acpi?

Apparently they do.

The T61 also has IBM and LENOVO HIDs.

No, I don't know why the '*' is in "*pnp0c14", but we've
run into that before so we ignore it.

[lenb@d975xbx2 t61]$ grep _HID DSDT.dsl
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_HID, EisaId ("PNP0C01"))
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_HID, EisaId ("PNP0C0E"))
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_HID, EisaId ("IBM3780"))
                            Store (0x80374D24, _HID)
                            Store (0x57004D24, _HID)
                    Name (_HID, EisaId ("PNP0700"))
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_HID, EisaId ("PNP0401"))
                    Name (_HID, EisaId ("ATM1200"))
                    Name (_HID, EisaId ("PNP0C09"))
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_HID, "ACPI0003")
                        Name (_HID, EisaId ("IBM0068"))
            Name (_HID, EisaId ("PNP0A08"))
                        Name (_HID, "*pnp0c14")
                Name (_HID, EisaId ("IBM0069"))
                            Store (\_SB.PCI0.LPC.FDC._HID, Index (XPCK, 0x02))
                        Store (\_SB.PCI0.LPC.EC.BAT1._HID, Index (XPCK, 0x02))
                Name (_HID, EisaId ("IBM0079"))
                Name (_HID, EisaId ("LEN0001"))

> > just for kicks i tried to dump the data attributes,
> > but on both machines I found that some of them oops
> > in wmi_data_read like below.
> 
> Hmm - I'll look into this and see if I can see what's going wrong.

thanks.  Let me know if you need help testing.

cheers,
-Len

ps. note that your code shipped in 2.6.24-mm1



