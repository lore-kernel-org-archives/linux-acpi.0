From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Date: Sun, 30 Jan 2005 17:39:29 +0000
Message-ID: <20050130173929.GA32014@infradead.org>
References: <20050127110125.GE28047@stusta.de> <1106867060.2400.2297.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261746AbVA3Rjf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1106867060.2400.2297.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 27, 2005 at 06:04:20PM -0500, Len Brown wrote:
> I've already asked Bob Moore to migrate to the use of static in the
> interpreter.  There are some somewhat urgent functional issues he needs
> to focus on first, but static is on the list.  If we allow him to do it
> upstream (w/o looking at your patch), then we can avoid a fork in the
> core interpreter code.
> 
> At the same time, the non "R. Byron Moore" files, such as those in
> drivers/acpi, but not in the lower sub-directories, are straight GPL and
> I'll be happy to accept patches to those files immediately.  Note that
> there are 4 straight GPL files in include/acpi as well -- so like the
> drivers/acpi/* files, we can modify them any time when cleanups are
> appropriate in the Linux release cycle.

The files are licensed under a BSD license so all patches against it
are aswell unless explicitly marked.
