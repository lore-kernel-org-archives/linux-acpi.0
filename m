From: Richard Hughes <hughsient@gmail.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 04 Jan 2007 21:36:36 +0000
Message-ID: <1167946596.6816.7.camel@hughsie-laptop>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <20070104211830.GD25619@inferi.kami.home>
	 <20070104132834.99a585c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:38565 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089AbXADVgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 16:36:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5541710uga
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jan 2007 13:36:40 -0800 (PST)
In-Reply-To: <20070104132834.99a585c9.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Thu, 2007-01-04 at 13:28 -0800, Andrew Morton wrote:
> On Thu, 4 Jan 2007 22:18:30 +0100
> Mattia Dongili <malattia@linux.it> wrote:
> 
> > > The place to start (please) is the patches in -mm:
> > > 
> > > 2.6-sony_acpi4.patch
> > > sony_apci-resume.patch
> > > sony_apci-resume-fix.patch
> > > acpi-add-backlight-support-to-the-sony_acpi.patch
> > > acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> > > 
> > > It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> > > job would be to chop out the /proc stuff.
> > 
> > Ok, I'll import all of them and start from there.
> > Is it ok to wipe all the /proc stuff without notice?
> 
> spose so.  I don't know if any apps are dependent upon the /proc file,
> but the driver isn't in mainline yet so it's unlikely that there's a
> mountain of software depending upon existing interfaces.

Well, HAL has used it for changing the brightness for the last year or
so: /proc/acpi/sony/brightness

Although if you use a new enough HAL (CVS), the laptop will be supported
via the shiny new backlight class.

Richard.


