From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: problem with suspend and usb
Date: Fri, 24 Sep 2004 22:22:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040924202239.GB826@openzaurus.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz> <20040922094844.GA9197@elf.ucw.cz> <1095870490.3809.3.camel@taz.graycell.biz> <20040922175058.GA14891@elf.ucw.cz> <1095981566.4339.16.camel@taz.graycell.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269137AbUIXUmZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1095981566.4339.16.camel@taz.graycell.biz>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Kernel <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> OK, I inserted a printk between each line of acpi_power_off, I see
> set_cpus_allowed finished and then the pause, then after ~30s the
> poweroff, I never get to see the remaining printk.

Uh, can you quote lines that cause slowdown? This is probably best done
on acpi list, perhaps even go to bugzilla.kernel.org.

> By the way, is there a swsusp specific list?
> 

No. There's suspend2-specific list, but thats different codebase.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
