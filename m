From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: AE_TIME on Operations in EC ( Embedded Controller ec.c
 )
Date: Mon, 15 Sep 2003 13:54:51 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030915135247.H6780@root.org>
References: <3F657BDB.9080805@t-systems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F657BDB.9080805-kyawv7ubMNaakBO8gow8eQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dimitri Rebrikov <dimitri.rebrikov-kyawv7ubMNaakBO8gow8eQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 15 Sep 2003, Dimitri Rebrikov wrote:
> BTW. I had no problem with ACPI before (2.4.18+ACPI and 2.4.20+ACPI)
>
> The corresponding error message in log was:
>
> Sep  5 12:49:57 mitnb kernel: evregion-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
> Sep  5 12:49:57 mitnb kernel:  psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node cee7cdc8), AE_TIME
>
> After some testing i located (i belief) the issue:
> The values of ACPI_EC_UDELAY_COUNT and/or  ACPI_EC_UDELAY are too small
> for my Hardware.
>
> Here is the comparision between 2.4.20+ACPI and 2.4.22:
>
> ./linux-2.4.20/drivers/acpi/ec.c:#define ACPI_EC_UDELAY		1000	/* Poll @ 100us increments */
> ./linux-2.4.20/drivers/acpi/ec.c:#define ACPI_EC_UDELAY_COUNT	10000	/* Wait 10ms max. during EC ops */
>
> ./linux-2.4.22/drivers/acpi/ec.c:#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
> ./linux-2.4.22/drivers/acpi/ec.c:#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
>
> This means that the wait time for a EC operation in 2.4.22 was reduced with factor 100.
>
> After i increase the value of ACPI_EC_UDELAY_COUNT to 10000
> my problems gone. Now i can use the whole functionality of ACPI.

I submitted that change in that the comment didn't match the code.  I've
found in FreeBSD that even 50 ms isn't enough sometimes so I suppose your
experience concurs with this.  You can probably bump it to 100 ms, just
make sure the comment matches the code.

BTW, there is no reason repsonses from the EC should be that slow.  I have
a feeling global lock contention is the real underlying problem.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
