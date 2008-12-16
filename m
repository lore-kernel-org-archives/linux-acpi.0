From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 17:13:08 +0100
Message-ID: <200812161713.08451.rjw@sisk.pl>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl> <gi8jf1$m5f$5@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756387AbYLPQOR@vger.kernel.org>
In-Reply-To: <gi8jf1$m5f$5@ger.gmane.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 16 of December 2008, Brian J. Murrell wrote:
> On Tue, 16 Dec 2008 16:25:37 +0100, Rafael J. Wysocki wrote:
> 
> > Because the hal-driven whitelist allows us to match systems in a more
> > detailed way.  If your system is in the s2ram whitelist already and
> > works with it, there shouldn't be any difference.
> 
> Unfortunately, Ubuntu in their "wisdom" removed s2ram and claim "s2both" 
> supersedes it in that it does both suspend to disk and suspend to ram and 
> then suspends, but if your battery dies while suspended you can still 
> resume from the suspend to disk.

Hm, this really isn't reasonable.  s2both saves the image, which takes quite
a lot of time, while s2ram doesn't.  Also, s2both is not really ACPI-compliant.

> > Still, I was only considering that as a debugging aid in your case,
> > because s2ram works in the minimal configuration, while hald doesn't.
> 
> Right.  I will give s2both a try and see what happens... no joy.  It 
> fails to even run without the swap device mounted, and my swap device is 
> not big enough to hibernate to anyway.  Damn you Ubuntu.

You can compile s2ram from sources, it's not too difficult.

> > That's a bit of new information.
> > 
> > What's the list of modules loaded in the minimal configuration?
> 
> Module                  Size  Used by
> ext3                  130568  1 
> jbd                    53908  1 ext3
> mbcache                16004  1 ext3
> loop                   22540  2 
> usb_storage            78656  0 
> libusual               30356  1 usb_storage
> sd_mod                 41240  2 
> crc_t10dif             10112  1 sd_mod
> sr_mod                 21956  0 
> cdrom                  42272  1 sr_mod
> sg                     36148  0 
> ahci                   37260  1 
> ata_piix               29700  0 
> pata_acpi              12288  0 
> ata_generic            13060  0 
> libata                176160  4 ahci,ata_piix,pata_acpi,ata_generic
> scsi_mod              156948  5 usb_storage,sd_mod,sr_mod,sg,libata
> 8139too                31744  0 
> 8139cp                 27776  0 
> mii                    13440  2 8139too,8139cp
> ehci_hcd               41996  0 
> uhci_hcd               30352  0 
> usbcore               149392  5 usb_storage,libusual,ehci_hcd,uhci_hcd
> thermal                23708  0 
> processor              49708  3 thermal
> fan                    12676  0 
> fuse                   58780  3 

Hm.  Is that all loaded when you boot with init=/bin/bash (by which I mean the
minimal config)?

Rafael
