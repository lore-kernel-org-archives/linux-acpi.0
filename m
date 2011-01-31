From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc2: acpi backlight control missing
Date: Mon, 31 Jan 2011 21:39:03 +0100
Message-ID: <201101312139.03634.rjw@sisk.pl>
References: <1295693349.2120.3.camel@localhost.localdomain> <201101222043.07703.rjw@sisk.pl> <1296249125.2006.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55020 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042Ab1AaUj2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Jan 2011 15:39:28 -0500
In-Reply-To: <1296249125.2006.7.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: rui.zhang@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Friday, January 28, 2011, Thomas Meyer wrote:
> Am Samstag, den 22.01.2011, 20:43 +0100 schrieb Rafael J. Wysocki:
> > On Saturday, January 22, 2011, Thomas Meyer wrote:
> > > with 2.6.38-rc2 the acpi backlight is gone:
> > > 
> > > any ideas?
> > 
> > Not really, but Matthew may have some (CCed).
> 
> Okay, found the problem.
> 
> This commit broke my backlight:
> 
> commit 677bd810eedce61edf15452491781ff046b92edc
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Mon Dec 6 15:04:21 2010 +0800
> 
>     ACPI video: remove output switching control
> 
> This is because in function
> "acpi_is_video_device()" (drivers/acpi/video_detect.c) the backlight
> device is only checked when some video capabilities were found, but by
> removing the check for the VIDEO_OUTPUT_SWITCHING (that seems to be the
> only video capability on my system) the check for the backlight device
> isn't done anymore.
> 
> by reverting above commit, the backlight is back again.

Is it the same issue as https://bugzilla.kernel.org/show_bug.cgi?id=27702 ?
In case it is, can you test the patch in there, please?

Rafael
