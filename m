From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Thu, 26 Jul 2007 13:45:29 -0400
Message-ID: <200707261345.29902.lenb@kernel.org>
References: <200707251238.50218.lenb@kernel.org> <200707260026.08183.lenb@kernel.org> <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42523 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764424AbXGZRpj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 13:45:39 -0400
In-Reply-To: <alpine.LFD.0.999.0707252353150.3442@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 26 July 2007 02:55, Linus Torvalds wrote:
> 
> On Thu, 26 Jul 2007, Len Brown wrote:
> > 
> > Feel free to share what you know about the benefits vs. the costs
> > of maintaining CONFIG_ACPI_SLEEP as a build option.
> 
> Why don't you just make CONFIG_ACPI_SLEEP dependent on SOFTWARE_SUSPEND 
> and STR?

CONFIG_STR doesn't exist.

I agree it is an attractive notion to have a high level feature presented
to the user, and that the tools should select what is needed to satisfy the
user's request.  Unfortunately Kconfig is exceptionally bad at supporting
this model.  "depend" frustrates users by making config options vanish
without explanation, and "select" is fundamentally broken
because it doesn't enforce dependencies.

> > If you feel that your system has been degraded
> > because it now includes what used to be excluded under
> > CONFIG_ACPI_SLEEP=n, please let me know how.
> 
> I feel that I get asked to include a feature that
>  (a) I have no interest in on that machine
>  (b) I didn't need to include before.
> 
> What was the advantage? And what was it that caused something like this to 
> be a post-rc1 thing. That makes me really unhappy. This is a *regression*.

I'm sorry that one fewer config options has offended your feeling of freedom,
honestly, I am.

I was actually asking how somebody's _system_ has been degraded
by this change -- but I haven't got an objective answer to that one yet.

As I said in my pull request, I agree that the D-state fixes ideally
should have merged a week earlier -- before the rc1 cutoff.
Indeed, we had a hack that could have gone up much earlier.
However, we waited for Rafael's more general list-blessed solution --
and it turned out that solution tripped over CONFIG_ACPI_SLEEP=n.

The reason is because there is a dependency between D-states and S-states.
In particular, devices which are enabled to be system wakeup devices
can be limited in what D-states they can enter (else they may
no longer be able to wake up the system when it is suspended)

I figured that rather than adding more ifdefs to solve that problem,
it was simpler to remove ifdefs.  I was also shocked to find i386 defconfig
with CONFIG_ACPI_SLEEP=n.  Maybe others are not shocked by this
and there is a reason that defconfig on x86_64 supports sleep
and i386 does not.  I assumed it was a bug, maybe I was wrong.

The context for this is the EPA ENERGY STAR specification for Computers,
which went into effect this month.  This spec says that systems which
can not automatically go into suspend within 15 minutes of idle
can _not_ earn a sticker.  No sticker, no client computer sales to governments.
If Linux can't get STR working, broadly deployed, and enabled by default,
then our plans for world domination are going to take a significant hit.

yes, I understand that there are SMP systems that want ACPI and don't
need sleep or CONFIG_HOGPLUG_CPU.  However, I don't see major distros
shipping kernels to their server customers that way, so I didn't think
it would offend a significant part of the community's sense of freedom
if this config option were removed.  Maybe I was wrong.

Obviously, your vote counts more than the sum total of a lot of the community,
so if you want me to put a config option in to allow ACPI w/o ACPI_SLEEP,
I'll simply do it for you.  However, I could do a better job of it
if I had a clear understanding of what the technical benefit of
that option is supposed to be, and how it will make Linux better.

-Len
