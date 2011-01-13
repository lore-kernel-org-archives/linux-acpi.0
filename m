From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: on builds/randconfigs (was: [PATCH -next] thermal: depends on
 NET)
Date: Wed, 12 Jan 2011 22:45:40 -0500
Message-ID: <1294890340.26623.383.camel@gandalf.stny.rr.com>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au>
	 <alpine.LFD.2.02.1101121257580.18873@x980>
	 <20110112131800.d64c1a86.akpm@linux-foundation.org>
	 <201101122224.54330.rjw@sisk.pl> <alpine.LFD.2.02.1101121654000.19754@x980>
	 <20110113114446.cba7a01f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:49263 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab1AMDpo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 22:45:44 -0500
In-Reply-To: <20110113114446.cba7a01f.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>, Michal Marek <mmarek@suse.cz>, Linus <torvalds@linux-foundation.org>

On Thu, 2011-01-13 at 11:44 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 12 Jan 2011 16:58:26 -0500 (EST) Len Brown <lenb@kernel.org> wrote:
> >
> > Kconfig select needs to be fixed so that it is not possible to
> > select something if that something's dependencies are not met.
> 
> So, should the config step fail if such a thing is attempted, or just not
> honour the "select"?
> 
> BTW, Linus asked me to investigate the alternative of having "select"
> (recursively) automatically set the dependencies if they are not already
> set ...
> 

What happens if you have foo depends on bar || fib ?

Do you automatically enable bar and fib?

-- Steve


