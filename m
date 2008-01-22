From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Acer Aspire 5050)
Date: Mon, 21 Jan 2008 21:33:32 -0500
Message-ID: <200801212133.32483.lenb@kernel.org>
References: <1195031290.6446.1.camel@ITmanager> <200801181728.40046.lenb@kernel.org> <47946846.8090105@neptuneconcept.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40289 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbYAVCdx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 21:33:53 -0500
In-Reply-To: <47946846.8090105@neptuneconcept.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philippe Didier <pdidier@neptuneconcept.com>
Cc: linux-acpi@vger.kernel.org


> > 	Manufacturer: Acer, inc.
> > 	Product Name: Aspire 5050

> I did it because I saw the error message in the logs. My Acer has still 
> a problem with sound because of hda-intel  chipset, and still unusable 
> with skype/alsa.
> 
> I dont use anymore the option "acpi_osi=!Linux" and I was even not able 
> to put it again as boot parameters. It seems to be ignored, even 
> modifying menu.lst as below:
> kernel          /boot/vmlinuz-2.6.22-14-generic 
> root=UUID=a19a083e-69cd-4384-a52a-b70a43d4235a ro quiet splash 
> acpi_osi=!Linux

with grub, you should be able to select a menu line with the up/down arrows
and 'e' to edit the selected line
adn select the kernel line of that entry and type 'e' to edit that
and then type in the modification to the cmdline, RETURN
and 'b' for boot.

This is safer than editing menu.lst, for if the option doesn't work
you haven't made it default.  And if you do edit that file, it is probably
a better idea to copy the entry to the end of file and edit it there
rather than editing your default boot cmdline.

i don't know why a modification to your grub boot.conf might not take effect.
maybe since it is before ### END DEBIAN AUTOMAGIC KERNELS LIST
there is something special about it...  you could find out by
copying it to after that line and editing there...

editing menu.lst to add this parameter works on my fedora box....
maybe debian is doing something funny like not using that file
and instead using a different copy of it?


> Find in attachement the acpidump output.
> 
> If you think I should try again, please tell me how to activate this option.
> 
> Regards
> 
> Philippe
> $ uname -a
> Linux IT-Manager 2.6.22-14-generic #1 SMP Tue Dec 18 08:02:57 UTC 2007 
> i686 GNU/Linux

Thanks for the acpidump -- it is similar to other Acer models
in that it will disable the Windows-compatible path through
the BIOS with no apparent upside for Linux.


                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

In the case of the Acer Aspire 5050, LINX and OSTP are NOPs
however TPOS is compared to 0x40 in the SATA code.
Safer to keep OSI(Linux) disabled on this box unless we
find ourselves incompatible with the Vista SATA ACPI hooks.

-Len

