From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of
 warn_on_slowpath()
Date: Wed, 2 Jul 2008 13:35:40 -0700
Message-ID: <20080702133540.20d578cd.akpm@linux-foundation.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>
	<20080701131714.5093fa49.akpm@linux-foundation.org>
	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>
	<20080701133535.f92a673c.akpm@linux-foundation.org>
	<20080702112852.05f30950.randy.dunlap@oracle.com>
	<486BCDDC.1000709@firstfloor.org>
	<20080702121424.a3451eae.akpm@linux-foundation.org>
	<486BD785.5050207@firstfloor.org>
	<20080702124316.61cc76e9.akpm@linux-foundation.org>
	<486BE0DA.2090108@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57760 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753041AbYGBUh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 16:37:29 -0400
In-Reply-To: <486BE0DA.2090108@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: randy.dunlap@oracle.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org

On Wed, 02 Jul 2008 22:11:06 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> Here's a patch. Can you use that one instead of Randy's please?
> 

No.

> 
> [bug-fallback  text/plain (593B)]
> Supply warn_on_slow_path() even for the !CONFIG_BUG case
> 
> Fix build problem with ACPI for !CONFIG_BUG. Noted by Randy Dunlap.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 2632328..d0d83b7 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -63,6 +63,9 @@ extern void warn_on_slowpath(const char *file, const int line);
>  	unlikely(__ret_warn_on);					\
>  })
>  #endif
> +
> +static inline void warn_on_slowpath(const char *file, const int line) {}
> +
>  #endif

There's no reason why asm/bug.h has to even include asm-generic/bug.h. 
And there's no reason why an architecture which defined __WARN needs to
define warn_on_slowpath() even if it _does_ include asm-generic/bug.h. 
And I didn't even begin to look at what might disable
WANT_WARN_ON_SLOWPATH.

This is all poking deep into the private internals of one particular
implementation of this interface.

Furthermore even if it _does_ happen to work, you've gone and coupled
the availability of this acpi debbugging feature to CONFIG_BUG, which
seems arbitrary.

If you really want to do it this way (and it sounds reasonable) then
can we please do it in a less-than-totally-hacky-and-broken way?



For example, define a new, always-available helper function in (say)
kernel/panic.c along the lines of

void emit_warning_message(?)(const char *msg, int line)


and then call that from warn_on_slowpath().  Will require that
warn_on_slowpath become inlined so we don't get a useless extra entry
in the backtraces all the time.

Or just use printk and dump_stack.
