From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH 3/6]init call cleanup
Date: Tue, 12 Apr 2005 11:32:29 +0200
Message-ID: <200504121132.30027@bilbo.math.uni-mannheim.de>
References: <1113283855.27646.428.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262075AbVDLJb4@vger.kernel.org>
In-Reply-To: <1113283855.27646.428.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Li Shaohua <shaohua.li@intel.com>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

Li Shaohua wrote:
> Trival patch for CPU hotplug. In CPU identify  part, only did cleaup for
> intel CPUs. Need do for other CPUs if they support S3 SMP.
>
> @@ -405,7 +405,7 @@ void __init init_bsp_APIC(void)
>  	apic_write_around(APIC_LVT1, value);
>  }
>
> -void __init setup_local_APIC (void)
> +void __devinit setup_local_APIC (void)
                                  ^

>  {
>  	unsigned long oldvalue, value, ver, maxlvt;
>

Please remove this space while you are at it.

> @@ -556,7 +556,7 @@ void __init early_cpu_init(void)
>   * and IDT. We reload them nevertheless, this function acts as a
>   * 'CPU state barrier', nothing should get across.
>   */
> -void __init cpu_init (void)
> +void __devinit cpu_init (void)
>  {
>  	int cpu = smp_processor_id();
>  	struct tss_struct * t = &per_cpu(init_tss, cpu);

This one too.

Eike
