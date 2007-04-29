From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22
Date: Sun, 29 Apr 2007 11:53:10 -0400
Message-ID: <200704291153.10451.lenb@kernel.org>
References: <200704290102.33533.lenb@kernel.org> <20070429010104.68c51d1a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42186 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405AbXD2Pyj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 11:54:39 -0400
In-Reply-To: <20070429010104.68c51d1a.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Miles Lane <miles.lane@gmail.com>, lollul@wp.pl, Matt Mackall <mpm@selenic.com>, Helge Hafting <helgehaf@aitel.hist.no>

On Sunday 29 April 2007 04:01, Andrew Morton wrote:
> On Sun, 29 Apr 2007 01:02:33 -0400 Len Brown <lenb@kernel.org> wrote:
> 
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> > 
> > This batch mostly updates the platform-specific drivers that use ACPI.
> > The EC and sbs changes are primarily cleanups.
> > There are no changes to the ACPICA core, except a single bugfix
> > that was related to a 2.6.21 boot regression on some older machines.
> > And then the usual mix of random tweaks.
> 
> There might still be a few regressions in this lot:
> 
> - Miles Lane's "2.6.21-rc7-mm2 -- gnome-power-manager always shows the
>   power as coming from AC"
> 
> - "battery caching introduces a lock up"
>   http://bugzilla.kernel.org/show_bug.cgi?id=8351

This git pull request does not include the proposed changes to the battery.

cheers,
-Len

> These are older and might have been fixed:
> 
> - Mat Mackall's "Thinkpads not waking up on lid open with -rc6-mm1"
> 
> - Helge Hafting's "2.6.21-rc3-mm2 hangs my opteron during bootup, ACPI?"
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
