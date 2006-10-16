From: Cyril SCETBON <cyril.scetbon@free.fr>
Subject: Re: powernow-k8 and scaling processor
Date: Mon, 16 Oct 2006 14:32:42 +0200
Message-ID: <45337BEA.9030108@free.fr>
References: <4525054F.1040503@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp18.orange.fr ([193.252.22.126]:63362 "EHLO
	smtp-msa-out18.orange.fr") by vger.kernel.org with ESMTP
	id S1422718AbWJPMcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Oct 2006 08:32:48 -0400
In-Reply-To: <4525054F.1040503@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scetbon Cyril <cyril.scetbon@free.fr>
Cc: linux-acpi@vger.kernel.org

Scetbon Cyril wrote:
> Hi people,
> 
> My processor is a sempron 3100+ :
> 
> cat /proc/cpuinfo
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 44
> model name      : Mobile AMD Sempron(tm) 3100+
> stepping        : 2
> cpu MHz         : 800.000
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt 
> 3dnowext 3dnow pni lahf_lm ts fid vid ttp tm stc
> bogomips        : 1598.67
> 
> I'm using powernow-k8 module to scale my processor on userspace demand.
> The frequence of my CPU is 1800MHz but it can't be scaled at more than 
> 1600MHz :
> 
> cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
> 
> 1800000
> 
> cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 
> 1600000
> 
> Sometimes the value above is set to 1800000 but I don't know why it's 
> not always set to cpuinfo_max_freq.
> 
> dmesg|grep -i acpi :
> 
> ACPI: Core revision 20060623
> ACPI: setting ELCR to 0200 (from 0e20)
> ACPI: bus type pci registered
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [C047] (0000:00)
> ACPI: Assume root bridge [\_SB_.C047] bus is 0
> ACPI: PCI Interrupt Routing Table [\_SB_.C047._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.C047.C048._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.C047.C0AB._PRT]
> ACPI: Power Resource [C1CF] (off)
> ACPI: Embedded Controller [C111] (gpe 17) interrupt mode.
> ACPI: Power Resource [C1B7] (on)
> ACPI: Power Resource [C1C7] (on)
> ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
> ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *5
> ACPI: PCI Interrupt Link [C0F2] (IRQs 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [C0F3] (IRQs *10 11)
> ACPI: PCI Interrupt Link [C0F4] (IRQs 10 *11)
> ACPI: PCI Interrupt Link [C0F5] (IRQs *9)
> ACPI: PCI Interrupt Link [C0F6] (IRQs 10 11) *5
> ACPI: PCI Interrupt Link [C0F7] (IRQs *10 11)
> ACPI: Power Resource [C26C] (off)
> ACPI: Power Resource [C26D] (off)
> ACPI: Power Resource [C26E] (off)
> ACPI: Power Resource [C26F] (off)
> PCI: Using ACPI for IRQ routing
> Device `[C1C9]' is not power manageableACPI: PCI Interrupt Link [C0F4] 
> enabled a t IRQ 11
> ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0F4] -> GSI 11 (level, 
> low) -> IRQ  11
> ACPI: PCI Interrupt Link [C0F1] enabled at IRQ 10
> ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [C0F1] -> GSI 10 (level, 
> low) -> IRQ  10
> ACPI: PCI interrupt for device 0000:00:14.6 disabled
> Device `[C1CE]' is not power manageableACPI: PCI Interrupt Link [C0F7] 
> enabled a t IRQ 10
> ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0F7] -> GSI 10 (level, 
> low) -> IRQ  10
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Transitioning device [C270] to D3
> ACPI: Transitioning device [C270] to D3
> ACPI: Fan [C270] (off)
> ACPI: Transitioning device [C271] to D3
> ACPI: Transitioning device [C271] to D3
> ACPI: Fan [C271] (off)
> ACPI: Transitioning device [C272] to D3
> ACPI: Transitioning device [C272] to D3
> ACPI: Fan [C272] (off)
> ACPI: Transitioning device [C273] to D3
> ACPI: Transitioning device [C273] to D3
> ACPI: Fan [C273] (off)
> ACPI: CPU0 (power states: C1[C1] C3[C3])
> ACPI: Processor [C000] (supports 8 throttling states)
> ACPI: Thermal Zone [TZ1] (27 C)
> ACPI: Thermal Zone [TZ2] (23 C)
> ACPI: Thermal Zone [TZ3] (23 C)
> ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 10
> ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [C0F0] -> GSI 10 (level, 
> low) -> IRQ  10
> Time: acpi_pm clocksource has been installed.
> ACPI: PCI Interrupt Link [C0F3] enabled at IRQ 10
> ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [C0F3] -> GSI 10 (level, 
> low) -> IRQ  10
> ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [C0F3] -> GSI 10 (level, 
> low) -> IRQ  10
> Device `[C0E8]' is not power manageable<6>ACPI: PCI Interrupt 
> 0000:00:13.2[A] ->  Link [C0F3] -> GSI 10 (level, low) -> IRQ 10
> ACPI: PCI Interrupt Link [C0F5] enabled at IRQ 9
> ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [C0F5] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt Link [C0F6] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0F6] -> GSI 11 (level, 
> low) -> IRQ  11
> ACPI: PCI Interrupt 0000:02:04.4[C] -> Link [C0F5] -> GSI 9 (level, low) 
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [C0F1] -> GSI 10 (level, 
> low) -> IRQ  10
> ACPI: Battery Slot [C179] (battery present)
> ACPI: Battery Slot [C178] (battery absent)
> ACPI: AC Adapter [C177] (off-line)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [C1F0]
> ACPI: Lid Switch [C1F1]
> ACPI: Video Device [C049] (multi-head: yes  rom: no  post: no)
> 
> Any suggestion ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
anyone ?
