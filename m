From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Fri, 8 Sep 2006 17:49:14 +0200
Message-ID: <20060908154914.GH17680@elf.ucw.cz>
References: <200609041332.19780.rjw@sisk.pl> <200609071234.21782.rjw@sisk.pl> <20060907220837.GI29890@elf.ucw.cz> <200609080022.26726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9146 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750861AbWIHPtk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2006 11:49:40 -0400
Content-Disposition: inline
In-Reply-To: <200609080022.26726.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>

Hi!

> > ? Do we have powernow-k8 problem?
> 
> No. :-)
> 
> Please also have a look at Bug #5534, comments #153-#164.

Okay, ACPI people should fix fan driver ;-).

Hmm.. fan driver actually seems to be okay.... perhaps
acpi_thermal_resume needs some more care?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
