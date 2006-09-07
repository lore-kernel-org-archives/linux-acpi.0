From: Pavel Machek <pavel@suse.cz>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Fri, 8 Sep 2006 00:08:37 +0200
Message-ID: <20060907220837.GI29890@elf.ucw.cz>
References: <200609041332.19780.rjw@sisk.pl> <20060906211214.GB1959@elf.ucw.cz> <200609070903.37254.rjw@sisk.pl> <200609071234.21782.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27081 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751906AbWIGWIy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2006 18:08:54 -0400
Content-Disposition: inline
In-Reply-To: <200609071234.21782.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi!

> > > (Just for the record, suspend with snd_hda_intel seems to work
> > > here...)
> > 
> > The problem seems to be related to the MSI.  Andrew and Greg KH say the
> > MSI code have been rewritten recently, so there's some hope.
> 
> I've just learnt that it's possible to disable the MSI in snd_hda_intel and I
> can suspend and resume the box now (with the non-preemptible 2.6.18-rc5-mm1
> :-) ).

So result is

1) we have preempt problem

2) we have MSI problem

? Do we have powernow-k8 problem?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
