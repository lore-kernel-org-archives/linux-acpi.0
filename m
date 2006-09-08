From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Sat, 9 Sep 2006 01:27:46 +0200
Message-ID: <200609090127.47209.rjw@sisk.pl>
References: <200609041332.19780.rjw@sisk.pl> <200609080022.26726.rjw@sisk.pl> <20060908154914.GH17680@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54953 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751285AbWIHX0Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2006 19:26:24 -0400
In-Reply-To: <20060908154914.GH17680@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>

On Friday, 8 September 2006 17:49, Pavel Machek wrote:
> Hi!
> 
> > > ? Do we have powernow-k8 problem?
> > 
> > No. :-)
> > 
> > Please also have a look at Bug #5534, comments #153-#164.
> 
> Okay, ACPI people should fix fan driver ;-).
> 
> Hmm.. fan driver actually seems to be okay.... perhaps
> acpi_thermal_resume needs some more care?

I bet on this one.

I have put some more details at http://bugzilla.kernel.org/show_bug.cgi?id=7122
and http://bugzilla.kernel.org/show_bug.cgi?id=5534.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
