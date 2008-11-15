From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 17:20:52 +0000
Message-ID: <20081115172052.GA9537@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <200811152005.05031.arvidjaar@mail.ru> <20081115171110.GA9332@srcf.ucam.org> <200811152017.56926.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47251 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYKORU5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 12:20:57 -0500
Content-Disposition: inline
In-Reply-To: <200811152017.56926.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Nov 15, 2008 at 08:17:52PM +0300, Andrey Borzenkov wrote:
> On Saturday 15 November 2008, Matthew Garrett wrote:
> > > If you think exposing both knobs is non-issue, why are all those patches
> > > for other vendor drivers included in the kernel in the first place?
> > 
> > Because in some of those cases, the ACPI and vendor function are 
> > implemented in different ways that can then get out of sync with each 
> > other. As a result, you can get garbage information. If the values in 
> > your two backlight interfaces are always sane, then there's no inherent 
> > need to hide one of them.
> 
> THE VALUE IN MY TWO BACKLIGHT INTERFACES ARE NOT THE SAME. I said this many
> times already. What exactly is not clear in this sentence?

Where did I say that they were? You never answered the question I asked 
- if you set the value in the toshiba specific backlight control to a 
value that isn't supported via the generic acpi one, what value does the 
generic acpi one claim to have?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
