From: "Dax Kelson" <dax-tjn3EnM4d99Wk0Htik3J/w@public.gmane.org>
Subject: RE: ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
Date: Mon, 29 Mar 2004 16:46:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <044001c415a4$f2224ad0$d100000a@sbs2003.local>
References: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C78-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Administrator-fARf8FLM0JdLN7wammbJVlpr/1R2p/CL@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-01-05 at 18:03, Yu, Luming wrote:
> >Subject: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
> >
> >Found at boot: 
> >ACPI: Battery Slot [BAT0] (battery present)
> >ACPI: Battery Slot [BAT1] (battery present)
> >But no run-time information:
> 
> Some DELL battery issues in recent kernel are solved by
> patch filed at http://bugzilla.kernel.org/show_bug.cgi?id=1766 .
> 
> Is it worthy to have it a try?

Seems to work ... is it normal to have the "unknown" values below when
plugged in?

$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      66000 mWh
present voltage:         16501 mV

$ cat /proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         65120 mWh
last full capacity:      54980 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            LIP8120DL
serial number:           5122
battery type:            LION
OEM info:                Sony C

When unplugged:

$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            2743 mW
remaining capacity:      52340 mWh
present voltage:         16526 mV


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
