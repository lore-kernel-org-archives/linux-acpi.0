From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Tue, 18 Mar 2008 16:32:43 -0400
Message-ID: <200803181632.44288.lenb@kernel.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <200803171327.16695.lenb@kernel.org> <1205858252.21619.233.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40095 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768AbYCTCRP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Mar 2008 22:17:15 -0400
In-Reply-To: <1205858252.21619.233.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>, Linus Torvalds <torvalds@linux-foundation.org>, Tilman Schmidt <tilman@imap.cc>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arjan van de Ven <arjan@infradead.org>


> > The initrd version of the DSDT override is really for one scenario.
> > Somebody who has a BIOS that even Windows can't deal with -- so
> > no amount of "Windows bug compatbility" will help Linux with it.

> No, this is for people getting involved in ACPI.
> Everybody thinks ACPI is that complicated..., but it's not.
> It's amazing how far people can debug ACPI bugs (yes, even people who
> "do not even know" how to compile a kernel) by simply analyzing the ASL
> BIOS code.

Thomas,
The justification above is what convinced me
that we should try to integrate this feature.
Further, although we failed in 2.6.25,
I think we should continue to try to get this capability integrated.

If you think it will be useful for additional purposes, that's great.
As you know, I'm somewhat skeptical, as I've seen huge mistakes such
as a database of modified BIOS images created and used when the users
have absolutely no idea what they're doing.  But we don't have to
agree on this to move forward.

thanks,
-Len
