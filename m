From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Sun, 18 Jan 2004 03:58:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040118025845.GB25416@poupinou.org>
References: <1074382993.674.24.camel@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1074382993.674.24.camel-GKM3wtwTCu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: christian graf <chr.graf-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 18, 2004 at 12:43:13AM +0100, christian graf wrote:
> Hi,
> 
> reading the /usr/src/linux-2.6.1/drivers/acpi/processor.c
> i thought the kernel should set the state dynamically, based on the
> load. Maybe it is possible to set the processor-state of my centrino
> manually. Can please anybody tell me how to get it right?
> 
> The reason I'm asking is, that once I do load the processor.ko module,
> my Centrino switches immediately into C2-state. It never switches back
> to C1 state, even under heavy load like compiling the kernel.
> 
> I think the kernel should switch back from C2 to C1 state from alone????
> 
> Please ask me whatever you need to help me swtiching back into C1 state.
> 
> christian
> 
> 
> 
> cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>    *C2:                  promotion[C3] demotion[C1] latency[001]
> usage[00905291]
>     C3:                  promotion[--] demotion[C2] latency[185]
> usage[00000000]
> 

The latency for C2 is too low (and therefore it is a BIOS trouble).
Anyway, C2 is better than C1, so you want C2 ;)

Note that there is some missing code in the processor.c stuff, which may
give you more appropriate latency, and a C4 state.  The code for is under
developpement.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
