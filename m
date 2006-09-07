From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Thu, 7 Sep 2006 12:34:21 +0200
Message-ID: <200609071234.21782.rjw@sisk.pl>
References: <200609041332.19780.rjw@sisk.pl> <20060906211214.GB1959@elf.ucw.cz> <200609070903.37254.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:30873 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751000AbWIGKbo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2006 06:31:44 -0400
In-Reply-To: <200609070903.37254.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thursday, 7 September 2006 09:03, Rafael J. Wysocki wrote:
> On Wednesday, 6 September 2006 23:12, Pavel Machek wrote:
> > On Wed 2006-09-06 22:47:37, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > On Wednesday, 6 September 2006 12:42, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > Now, the output of /proc/interrupts with everything loaded is
> > > > > 
> > > > >            CPU0       CPU1       
> > > > >   0:     511683          0  local-APIC-edge  timer
> > > > >   1:       6164          0    IO-APIC-edge  i8042
> > > > >   8:          0          0    IO-APIC-edge  rtc
> > > > >  12:        148          0    IO-APIC-edge  i8042
> > > > >  14:      18053          0    IO-APIC-edge  ide0
> > > > > 169:        140          0   IO-APIC-level  acpi
> > > > > 177:          4          0   IO-APIC-level  yenta, ohci1394, sdhci:slot0
> > > > > 217:      48306          0   IO-APIC-level  libata, HDA Intel
> > > > > 225:      22528          0   IO-APIC-level  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
> > > > > 233:      30024          0   IO-APIC-level  eth0
> > > > > NMI:        682       1125 
> > > > > LOC:     511687     511654 
> > > > > ERR:          0
> > > > > MIS:          0
> > > > > 
> > > > > so it looks like the problems are related to the drivers of interrupt vectors
> > > > > above 14.  However, powernow_k8 doesn't seem to fit.
> > > > 
> > > > Its possible that pn_k8 has some separate problem...
> > > > 
> > > > > 3) when it breaks, the kernel reports:
> > > > > 
> > > > > sd 0:0:0:0 SCSI error, return code = 0x00070000
> > > > > end_request: I/O error, dev sda, sector <sector_number>
> > > > > lost page write due to I/O error on sda
> > > > > 
> > > > > for each sector that is attempted to be read from/written to.  Interestingly
> > > > > enough, when this happens, the other devices seem to work (eg. the tg3 driver
> > > > > evidently works).
> > > > 
> > > > That actually points to interrupt problems.
> > > > 
> > > > > I'm attaching the output of dmesg after a fresh boot (I think I'll create a
> > > > > bugzilla entry and put all of the information in there).
> > > > 
> > > > Yes please. Big question is who to assign it to...
> > > 
> > > Actually, I won't for now, because there's some progress. :-)
> > > 
> > > Namely, on a non-preemptible 2.6.18-rc5-mm1 the only module that causes
> > > problems is snd_hda_intel.  Unfortunately I can't unload it before suspend,
> > > because the kernel oopses on every attempt to do so, but I'll report this
> > > in a separate thread.
> > > 
> > > I'll experiment with the preemptible kernel when the snd_hda_intel issue gets
> > > resolved.
> > 
> > What about not loading snd_hda_intel in the first place?
> 
> Of course if it don't load it, the suspend works.  Otherwise I wouldn't have
> known it's the only module causing problems.  ;-)
> 
> Still in a practically useful setup I'd like it to be unloaded before the
> suspend and loaded back again after the resume.
> 
> > (Just for the record, suspend with snd_hda_intel seems to work
> > here...)
> 
> The problem seems to be related to the MSI.  Andrew and Greg KH say the
> MSI code have been rewritten recently, so there's some hope.

I've just learnt that it's possible to disable the MSI in snd_hda_intel and I
can suspend and resume the box now (with the non-preemptible 2.6.18-rc5-mm1
:-) ).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
