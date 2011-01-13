From: Len Brown <lenb@kernel.org>
Subject: Re: on builds/randconfigs (was: [PATCH -next] thermal: depends on NET)
Date: Wed, 12 Jan 2011 22:31:55 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101122226340.19754@x980>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au>
 <alpine.LFD.2.02.1101121257580.18873@x980>
 <20110112131800.d64c1a86.akpm@linux-foundation.org>
 <201101122224.54330.rjw@sisk.pl> <alpine.LFD.2.02.1101121654000.19754@x980>
 <20110113114446.cba7a01f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20110113114446.cba7a01f.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>, Michal Marek <mmarek@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Linus <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 13 Jan 2011, Stephen Rothwell wrote:

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

I expect that users want to interact only with select.

See feature X, enable feature X, and feature X
selects what is necessary to support what the user requested...

user interact with "depends-on", by comparison, is torture.
Users are not offered options unless the options
already have all of their dependencies met.
If they manually edit the config file and enable such
options, make oldconfig magically throws away their choices.
That drives people crazy.

cheers,
Len Brown, Intel Open Source Technology Center
