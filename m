From: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Tue, 7 Sep 2004 12:02:38 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0409071200480.14053@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
 <200408301309.54465.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
 <200409051802.03976.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268196AbUIGQEV@vger.kernel.org>
In-Reply-To: <200409051802.03976.blaisorblade_spam@yahoo.it>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Sun, 5 Sep 2004, BlaisorBlade wrote:

> > There aren't many users of pm_idle 
> > outside of arch/*/kernel/process.c
> Both APM and ACPI set pm_idle, and both can be modular. It seems, however, 
> they are the only such ones. And since they APM and ACPI refuse to be both 
> loaded, we cannot have (actually) two modules which override pm_idle. So 
> you're right.

There are a few other issues with pm_idle, preempt and modular drivers 
which someone else is looking at, we'll see how things go from there.

Thanks,
	Zwane
