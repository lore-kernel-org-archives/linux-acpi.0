From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 15:48:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827144826.GC32423@clara.net>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020827091844.7af7a982.jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Jamin W. Collins" <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jamin W. Collins [jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org] wrote:
> Has anyone else tried using ACPI with the C1VN or similiar laptops?  I've
> recently recompiled my kernel, removing APM and enabling ACPI.  Most
> things seem to work fine (battery status and events).  However, when I
> start esd or asd to mix audio streams my processor utilization immediately
> jumps to ~50% and stays there.  The utilization drops to 15-30% if I set
> longrun to maximum rather than variable.  I've verified the utilization
> with both "top" and "gkrellm".  However, while top shows that my CPU is
> not completely idle, it does not list what is using the CPU.  I've tried
> sorting by CPU utilization, but there are still large gaps. As shown by
> the following:

If you stop acpid (if you run it) and cat /proc/acpi/events, do you get
a constant stream of events during this high system load?

I get a constant stream of Processor 0x80 events if I pass the Passive
cooling point on my laptop (Compaq 2701EA) running 2.4.19-020815.
This causes the processor to run hotter and therefore continue to stream
these events.

I need to find what it is which is causing the problem.  I had a look at
processor and thermal, and when the passive point is reached it does
send an acpi event, but if I comment that out, all it does is stop it
going to acpi/events, it doesn't stop whatever is spinning and causing
the high system load and noone on the list has been able to give me
any tips on where to look.

I don't remember the problem occurring when I was using 2.4.18-020709
kernel.  Perhaps Passive cooling "handling" is new since then?


Faye

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

Friends may come and go, but enemies accumulate.
		-- Thomas Jones


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
