From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Runtime switching to idle_poll (was: Re: 2.6.14-rt13)
Date: Sat, 26 Nov 2005 14:05:48 +0100
Message-ID: <20051126130548.GA6503@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu> <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu> <1132367947.5706.11.camel@localhost.localdomain> <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932152AbVKZNG2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132952191.24417.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: acpi-devel@lists.sourceforge.net, len.brown@intel.com, Andrew Morton <akpm@osdl.org>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net, john cooper <john.cooper@timesys.com>, Benedikt Spranger <bene@linutronix.de>, Daniel Walker <dwalker@mvista.com>, Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>
List-Id: linux-acpi@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> As a request from Ingo, I fixed up this patch a little to allow both 
> x86_64 and i386 to switch to and from idle_poll at runtime.  I noticed 
> that the APCI driver in drivers/acpi/processor_idle.c may cause some 
> race condition with this patch so I added some protection there. 
> Basically, if the acpi code changes pm_idle, then you can't change to 
> idle_poll, and vice-versa.
> 
> What this patch does is creates an entry into 
> /sys/kernel/idle/idle_poll.  It will show whether or not the idle_poll 
> is being used as a runtime idle routine.  It is also used to set the 
> runtime idle.
> 
> with:
> 
> # echo 1 > /sys/kernel/idle/idle_poll
>   or
> # echo on > /sys/kernel/idle/idle_poll

find some minor cleanups below.

a more general question is, shouldnt the configuration method rather be 
something like:

   echo idle > /sys/kernel/idle

and there could also be a /sys/kernel/idle_methods which would enumerate 
all the strings that are possible? This way we'd not hardcode 
'idle-poll' in any way.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/process.c   |    6 +++---
 arch/x86_64/kernel/process.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -65,11 +65,11 @@ static int hlt_counter;
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-spinlock_t pm_idle_switch_lock = SPIN_LOCK_UNLOCKED;
-EXPORT_SYMBOL(pm_idle_switch_lock);
+DEFINE_SPINLOCK(pm_idle_switch_lock);
+EXPORT_SYMBOL_GPL(pm_idle_switch_lock);
 
 int pm_idle_locked = 0;
-EXPORT_SYMBOL(pm_idle_locked);
+EXPORT_SYMBOL_GPL(pm_idle_locked);
 
 /*
  * Return saved PC of a blocked thread.
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -61,11 +61,11 @@ static atomic_t hlt_counter = ATOMIC_INI
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 
-spinlock_t pm_idle_switch_lock = SPIN_LOCK_UNLOCKED;
-EXPORT_SYMBOL(pm_idle_switch_lock);
+DEFINE_SPINLOCK(pm_idle_switch_lock);
+EXPORT_SYMBOL_GPL(pm_idle_switch_lock);
 
 int pm_idle_locked = 0;
-EXPORT_SYMBOL(pm_idle_locked);
+EXPORT_SYMBOL_GPL(pm_idle_locked);
 
 /*
  * Powermanagement idle function, if any..
