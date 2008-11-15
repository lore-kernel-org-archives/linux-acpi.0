From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 17:11:10 +0000
Message-ID: <20081115171110.GA9332@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <200811151930.58898.arvidjaar@mail.ru> <20081115165415.GA9117@srcf.ucam.org> <200811152005.05031.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58248 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYKORLP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 12:11:15 -0500
Content-Disposition: inline
In-Reply-To: <200811152005.05031.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Nov 15, 2008 at 08:05:04PM +0300, Andrey Borzenkov wrote:
> On Saturday 15 November 2008, Matthew Garrett wrote:
> > Right. But that doesn't mean they're competing, as such. If you set the 
> > brightness via toshiba_acpi
> 
> I probably have problems with expressing myself as non-native English
> speaker.
> 
> I am not interested in setting values via echoing into sysfs file. I
> am interested in my desktop brightness control working out of the box.
> And desktop driver control has no way to select, which of two sysfs
> files to use. Nor do I understand why I have to create this problem
> of selecting right driver when I already have possibility to avoid it.
> 
> If you think exposing both knobs is non-issue, why are all those patches
> for other vendor drivers included in the kernel in the first place?

Because in some of those cases, the ACPI and vendor function are 
implemented in different ways that can then get out of sync with each 
other. As a result, you can get garbage information. If the values in 
your two backlight interfaces are always sane, then there's no inherent 
need to hide one of them. The kernel exposes the available functionality 
and userland then determines the policy used to choose one over the 
other.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
