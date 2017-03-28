From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ftrace/x86: fix x86-32 triple fault with graph tracing and suspend-to-ram
Date: Tue, 28 Mar 2017 23:12:42 +0200
Message-ID: <2443543.DcYTiKRKUq@aspire.rjw.lan>
References: <6559f36c6c6cdc2552b0bccf31de967367aa790d.1489672478.git.jpoimboe@redhat.com> <20170328113941.37469c9b@gandalf.local.home> <20170328155546.g7cbjblcehjfskyr@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45898 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752401AbdC1VSa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 17:18:30 -0400
In-Reply-To: <20170328155546.g7cbjblcehjfskyr@treble>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>

On Tuesday, March 28, 2017 10:55:46 AM Josh Poimboeuf wrote:
> On Tue, Mar 28, 2017 at 11:39:41AM -0400, Steven Rostedt wrote:
> > On Tue, 28 Mar 2017 11:51:45 +0200
> > Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > 
> > > With both patches applied `./analyze_suspend.py -config 
> > > suspend-callgraph.cfg -filter i915` succeeds on a Lenovo X60t, so 
> > > suspend and resume work perfectly, when tracing is enabled.
> > > 
> > > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > 
> > > It’d be awesome, if you could tag both patches for inclusion into the 
> > > stable Linux Kernel series.
> > 
> > As long as they are not dependent on my patch series, I'm fine with
> > these going to stable.
> 
> Stable sounds fine to me too.  Both patches are independent of your
> x86-32 fentry patch set.

Does https://patchwork.kernel.org/patch/9628301/ need to go into any particular
-stable series or just all of them?

Or should a Fixes: tag be added to it?

Thanks,
Rafael

