From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] intermittent suspend problem again
Date: Sun, 29 Nov 2009 01:29:25 +0100
Message-ID: <200911290129.25505.rjw@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911182313.14092.rjw@sisk.pl> <87d4324gp7.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753665AbZK2A3E@vger.kernel.org>
In-Reply-To: <87d4324gp7.fsf@tac.ki.iif.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 28 November 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Wednesday 18 November 2009, Ferenc Wagner wrote:
> >
> >> Ferenc Wagner <wferi@niif.hu> writes:
> >> 
> >>> Since I've instrumented s2disk and the hibernation path, no freeze
> >>> happened during hibernating the machine.
> >> 
> >> Not until I removed the delays from hibernation_platform_enter(), which
> >> were put there previously to get step-by-step feedback.  Removing them
> >> again resulted in a freeze in short course, maybe just two hibernations
> >> later.  The instrumentation shows it stuck in dpm_suspend_start(PMSG_HIBERNATE).
> >> Does it mean that some device driver is at fault?
> >
> > A driver or one of the platform hooks.
> >
> >> I'll check if it always fails at the same point (although tracing into
> >> dpm_suspend_start isn't pure fun because of the multitude of devices it
> >> loops over).  Is there any way to get printk output from that phase?
> >
> > Compile with CONFIG_PM_VERBOSE (it does mean exactly that).
> 
> The last message now was:
> 
> e100: 0000:02:08.0: hibernate, may wakeup
> 
> Looks like hibernating the e100 driver is unstable.

Can you verify that by trying to hibernate without the e100 driver?

Rafael
