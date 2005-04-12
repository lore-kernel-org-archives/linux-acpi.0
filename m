From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: bk-acpi causes freezes on ia64/tiger
Date: Mon, 11 Apr 2005 19:13:14 -0700
Message-ID: <20050411191314.27dc51d3.akpm@osdl.org>
References: <20050408011437.7fe1159d.akpm@osdl.org>
	<1113190685.2420.36.camel@d845pe>
	<1113252341.2419.44.camel@d845pe>
	<20050411182951.52f76e93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050411182951.52f76e93.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org> wrote:
>
> That server appears to be dead.  I took a punt and reverted the below
>  patch.  That fixed things up.

btw, I have a trace from the soft-lockup detector which appears to tell us
what's going on when this bug bites:


io scheduler noop registered             
BUG: soft lockup detected on CPU#0!
Modules linked in:                 
                  
Pid: 1, CPU 0, comm:              swapper
psr : 00001010085a6010 ifs : 8000000000000691 ip  : [<a00000010004efb0>]    Not tainted
ip is at smp_call_function+0x270/0x3a0                                                 
unat: 0000000000000000 pfs : 0000000000000691 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 5694155165566a95
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0930ffff00090000 ssd : 0930ffff00090000                       
b0  : a00000010004ef70 b6  : 0000000000000000 b7  : a0000001000f78c0
f6  : 0fff5f4898d5f7d3e2694 f7  : 0ffe8823e07cec0000000             
f8  : 1000cea80000000000000 f9  : 100088600000000000000
f10 : 10003dffffffff8396e57 f11 : 1003e000000000000001c
r1  : a000000100e42ff0 r2  : c0000000feec4180 r3  : 00000000000000fe
r8  : c0000000fee00000 r9  : 00000000000c4180 r10 : 0000000000000000
r11 : 000000000000c418 r12 : e00000003c7a7db0 r13 : e00000003c7a0000
r14 : 00000000000000fe r15 : 000000000000c418 r16 : 0000000000000000
r17 : a000000100c66b4c r18 : 00000000000000fe r19 : 0000000000000003
r20 : a000000100c66b40 r21 : a000000100c5dbb0 r22 : a000000100c66b40
r23 : 0000000000000000 r24 : 0000000000000000 r25 : 000000000000000f
r26 : 0000000000000007 r27 : 000000000000000f r28 : a000000100c5fa30
r29 : 0000000000000000 r30 : 0000000000000000 r31 : e00000003c7a0d54
                                                                    
Call Trace:
 [<a00000010000ff60>] show_stack+0x80/0xa0
                                sp=e00000003c7a79f0 bsp=e00000003c7a1270
 [<a0000001000107c0>] show_regs+0x7e0/0x800                             
                                sp=e00000003c7a7bc0 bsp=e00000003c7a1210
 [<a0000001000dcd10>] softlockup_tick+0x130/0x160                       
                                sp=e00000003c7a7bd0 bsp=e00000003c7a11d8
 [<a0000001000a5ae0>] do_timer+0xc0/0x1e0                               
                                sp=e00000003c7a7be0 bsp=e00000003c7a11b0
 [<a000000100033a20>] timer_interrupt+0x2e0/0x340                       
                                sp=e00000003c7a7be0 bsp=e00000003c7a1160
 [<a0000001000dd1f0>] handle_IRQ_event+0x90/0x140                       
                                sp=e00000003c7a7be0 bsp=e00000003c7a1120
 [<a0000001000dd3b0>] __do_IRQ+0x110/0x380                              
                                sp=e00000003c7a7be0 bsp=e00000003c7a10c8
 [<a00000010000ef40>] ia64_handle_irq+0xa0/0x140                        
                                sp=e00000003c7a7be0 bsp=e00000003c7a1090
 [<a00000010000b2a0>] ia64_leave_kernel+0x0/0x280                       
                                sp=e00000003c7a7be0 bsp=e00000003c7a1090
 [<a00000010004efb0>] smp_call_function+0x270/0x3a0                     
                                sp=e00000003c7a7db0 bsp=e00000003c7a1008
 [<a0000001000f3b10>] smp_call_function_all_cpus+0x90/0xe0              
                                sp=e00000003c7a7dd0 bsp=e00000003c7a0fd8
 [<a0000001000f7a90>] do_tune_cpucache+0x130/0x3e0                      
                                sp=e00000003c7a7dd0 bsp=e00000003c7a0f70
 [<a0000001000f7e10>] enable_cpucache+0xd0/0x120                        
                                sp=e00000003c7a7e20 bsp=e00000003c7a0f50
 [<a0000001000f3730>] kmem_cache_create+0xdf0/0xfa0                     
                                sp=e00000003c7a7e20 bsp=e00000003c7a0eb8
 [<a0000001009feee0>] as_init+0x40/0xe0                                 
                                sp=e00000003c7a7e30 bsp=e00000003c7a0e90
 [<a0000001009d50f0>] do_initcalls+0xb0/0x200                           
                                sp=e00000003c7a7e30 bsp=e00000003c7a0e28
 [<a0000001009d52b0>] do_basic_setup+0x70/0xa0                          
                                sp=e00000003c7a7e30 bsp=e00000003c7a0e10
 [<a0000001000093b0>] init+0xd0/0x380                                   
                                sp=e00000003c7a7e30 bsp=e00000003c7a0dd8
 [<a000000100012150>] kernel_thread_helper+0xd0/0x100                   
                                sp=e00000003c7a7e30 bsp=e00000003c7a0db0
 [<a000000100009120>] start_kernel_thread+0x20/0x40                     
                                sp=e00000003c7a7e30 bsp=e00000003c7a0db0
ce 0000:06:02.0                                                         
ACPI: Can't get handler for 0000:06:02.0


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
