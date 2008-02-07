From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Wed, 6 Feb 2008 21:51:48 -0500
Message-ID: <200802062151.48404.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <47A0FBD4.6090603@tremplin-utc.net> <1201861297.14573.66.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43365 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287AbYBGCwk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 21:52:40 -0500
In-Reply-To: <1201861297.14573.66.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>


> > > Jeff (Mahony) has adjusted the last bits of it when he updated it to the
> > > latest rcX-gitY version:
> > > Changes:
> > >  We no longer call populate_rootfs() twice. If we want the custom DSDT,
> > >  we load the rootfs before ACPI. Otherwise, it is loaded at the
> > > appropriate
> > >  initcall time. -jeffm

> > I had left it this way because I though Linus had a good reason for 
> > delaying populate_rootfs(). But if it works, fine! Maybe some additional 
> > comments should be added in before the #ifdef's to clearly show that 
> > populate_rootfs() is _always_ called, and they modify only the moment it 
> > is called.

> I don't know about this, I took that change from your patches...

So is the populate_rootfs() change in the pach I have correct, or not?

thanks,
-Len
