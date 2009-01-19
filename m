From: Mattia Dongili <malattia@linux.it>
Subject: Re: Sony backlight regression from 2.6.28 to 29-rc
Date: Mon, 19 Jan 2009 21:58:09 +0900
Message-ID: <20090119125808.GB21586@kamineko.org>
References: <20090119081423.GA25297@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41281
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761226AbZASNEq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Jan 2009 08:04:46 -0500
Content-Disposition: inline
In-Reply-To: <20090119081423.GA25297@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Mon, Jan 19, 2009 at 09:14:23AM +0100, Norbert Preining wrote:
> Dear all,
> 
> there is a regression from 2.6.28 to 2.6.29-rc, namely that the
> backlight cannot be controlled anymore.
> 
> Previously I was able to get a working backlight control with late
> 2.6.28 kernels, not sure if I needed some patches posted by Mattia.

You probably required and still require
  [sony-laptop] detect the ICH9 chipset as Type3
and
  [sony-laptop] call the extra enable function for SNC on Vaio Z
at least.

> Now, with 2.6.29-rc2 with and without these patches the backlight does
> not work at all, no change.
> 
> INterestingly changing the "values" in the sys-files does work (via
> /sys/class/backlight/acpi_video0/brightness), either per hand or using
> xbacklight. but there is no effect on the actual brightness.

what were you using before? the acpi_video0 entry or the sony-laptop
one?

> And the sony_laptop sys entries have lost their brightness values.
> 
> Is there a way to restore this behaviour?
> 
> (Even better, get sony_laptop fixed completely?)
> 
> Hardware: Vaio VGN-Z11

well, there as been no change to the sony-laptop driver from 2.6.28 to
.29-rc2 except for moving it to drivers/platform/x86.

-- 
mattia
:wq!
