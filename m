From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: constant processor 0x80 events
Date: Wed, 1 Jan 2003 21:30:25 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000101c2b191$93b74130$2d2202d3@sayonara>
References: <20021231211259.GA28810@clara.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021231211259.GA28810-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Faye Pearson' <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> When the machine becomes under load for a while, or is hot 
> already and the processor is under load, then the CPU time in 
> system becomes very high, /proc/acpi/event is constantly 
> printing: processor CPU0 00000080 00000000 processor CPU0 
> 00000080 00000000 processor CPU0 00000080 00000000
> 
Your system board triggers GPE upon some hardware condition (most likely
thermal in your case) and GPE handler for that event (run by OS) issues
Notify 0x80 on processor object. This eventually causes OS to reevaluate
your _PPC object to flip the highest performance state (P-State) of your
processor and update the supported P-State table.

I suspect that, on your machine, first current temperature crosses the
trip point (not for passive/active cooling but for P-State update), the
newly selected lower P-State cools down the box for a while, but sooner
or later it starts to heat again, ending up under the "yo-yo" situation.
This might bring about high CPU demand for repeated event handling.  

 
> I added this CHTR call (it wasn't being called before) and 
> that seems to stave off the problem for a while.. while 
> programs are running, there isn't a steady rise in 
> temperature, the temperature is seemingly all over the place. 
>  It will get up to 82 and then suddenly drop to 59. Even when 
> the load is going mad now, the fan is only on its high, not 
> critical level.
> 
It looks to me like your CHTR ("CH"ange "TR"ip point?) method adjusts
(enable/disable) trip point for P-State update depending on the passed
Arg0 and the caller of this CHTR Method is expected to pass current
temperature. If so, adding a call to CHTR in _TMP could make sense to
some extent. It dynamically changes trip point for P-State update and
somehow keeps box from overheating, resulting in the cooler and quiet
environment. But we can't be sure unless we have input from BIOS writer.


BTW, your BIOS seemingly doesn't support active cooling, that possibly
means the control of FAN is done by hardware modules and not exposed to
OS. Which make/model is your machine?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
