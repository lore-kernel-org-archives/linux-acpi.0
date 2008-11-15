From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sat, 15 Nov 2008 16:54:15 +0000
Message-ID: <20081115165415.GA9117@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <200811130758.13420.arvidjaar@mail.ru> <20081113111157.GA30587@srcf.ucam.org> <200811151930.58898.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55398 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYKOQyU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 11:54:20 -0500
Content-Disposition: inline
In-Reply-To: <200811151930.58898.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Nov 15, 2008 at 07:30:57PM +0300, Andrey Borzenkov wrote:
> On Thursday 13 November 2008, Matthew Garrett wrote:
> > On Thu, Nov 13, 2008 at 07:58:09AM +0300, Andrey Borzenkov wrote:
> > 
> > > - exposing two knobs for the *same* thing confuses user level tools; you never
> > > know which one is used and they compete behind your back
> > 
> > How do they compete?
> 
> In my case user level program (kpowersave) decided to use video.ko for
> brightness control (or, may be, it used them both). Which gave me 2 levels
> instead of 8. And there is no way to control it, at least known to me.

Right. But that doesn't mean they're competing, as such. If you set the 
brightness via toshiba_acpi to a value that isn't supported via the 
acpi driver, what value does the acpi backlight claim to be at?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
