From: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Subject: Re: Query regarding the linux ACPI
Date: Tue, 17 Jun 2003 16:03:09 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <09c601c334bb$d91226c0$2a0806c0@wiproxcoio3398>
References: <082401c333fc$89a08740$2a0806c0@wiproxcoio3398> <012f01c333fe$c23a8270$3746028e@bio.dfo.ca>
Reply-To: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
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
To: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

That means this option can be programmed in the BIOS and we can have it as
option in the BIOS.
Am I right ?

-Siva

---- Original Message -----
From: "Derek Broughton" <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
To: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Monday, June 16, 2003 5:29 PM
Subject: Re: [ACPI] Query regarding the linux ACPI


> From: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
>
> > When I was reading the ACPI specification, I found the following
information,
> > The ACPI specification also allows that if the user presses the power
button
> for more than four seconds
> > while the system is in the working state, a hardware event is generated
and
> the system will transition to the
> > soft-off state. This hardware event is called a power button override.
In
> reaction to the power button
> > override event, the hardware clears the power button status bit
(PWRBTN_STS).
> >
> > I would like to know, whether this Power button override feature is
available
> in the Linux ACPI
> > implementation. If it is implemented, where can I find them  and how to
use
> it?
>
> It's a "hardware" event.  Surely ACPI isn't strictly involved.  I read
this as
> meaning that ACPI mustn't interfere with such function.  Certainly my Dell
> Inspiron will shut off when I hold the power button down for 4 seconds
without
> generating an ACPI event.
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by: eBay
> Great deals on office technology -- on eBay now! Click here:
> http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
