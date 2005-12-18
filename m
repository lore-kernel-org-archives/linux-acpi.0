From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Sun, 18 Dec 2005 10:26:14 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0512181021170.20098@gandalf.stny.rr.com>
References: <1132336954.20672.11.camel@cmn3.stanford.edu>
 <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu>
 <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu>
 <1132367947.5706.11.camel@localhost.localdomain> <20051124150731.GD2717@elte.hu>
 <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu>
 <1133232503.6328.18.camel@localhost.localdomain> <20051129130843.GA9991@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965117AbVLRP0Z@vger.kernel.org>
In-Reply-To: <20051129130843.GA9991@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net, len.brown@intel.com, Andrew Morton <akpm@osdl.org>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net, john cooper <john.cooper@timesys.com>, Benedikt Spranger <bene@linutronix.de>, Daniel Walker <dwalker@mvista.com>, Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>
List-Id: linux-acpi@vger.kernel.org


On Tue, 29 Nov 2005, Pavel Machek wrote:

> Hi!
>
> > Description:
> >
> > This patch creates a directory in /sys/kernel called idle.  This
> > directory contains two files: idle_ctrl and idle_methods.  Reading
> > idle_ctrl will show the function that is currently being used for idle,
> > and idle_methods shows the available methods for the user to send write
> > into idle_ctrl to change which function to use for idle.
>
> Pretty ugly interface, I'd say... is listing function really neccessary?
>

What interface would you prefer?  And the listing was a feature request
made by Ingo.

But this is pretty much moot, since the patch is not going any further
than the RT patch. And even then, it probably is only temporary, if it is
even still in there (I haven't checked).

--Steve
