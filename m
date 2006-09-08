From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Fri, 8 Sep 2006 16:14:32 +0200
Message-ID: <200609081614.33112.rjw@sisk.pl>
References: <200609041332.19780.rjw@sisk.pl> <20060907220837.GI29890@elf.ucw.cz> <200609080022.26726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:934 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751135AbWIHONE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2006 10:13:04 -0400
In-Reply-To: <200609080022.26726.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>

On Friday, 8 September 2006 00:22, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 8 September 2006 00:08, Pavel Machek wrote:
> > Hi!
> > 
> > > > > (Just for the record, suspend with snd_hda_intel seems to work
> > > > > here...)
> > > > 
> > > > The problem seems to be related to the MSI.  Andrew and Greg KH say the
> > > > MSI code have been rewritten recently, so there's some hope.
> > > 
> > > I've just learnt that it's possible to disable the MSI in snd_hda_intel and I
> > > can suspend and resume the box now (with the non-preemptible 2.6.18-rc5-mm1
> > > :-) ).
> > 
> > So result is
> > 
> > 1) we have preempt problem
> 
> Probably.  I have to investigate it a bit more, though.

2.6.18-rc6-mm1 preemptible works too, up to the thermal management problem
after the resume described at http://bugzilla.kernel.org/show_bug.cgi?id=7122

I think the Linus' suspending of consoles makes it work ...

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
