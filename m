From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] ftrace/x86: fix x86-32 triple fault with graph tracing
 and suspend-to-ram
Date: Tue, 28 Mar 2017 16:42:18 -0500
Message-ID: <20170328214218.qnvkyukxrpkquxvr@treble>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com>
 <20170328113941.37469c9b@gandalf.local.home>
 <20170328155546.g7cbjblcehjfskyr@treble>
 <2443543.DcYTiKRKUq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdC1Vml (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 17:42:41 -0400
Content-Disposition: inline
In-Reply-To: <2443543.DcYTiKRKUq@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>

On Tue, Mar 28, 2017 at 11:12:42PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, March 28, 2017 10:55:46 AM Josh Poimboeuf wrote:
> > On Tue, Mar 28, 2017 at 11:39:41AM -0400, Steven Rostedt wrote:
> > > On Tue, 28 Mar 2017 11:51:45 +0200
> > > Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > > 
> > > > With both patches applied `./analyze_suspend.py -config 
> > > > suspend-callgraph.cfg -filter i915` succeeds on a Lenovo X60t, so 
> > > > suspend and resume work perfectly, when tracing is enabled.
> > > > 
> > > > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > > 
> > > > It’d be awesome, if you could tag both patches for inclusion into the 
> > > > stable Linux Kernel series.
> > > 
> > > As long as they are not dependent on my patch series, I'm fine with
> > > these going to stable.
> > 
> > Stable sounds fine to me too.  Both patches are independent of your
> > x86-32 fentry patch set.
> 
> Does https://patchwork.kernel.org/patch/9628301/ need to go into any particular
> -stable series or just all of them?
> 
> Or should a Fixes: tag be added to it?

As far as I can tell this issue has been around since the function_graph
tracer was introduced in 2008:

  15e6cb3673ea ("tracing: add a tracer to catch execution time of kernel functions")

(Though only for gcc >= 4.4.)

Not sure if it's overkill to specify 'Fixes' for an 8+ year old bug?  I
guess it can't hurt anything.

I think it can go in all of the stable branches.

-- 
Josh
