From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: Re: Processor C states and USB problem
Date: Mon, 5 Jan 2004 10:11:47 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401051009260.5820@pcd403z.vsb.cz>
References: <E1AdQIo-0005nI-00@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1AdQIo-0005nI-00-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I did ask about this problem in usb-devel-forum.

You can see answer:
http://sourceforge.net/mailarchive/message.php?msg_id=6249537

usb host use poll mode to get data from usb peripherals, and result is
continuous busmaster activity.

poli


On Mon, 5 Jan 2004 mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org wrote:

> Recently I had problems with my network card and ACPI (see earlier posts for
> the problem and solution) so I thought I'd take a closer look at ACPI on
> this notebook (Acer Travelmate 800).
>
> Looking at the proc entries for the processor I saw the following.
>
> active state:            C3
> default state:           C1
> bus master activity:     80070020
> states:
>    C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>    C2:                  promotion[C3] demotion[C1]
> latency[001]usage[01077887]
>   *C3:                  promotion[--] demotion[C2] latency[085]
> usage[00083507]
>
> This looked pretty normal to me, apart from the fact that the processor was
> spending a lot of time in C3 although the notebook was idle.
>
> Now I plugged in my USB mouse.
>
> cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff <---- USB is active
> states:
>    C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>   *C2:                  promotion[C3] demotion[C1]
> latency[001]usage[00871647]
>    C3:                  promotion[--] demotion[C2] latency[085]
> usage[00077386]
>
> The processor never left the C2 state.
> After unplugging the mouse "bus master activity" showed normal values again.
>
> Now for my two questions:
>
> 1.) Is it normal for the notebook to spend so much time in C3, even if it is
> idle?
>
> 2.) Why is an USB device screwing up the bus master activity, resulting in
> the processor never leaving C2?
>
>
> /Michael
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
