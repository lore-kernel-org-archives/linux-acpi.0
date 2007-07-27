From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] let SUSPEND select HOTPLUG_CPU
Date: Sat, 28 Jul 2007 00:47:37 +0200
Message-ID: <46AA7609.1040900@s5r6.in-berlin.de>
References: <200707251238.50218.lenb@kernel.org> <200707262117.26353.rjw@sisk.pl> <alpine.LFD.0.999.0707261255380.3442@woody.linux-foundation.org> <200707262248.09187.rjw@sisk.pl> <alpine.LFD.0.999.0707261351430.3442@woody.linux-foundation.org> <20070727222503.GB15129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S938124AbXG0Wsv@vger.kernel.org>
In-Reply-To: <20070727222503.GB15129@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

Adrian Bunk wrote:
> The dependency of SUSPEND_SMP on HOTPLUG_CPU is quite unintuitive,

It's not entirely unintuitive.  That option's full name is "Support for
suspend on SMP and hot-pluggable CPUs".

Only the place where you find the option is unintuitive, as far as its
first application is concerned.  (It lives in the "Processor type and
features" menu which is OK for the 2nd application of this option.)  And
the variable name of that option is unintuitive because it covers only
the 2nd application of the option, I suppose for historical reasons.

> +config SUSPEND_SMP_POSSIBLE
> +	bool
> +	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES || PPC_PMAC))
> +	depends on SMP
> +	default y
> +
> +config SUSPEND_SMP
> +	bool
> +	depends on SUSPEND_SMP_POSSIBLE && SOFTWARE_SUSPEND
> +	select HOTPLUG_CPU
> +	default y

Yes, that's the price to pay if you want to select something that in
turn depends on a number of other things.

Wait, doesn't HOTPLUG_CPU also depend on EXPERIMENTAL?
-- 
Stefan Richter
-=====-=-=== -=== ===--
http://arcgraph.de/sr/
