From: Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>
Subject: Re: DSDT Change (Compaq Presario 2100)
Date: Sat, 29 May 2004 13:53:38 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c9am7j$nng$1@sea.gmane.org>
References: <200405280621.29874.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405280621.29874.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> As previously mentioned, my Compaq as well as many other HP model notebooks 
> slow down considerably when running on battery. Short off "ACPI=off" there 
> seemed to be no workaround.

My HP nx9005 is one of them. It runs terribly slow when on battery, it 
is unusable really.

> Well, tonight, while recompiling the DSDT a few times to remove warnings and 
> errors, I stumbled across this (in method SMSL
> 
> If (0x01)
> {
> 	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
> 	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
> 	Store (TRDC, Debug)
> 	Store (0x01, TREN)
> }
> 

The DSDT for my laptop has the exact same code.

> In any case, I changed "If (0x01)" to "If (0x00)" and voila, I am typing this 
> email from KDE with the power cord unplugged - no slowdown at all.

I have verified that this works for my machine also.

Am I correct in assuming that TREN is "Throttle Enable"(boolean value) 
and TRDC is "Throttle Duty-cycle"? What other TRDC values might make 
sense other than 0x0 ?


Erik Meitner
emeitner.f2o.org/nx9005




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
