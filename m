From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Tue, 05 Apr 2005 09:06:34 +0800
Message-ID: <1112663194.17861.12.camel@sli10-desk.sh.intel.com>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261464AbVDEBJI@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-04-05 at 03:11, Zwane Mwaikambo wrote:
> On Mon, 4 Apr 2005, Li Shaohua wrote:
> 
> > Clean up all CPU states including its runqueue and idle thread, 
> > so we can use boot time code without any changes.
> > Note this makes /sys/devices/system/cpu/cpux/online unworkable.
> >  
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  #include <asm/nmi.h>
> > +
> > +#ifdef CONFIG_STR_SMP
> > +extern void cpu_exit_clear(int);
> > +#endif
> 
> Perhaps change that ifdef to denote something which clearly shows that its 
> physical hotplug as we'll need this for other users too.
Ok.

> > +#ifdef CONFIG_STR_SMP
> > +extern void do_exit_idle(void);
> > +extern void cpu_uninit(void);
> > +void cpu_exit_clear(int cpu)
> > +{
> > +	int sibling;
> > +	cpucount --;
> 
> Is that protected by the cpu_control semaphore?
cpu_exit_clear is called before the dead CPU ack CPU_DEAD, so it's
finished before __cpu_die returns, which is protected by cpu_control.
Maybe I should add comments for it.

Thanks,
Shaohua
