From: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>
Subject: Re: does cpu_idle() halt CPU?
Date: Fri, 28 Mar 2003 14:37:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030328143729.C10287@gateway.junsun.net>
References: <F760B14C9561B941B89469F59BA3A84725A23A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A23A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Fri, Mar 28, 2003 at 02:28:41PM -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 28, 2003 at 02:28:41PM -0800, Grover, Andrew wrote:
> 
> What power states does your CPU support?
> - What does a cat of /proc/acpi/processor/*/power say?

[root@localhost root]# cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000690]   *C2:                  promotion[C3] demotion[C1] latency[010] usage[00196669]    C3:                  promotion[--] demotion[C2] latency[130] usage[00000000]

> - What does the ACPI: Processor line say in your dmesg say?
>
ACPI: RSDP (v000 FUJ                        ) @ 0x000f6200
ACPI: RSDT (v001 FUJ    CLOVE    00263.00000) @ 0x1f6ea3fd
ACPI: FADT (v001 FUJ    CLOVE    00263.00000) @ 0x1f6efb8c
ACPI: DSDT (v001 FUJ    CLOVE    00263.00000) @ 0x00000000
ACPI: BIOS passes blacklist
...
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) III CPU - M  1200MHz stepping 04
Enabling fast FPU save and restore... done.
...
 
> What kind of laptop do you have? Does it support SpeedStep, PowerNow, or
> the like?

My laptop is Fujitsu S6110.  CPU supports speedstep.

> Do you have any USB devices attached?
>

Not in this particular run.

Jun 


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
