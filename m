From: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 22:42:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040316214239.GA28289@hell.org.pl>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040316194805.GC20014@picchio.gall.it>
To: johnstul@us.ibm.com, dtor_core@ameritech.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Daniele Venzano:
> > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > CONFIG_X86_PM_TIMER=y and I noticed that /proc/cpuinfo doesn't get
> > updated when I switch frequency (via sysfs, using powernow-k7). The is
> > issue seems cosmetic only, CPU frequency changes (watching
> > temperature/battery life).
> I can confirm, I'm seeing the same behavior. Please note that the
> bogomips count gets updated, it's only the frequency that doesn't
> change.

Same here with a P4-M, follow-up to John and Dmitry.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
