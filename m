From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22
Date: Sun, 29 Apr 2007 01:01:04 -0700
Message-ID: <20070429010104.68c51d1a.akpm@linux-foundation.org>
References: <200704290102.33533.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:49236 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932659AbXD2ICi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 04:02:38 -0400
In-Reply-To: <200704290102.33533.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Miles Lane <miles.lane@gmail.com>, lollul@wp.pl, Matt Mackall <mpm@selenic.com>, Helge Hafting <helgehaf@aitel.hist.no>

On Sun, 29 Apr 2007 01:02:33 -0400 Len Brown <lenb@kernel.org> wrote:

> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> This batch mostly updates the platform-specific drivers that use ACPI.
> The EC and sbs changes are primarily cleanups.
> There are no changes to the ACPICA core, except a single bugfix
> that was related to a 2.6.21 boot regression on some older machines.
> And then the usual mix of random tweaks.

There might still be a few regressions in this lot:

- Miles Lane's "2.6.21-rc7-mm2 -- gnome-power-manager always shows the
  power as coming from AC"

- "battery caching introduces a lock up"
  http://bugzilla.kernel.org/show_bug.cgi?id=8351

These are older and might have been fixed:

- Mat Mackall's "Thinkpads not waking up on lid open with -rc6-mm1"

- Helge Hafting's "2.6.21-rc3-mm2 hangs my opteron during bootup, ACPI?"

