From: Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH 00/22] various dynamic_debug patches
Date: Fri, 21 Sep 2018 20:27:09 -0400
Message-ID: <b2976966-8c48-2798-b2d6-cf7be45ed25f@akamai.com>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 09/19/2018 06:04 PM, Rasmus Villemoes wrote:
> This started as an experiment to see how hard it would be to change
> the four pointers in struct _ddebug into relative offsets, a la
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
> pr_debug site (and thus exactly making up for the extra space used by
> the introduction of jump labels in 9049fc74). I stumbled on a few
> things that are probably worth fixing regardless of whether the latter
> half of this series is deemed worthwhile.
> 
> Patch relationships: 1-2, 3-4, 5-6 and 15-16 can be applied
> individually, though 2, 4 and 6 probably makes most sense in the
> context of the final goal of the series.
> 
> 7-12 I believe make sense on their own. Patch 13 again only makes
> sense if we go all the way, and 14 and 17 depend on 13.
> 
> 18-21 are more preparatory patches, and finally 22 switch over x86-64
> to use CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS. I've tested that the
> end result boots under virtme and that the dynamic_debug control file
> has the expected contents.
> 

I would like to to see all these patches included. Feel free to add:
Acked-by: Jason Baron <jbaron@akamai.com>

I've been wanting to add DYNAMIC_DEBUG_BRANCH to the
[dev,net,pr].*ratelimited functions. That should reduce the size of the
text as well.

Thanks,

-Jason
