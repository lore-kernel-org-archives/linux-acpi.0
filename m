From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH RESEND] ACPI: Blacklist Win8 OSI for some HP laptop
 2013 models
Date: Tue, 14 Jan 2014 16:34:25 +0000
Message-ID: <20140114163425.GA6649@srcf.ucam.org>
References: <1389611658-19424-1-git-send-email-tiwai@suse.de>
 <20140114161244.GD4307@srcf.ucam.org>
 <6355285.UpbP9PuN7a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60527 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaANQe2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 11:34:28 -0500
Content-Disposition: inline
In-Reply-To: <6355285.UpbP9PuN7a@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Takashi Iwai <tiwai@suse.de>, Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 14, 2014 at 05:42:57PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 14, 2014 04:12:44 PM Matthew Garrett wrote:
> > On Mon, Jan 13, 2014 at 12:14:18PM +0100, Takashi Iwai wrote:
> > > The BIOS on recent HP laptops behaves differently with Win8 OSI,
> > > e.g. no backlight control and no rfkill are available.  List them in
> > > the blacklist as a workaround.
> > 
> > What's the plan for fixing this properly?
> 
> What exactly do you mean by "fixing this properly"?

rfkill and backlight control presumably work fine under Windows 8, so 
there's obviously some new mechanism for doing so. HP will presumably 
ship more hardware that behaves this way, so if we don't add support for 
the new mechanisms then we'll just have to keep adding entries to the 
blacklist.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
