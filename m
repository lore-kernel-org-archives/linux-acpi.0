From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: constant processor 0x80 events
Date: Wed, 1 Jan 2003 22:55:05 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000301c2b19d$63f52ff0$2d2202d3@sayonara>
References: <000101c2b191$93b74130$2d2202d3@sayonara>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000101c2b191$93b74130$2d2202d3-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > When the machine becomes under load for a while, or is hot already 
> > and the processor is under load, then the CPU time in system becomes

> > very high, /proc/acpi/event is constantly
> > printing: processor CPU0 00000080 00000000 processor CPU0
> > 00000080 00000000 processor CPU0 00000080 00000000
> > 
> Your system board triggers GPE upon some hardware condition
> (most likely thermal in your case) and GPE handler for that 
> event (run by OS) issues Notify 0x80 on processor object. 
> This eventually causes OS to reevaluate your _PPC object to 
> flip the highest performance state (P-State) of your 
> processor and update the supported P-State table.
> 
> I suspect that, on your machine, first current temperature
> crosses the trip point (not for passive/active cooling but 
> for P-State update), the newly selected lower P-State cools 
> down the box for a while, but sooner or later it starts to 
> heat again, ending up under the "yo-yo" situation. This might 
> bring about high CPU demand for repeated event handling.  
> 

A few additions:
1) Can you mask GPE pin 0 at hardware level (clearing enable bit) and/or
comment out the following 4 lines (228 - 231) from your DSDT and see if
it makes a difference?

   226      Scope (_GPE)
   227      {
   228          //Method (_L00, 0, NotSerialized)
   229          //{
   230          //    Notify (\_PR.CPU0, 0x80)
   231          //}
   232

Note: 
* OS may reenable GPE pin even if you sucessfully disable it.
* Removing the GPE handler could cause unhandled interrupt storm,
although I assume OS ISR properly handles the interrupt at hardware
level before passing the control to the AML interpreter to run GPE
handler... Anyway I'll look into code some time soon.

2) Do you, by any chance, run Windows on your machine and also hit this
problem?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
