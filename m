From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Thu, 04 Mar 2004 13:00:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40471A4F.2090909@renninger.de>
References: <404459FD.1000406@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <404459FD.1000406-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Luca Capello wrote:

>
> gismo:/proc/acpi/processor/CPU1# cat power
> active state:            C47514253
> default state:           C26214683
> bus master activity:     00010000
> states:
>     C1:                  promotion[--] demotion[C23360] latency[000]
> usage[134972534]
>     C2:                  <not supported>
>     C3:                  <not supported>
>
> gismo:/proc/acpi/processor/CPU1# cat throttling
> Could not determine current throttling state.
> =====
>
> I already hacked my DSDT (attached in .dsl format), but the last tests 
> I made on
> 2.6.3 + ACPI 20040220 and 'ACPI DSDT in initrd' gave the same error 
> (attached
> 'dmesg' output).
>
> Possible solutions?
>
I had the same problem.
Your machine supports the C4 state.
Change the P_BLK  in your DSDT to 0x06

e.g.:
    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x07)
to:
    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x06)

or use the patch from Pavel, posted on the 28.02.2004, 17:10.

Unfortunately this won't enable the C4 state if you have one.
What do mainters say about supporting Cn processor states in the future?




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
