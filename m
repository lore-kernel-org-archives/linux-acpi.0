From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 19:30:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403161930.35110.dtor_core@ameritech.net>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <200403161819.55351.dtor_core@ameritech.net> <1079479950.5408.53.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1079479950.5408.53.camel@cog.beaverton.ibm.com>
Content-Disposition: inline
To: john stultz <johnstul@us.ibm.com>
Cc: acpi-devel@lists.sourceforge.net, Karol Kozimor <sziwan@hell.org.pl>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 March 2004 06:32 pm, john stultz wrote:
> On Tue, 2004-03-16 at 15:19, Dmitry Torokhov wrote:
> > PM timer does not install CPUFREQ handler which would scale cpu_khz to
> > give proper display. I might cook up something later tonight.
> 
> Actually, the cpufreq handler is installed by an initcall regardless of
> which time-source is used. However as the handler changes a few TSC
> specific variables, it exits in timer_tsc.c.
>

Yes, you are of course right, I missed that fact, sorry.

-- 
Dmitry
