From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 18:19:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200403161819.55351.dtor_core@ameritech.net>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it> <20040316214239.GA28289@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040316214239.GA28289@hell.org.pl>
Content-Disposition: inline
To: acpi-devel@lists.sourceforge.net
Cc: Karol Kozimor <sziwan@hell.org.pl>, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 March 2004 04:42 pm, Karol Kozimor wrote:
> Thus wrote Daniele Venzano:
> > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > > issue seems cosmetic only, CPU frequency changes (watching
> > > temperature/battery life).
> > I can confirm, I'm seeing the same behavior. Please note that the
> > bogomips count gets updated, it's only the frequency that doesn't
> > change.
> 
> Same here with a P4-M, follow-up to John and Dmitry.
> Best regards,
> 

PM timer does not install CPUFREQ handler which would scale cpu_khz to
give proper display. I might cook up something later tonight.

-- 
Dmitry
