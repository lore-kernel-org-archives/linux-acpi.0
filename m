From: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Mon, 4 Apr 2005 13:11:32 -0600 (MDT)
Message-ID: <Pine.LNX.4.61.0504041242420.30273@montezuma.fsmlabs.com>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1112580367.4194.344.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 4 Apr 2005, Li Shaohua wrote:

> Clean up all CPU states including its runqueue and idle thread, 
> so we can use boot time code without any changes.
> Note this makes /sys/devices/system/cpu/cpux/online unworkable.
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  #include <asm/nmi.h>
> +
> +#ifdef CONFIG_STR_SMP
> +extern void cpu_exit_clear(int);
> +#endif

Perhaps change that ifdef to denote something which clearly shows that its 
physical hotplug as we'll need this for other users too.

> +#ifdef CONFIG_STR_SMP
> +extern void do_exit_idle(void);
> +extern void cpu_uninit(void);
> +void cpu_exit_clear(int cpu)
> +{
> +	int sibling;
> +	cpucount --;

Is that protected by the cpu_control semaphore?

Thanks,
	Zwane



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
