From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Lid switch not waking machine
Date: Mon, 07 Jul 2003 09:13:23 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <007301c34481$29864080$3746028e@bio.dfo.ca>
References: <20030707011638.GA19894@srcf.ucam.org>
 <20030707022614.GA21195@srcf.ucam.org>
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

From: "Matthew Garrett" <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>

> On Mon, Jul 07, 2003 at 02:16:39AM +0100, Matthew Garrett wrote:
>
> > So, should this function be being called for my lid switch, and if so
> > how? Or am I barking up the wrong tree entirely? Windows resumes happily
> > if the switch is released, so it's presumably capable of generating a
> > wakeup event.
>
> The plot thickens. If I suspend with the lid switch and then release it,
> I have to wake the system with the power button. The system resumes, but

This is normal.  Every laptop I've used (even in Windows) expects to be woken
from sleep states with the power button - if your laptop had a dedicated sleep
button, you might use that instead, but the lid switch is never, ime, used for
wakeup.

> no more ACPI events are generated. If I suspend with the sleep button, I

This, however, seems wrong.  What you should get when you wake with the power
button is a power button event immediately followed by a lid switch event - and
then any other events.

derek



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
