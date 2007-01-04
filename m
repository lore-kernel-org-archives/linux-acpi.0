From: Andrew Morton <akpm@osdl.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 4 Jan 2007 13:28:34 -0800
Message-ID: <20070104132834.99a585c9.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	<200701040024.29793.lenb@kernel.org>
	<1167905384.7763.36.camel@localhost.localdomain>
	<20070104191512.GC25619@inferi.kami.home>
	<20070104125107.b82db604.akpm@osdl.org>
	<20070104211830.GD25619@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp0.osdl.org ([65.172.181.24]:55252 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030239AbXADV3V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 16:29:21 -0500
In-Reply-To: <20070104211830.GD25619@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Stelian Pop <stelian@popies.net>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Thu, 4 Jan 2007 22:18:30 +0100
Mattia Dongili <malattia@linux.it> wrote:

> > The place to start (please) is the patches in -mm:
> > 
> > 2.6-sony_acpi4.patch
> > sony_apci-resume.patch
> > sony_apci-resume-fix.patch
> > acpi-add-backlight-support-to-the-sony_acpi.patch
> > acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> > 
> > It presently has both the /proc and /sys/.../backlight/.. interfaces, so the first
> > job would be to chop out the /proc stuff.
> 
> Ok, I'll import all of them and start from there.
> Is it ok to wipe all the /proc stuff without notice?

spose so.  I don't know if any apps are dependent upon the /proc file,
but the driver isn't in mainline yet so it's unlikely that there's a
mountain of software depending upon existing interfaces.
