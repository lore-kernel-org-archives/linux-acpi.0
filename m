From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 01 Feb 2008 12:29:17 +0100
Message-ID: <1201865357.14573.74.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <1201714051.1222.131.camel@queen.suse.de>
	 <47A0FBD4.6090603@tremplin-utc.net>  <200801311417.57469.lenb@kernel.org>
	 <1201859637.14573.41.camel@queen.suse.de>  <47A2FD6C.4090403@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42419 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYBAL3S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2008 06:29:18 -0500
In-Reply-To: <47A2FD6C.4090403@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Len Brown <lenb@kernel.org>, =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Fri, 2008-02-01 at 14:07 +0300, Alexey Starikovskiy wrote:
> Thomas Renninger wrote:
> > On Thu, 2008-01-31 at 14:17 -0500, Len Brown wrote:
> >   
> > [skipped]
> > Those tables have the same OEM id then the original ones, right?
> > Tables with the same OEM id (the original ones) should get ignored later
> > automatically. IIRC I had some problems with dynamically loaded tables,
> > don't know anymore, they are not that often used and theoretically it
> > should just work for them also.
> >   
> Comparing SSDT by their OEM ID is proved to not work. Right now,
> code checks the whole length of the table to be the same, and only then
> does not load it. It is not the case with any of modified tables, so
> original tables will be tried to load as well.
Ahh, now when you say it, I remember about this darkly...
What a pity..., maybe just comparing the whole header (without the
checksum) could be an option? Or only do this if dsdt_got_overridden
flag is set (ugly, but should be sufficient).

   Thomas

> > I haven't tried too much here, but SSDTs are used more and more often (I
> > saw a machine with 12 SSDTs, especially on IA64 there might be dozens in
> > the future). We should think about the problem now, before we have bugs
> > and need to write down half a book how the reporter finally could
> > provide some useful information.
> >
> >   
> > Have I overseen something?
Damn, I have :(

   Thomas

