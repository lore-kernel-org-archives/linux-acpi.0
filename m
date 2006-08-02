From: Pavel Machek <pavel@suse.cz>
Subject: Re: Sony ACPI extras mainline inclusion
Date: Wed, 2 Aug 2006 10:03:14 +0000
Message-ID: <20060802100314.GF7601@ucw.cz>
References: <44CB288A.1010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42757 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750898AbWHBKgD
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Aug 2006 06:36:03 -0400
Content-Disposition: inline
In-Reply-To: <44CB288A.1010702@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido.box@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> I own a Sony VAIO laptop that uses ACPI for setting 
> screen brightness
> through the "2.6-sony_acpi4.patch" patch that has been 
> living in -mm for a while.
> I'd like this patch to be merged in mainline, so that I 
> won't be forced anymore to patch
> the kernel by hand or to use the -mm patchset.
> Is there something that prevents this to happen?

Wrong interface?

Convert it to use /sys/class/backlight sysfs interface...

						Pavel
-- 
Thanks for all the (sleeping) penguins.
