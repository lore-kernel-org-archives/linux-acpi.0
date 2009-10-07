From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
	to `__udivdi3' in menu governor)
Date: Wed, 7 Oct 2009 13:45:54 -0400
Message-ID: <20091007174553.GC11702@bombadil.infradead.org>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de> <4ACCA44B.3070706@linux.intel.com> <20091007173457.GA25415@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759730AbZJGRqe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091007173457.GA25415@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 07, 2009 at 07:34:58PM +0200, Andreas Mohr wrote:
> Nopeee.
> 
>         data->predicted_us = DIV_ROUND_CLOSEST((u32)
>                 data->expected_us * data->correction_factor[data->bucket],
>                 (u32)RESOLUTION * DECAY);
> 
> It did properly rebuild drivers/cpuidle/governors/menu.o.
> Still happening.
> IOW it must be somewhere inside the DIV_ROUND_CLOSEST macro or so.
> 

It's being a jerk and not realizing that RESOLUTION * DECAY is a power
of 2, so it can just do a shift...

I don't recall if gcc 3 had these magic builtins, but if it does,
something like this might help since it's the u64 case that's
problematic.

I probably noviced this in some trivial way, but it's a thought.
And in the most-annoying case (most of these u64 divisions are power of
2, that I've seen...) would sort things out.

regards, Kyle

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d3cd23f..4936eb6 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -51,6 +51,9 @@ extern const char linux_proc_banner[];
 #define DIV_ROUND_CLOSEST(x, divisor)(			\
 {							\
 	typeof(divisor) __divisor = divisor;		\
+	if (__builtin_types_compatible_p(typeof(divisor), unsigned long long) &&	\
+		__builtin_popcountll(__divisor) == 1)			\
+		(((x) + ((__divisor) / 2) << __builtin_ffsll(__divisor)));	\
 	(((x) + ((__divisor) / 2)) / (__divisor));	\
 }							\
 )
