From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: 2.5.39 Insomniac, any first dbg?
Date: Mon, 30 Sep 2002 17:05:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033398342.7338.5.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <200209301541.47910.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200209301541.47910.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mon, 2002-09-30 um 14.41 schrieb P. Christeas:
> Hi, 
> I 've compiled 2.5.39 (since Sat.) and it is Insomniac (can't sleep). When I 
> 'echo [1|4] > /proc/acpi/sleep',  nothing gets logged and nothing happens.

I can confirm that, and I remember Pavel already did too.

> I also tried S2, the system re-booted (after hard lock).
> Do you have any first dbg comments? Where should I start debugging from?

Can you reproduce that? My notebook does not do anything on echoing 1 to
5 to /proc/acpi/sleep.

> Details:
> 2.5.39 on HP Xe3 GC
> kernel: uni-proc, APIC, IO-APIC (don't work, I think, but are compiled in).
> ACPI: 20020918, all enabled, also tried with 'debug statements' set. It 
> reports it can do S0,1,2,3,4,5 ..

I assume it is not system related but has been introduced when
everything got split out to sleep.c though I am not sure about that (I
planned some debugging for tonight)

> I echo to /proc/acpi/sleep. Nothing happens, nothing gets logged for 1,4.
> I looked into kernel/suspend.c and acpi/sleep.c . Which fn's can cause the 
> sleep procedure to fail w/o notices?


Not quite sure...I would start making sure that the kernel actually
notices that something has been echoed to sleep. There must be some
handling of sleep as a proc filesystem entry - maybe in sleep.c. Look
for it. I think starting there makes sense. If you find anything..let me
know...I would not have to do double work then.

-Knut

-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
