From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 04 Apr 2005 17:24:12 +0800
Message-ID: <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
	 <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
	 <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
	 <1112604263.4194.367.camel@sli10-desk.sh.intel.com>
	 <20050404091027.GA14765@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261189AbVDDJ0m@vger.kernel.org>
In-Reply-To: <20050404091027.GA14765@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@cyclades.com, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ACPI List <acpi-devel@lists.sourceforge.net>, Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-04-04 at 17:10, Pavel Machek wrote:
> Hi!
> 
> > > I'm switching suspend2 to use hotplug too. Li, I'll try adding your
> > > patches as well as Zwane's if you like 
> > Great!
> > 
> > > (suspend2 can enter S3, S4 or S5
> > > after writing the image). I'd love to try it on my HT desktop, and
> > > hotplug will get more testing too :>
> > Unfortunately, my patches break Pavel's swsusp SMP, as my patches break
> > current 'cpu_up' mechanism. S4 doesn't require to boot AP CPUs from real
> > mode.
> 
> Uh, I don't like that one. Is it possible to put secondary CPUs back
> to the real mode 
Possibly doesn't need the trouble. Send a SIPI also can wakeup the a CPU
in protected mode.

> so that cpu_up mechanism can handle them?
If S4 also calls a smp_prepare_cpu, then the patches don't break S4. If
people don't complain warm boot a CPU is slow, I'd like S4 also use
smp_prepare_cpu.

Thanks,
Shaohua
