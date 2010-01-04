From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: Re: [PATCH]tickless: Fix tick nohz timer irq0 fail to increaase
Date: Mon, 4 Jan 2010 16:40:42 -0500
Message-ID: <20100104214042.GA16579@youquan-linux.bj.intel.com>
References: <20091214130233.GA3898@youquan-linux.bj.intel.com> <20100104104905.GA30574@youquan-linux.bj.intel.com> <20100104043650.6acfb056@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:6724 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753481Ab0ADOFt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 09:05:49 -0500
Content-Disposition: inline
In-Reply-To: <20100104043650.6acfb056@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Youquan,Song" <youquan.song@linux.intel.com>, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, venkatesh.pallipadi@intel.com, suresh.b.siddha@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> > Tickless is disabled by nohz=off, which is used in OSVs.
> 
> it is? I doubt anyone wants to normally disable tickless, the power
> cost is just too high....
tickless is normally used but it is possible to use for some special users, 
tickless is disabled by nohz=off kernel option, which is address in OSV's 
release notes.

> > But in
> > current kernel, if tickless is disabled, the timer irq0 will not
> > increase.
> 
> why is this a problem? 

Two reasons: 
R1:
In my mind, tick is period timer with frequent of HZ. but timer irq0 is
actually be an oneshot mode timer.
But in real watch, it is keep not increase for long time. but it
suddenly increase 5000~10000 times in a seconds.

R2:
Tickless disable, change cpuidle driver to ladder governor(menu does not
work at all). 

Run powertop, if apply my patch, the c-state residency has > 10% improvement
than current kernel. 

> 
> > Because the timer event handler should be
> > tick_handle_periodic, but actually event handler keep as
> > tick_handle_oneshot_broadcast which is used in tickless. The root
> > cause is that it is default to enable high resolution timer which
> > will force to oneshot broadcast mode.
> 
> using local apic in one shot mode is not a problem, I'd in fact call it
> a feature...

But in current kernel, local apic timer is in periodic mode with
frequencey of HZ when tickless is disabled.

