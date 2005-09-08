From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Thu, 08 Sep 2005 13:53:05 +0200
Message-ID: <43202621.9080600@tzi.de>
References: <1126178956.24699.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1126178956.24699.42.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Erik Slagter schrieb:
> Hi,
> 
> I compiled & installed 2.6.13 (vanilla) on my Tyan Tiger S2466 (AMD768
> chipset, 2xathlon MP 2600) yesterday. Indeed, as expected, acpi
> "/proc/acpi/processor/*/power" (C states) is now supported on SMP. But,
> to my surprise, it only shows one C state (C1), which, I assume, is
> full-on. I am not completely sure about the CPU, but I do know that at
> least the chipset supports C2 and C3 states (even got it sort of working
> with pm_amd76x).
> 
> Can someone shine some light on this?
> 
> active state:            C1
> max_cstate:              C8
> bus master activity:     00000000
> states:
>    *C1:                  type[C1] promotion[--] demotion[--]
> latency[000] usage[59379522]
> 
> --- 8-< ----
> 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(tm) Processor
> stepping        : 1
> cpu MHz         : 2133.515
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
> mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 4266.27
> 
> Thx.

Uhm Linux can't detect something, that is not given by your DSDT...
Even if the CPU and the Chipset support C80, als long as your DSDT does 
not define these states, Linux can't detect them. Extract your DSDT, 
decompile it and search it for the _CST and P_BLK structs. Then verify 
if these structs acually contain C-States (There are some latency 
restrictions for the C-States defined in the P_BLK, for more information 
see www.acpi.info). If you done this please report back.
     Janosch


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
