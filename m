From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 4 Apr 2005 13:31:29 +0200
Message-ID: <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com> <20050403193750.40cdabb2.akpm@osdl.org> <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261221AbVDDLbh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, zwane@linuxpower.ca, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > >  tree.
> > 
> > Should I merge that thing into mainline?  It seems that a few people are
> > needing it.
> 
> Perhaps we should address the MTRR issue first.
> 
> I've had code in Suspend2 for quite a while (6 months+) that removes the
> sysdev support for MTRRs and saves and restores them with CPU context,
> thereby avoiding the smp_call-while-interrupts-disabled issue. Perhaps
> it would be helpful here?

This seems like separate issue... I'd prefer not to block this patch.

MTRRs should be probably handled by some kind of "cpu is going down"
and "cpu is going up" callbacks... Zwane, do you have any ideas?
Linklist of handlers should be enough...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
