From: Len Brown <len.brown@intel.com>
Subject: Re: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Date: 27 Jan 2005 18:04:20 -0500
Message-ID: <1106867060.2400.2297.camel@d845pe>
References: <20050127110125.GE28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261294AbVA0XNZ@vger.kernel.org>
In-Reply-To: <20050127110125.GE28047@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-27 at 06:01, Adrian Bunk wrote:
> Before I'm getting flamed to death:
> This patch isn't meant for being immediately applied.
> 
> This patch makes all needlessly global code under drivers/acpi/
> static.
> Please review this patch.

Thanks for the patch Adrian.

I agree that this is the right direction to go -- enforcing APIs with
the use of static reduces the possibility of programming errors --
particularly with many cooks in the kitchen.  Indeed, just on Monday we
discussed a patch from Alexey Starikovskiy to do the same thing.

The problem is one of logistics.
As I've described before, the files with "R. Byron Moore" at the top are
dual-licensed so Intel can distribute the core interpreter both as GPL
to Linux and also to FreeBSD, HP-UX etc.

Yes, GPL is GPL and that gives the Linux community the right to do
whatever is needed to those files.  But patches accepted to the core
interpreter under GPL can not be applied to the upstream interpreter --
so they're effectively a fork that code.

We've forked in other areas, the largest is your FUTURE_USAGE patch
which I accepted.  But forks have a non-zero cost on me, and I have a
big enough task trying to make Linux/ACPI the best implementation
possible without getting sidetracked by avoidable logisital challenges. 
So here is what I propose.

I've already asked Bob Moore to migrate to the use of static in the
interpreter.  There are some somewhat urgent functional issues he needs
to focus on first, but static is on the list.  If we allow him to do it
upstream (w/o looking at your patch), then we can avoid a fork in the
core interpreter code.

At the same time, the non "R. Byron Moore" files, such as those in
drivers/acpi, but not in the lower sub-directories, are straight GPL and
I'll be happy to accept patches to those files immediately.  Note that
there are 4 straight GPL files in include/acpi as well -- so like the
drivers/acpi/* files, we can modify them any time when cleanups are
appropriate in the Linux release cycle.

thanks,
-Len
