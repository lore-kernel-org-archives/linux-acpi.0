From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Query regarding the linux ACPI
Date: Mon, 16 Jun 2003 08:59:36 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <012f01c333fe$c23a8270$3746028e@bio.dfo.ca>
References: <082401c333fc$89a08740$2a0806c0@wiproxcoio3398>
Mime-Version: 1.0
Content-Type: text/plain;	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>

> When I was reading the ACPI specification, I found the following information,
> The ACPI specification also allows that if the user presses the power button
for more than four seconds
> while the system is in the working state, a hardware event is generated and
the system will transition to the
> soft-off state. This hardware event is called a power button override. In
reaction to the power button
> override event, the hardware clears the power button status bit (PWRBTN_STS).
>
> I would like to know, whether this Power button override feature is available
in the Linux ACPI
> implementation. If it is implemented, where can I find them  and how to use
it?

It's a "hardware" event.  Surely ACPI isn't strictly involved.  I read this as
meaning that ACPI mustn't interfere with such function.  Certainly my Dell
Inspiron will shut off when I hold the power button down for 4 seconds without
generating an ACPI event.



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
