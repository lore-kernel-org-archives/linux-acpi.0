From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 31 Jul 2002 14:11:09 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207311811.OAA25369@buzzword-bingo.mit.edu>
References: <200207311758.NAA21154@fort-point-station.mit.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 31 Jul 2002 10:57:01."
             <200207311758.NAA21154-Cs4HVWLvPxMX+BO+eGb0EyTLNgK6kQ+zN7jzCyCsa88@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Reading the back archives, it sounds like some folks are having luck
> cleaning up the DSDT for this laptop and getting battery, etc...
> 
> Does anyone have a working (or at least more than the default) DSDT
> they could send me?

I don't have my laptop with me, but I just did the following text
substitutions (using sed) on the ASL DSDT:

"*PNP" -> "PNP" (per Christoph)
"C11C" -> "BAT1"
"C11B" -> "BAT2"
"C11A" -> "ACAD" (I'm not sure about this one -- 
                  check your /proc/acpi/ac_adapter dir first)

> Software suspend seems to work well... 

It was working well until I fixed my DSDT!

> The DRI patch seems to work great on it as well, so it can chvt away
> from X, echo 4 > /proc/acpi/sleep and suspend, and comes back
> ok. Great work on that!

Interesting that you have a /proc/acpi/sleep entry; I don't.  I've
been using "echo -n '1 0 0' > /proc/sys/kernel/swsusp".  It just
occurs to me that I should turn on the debugging bits and see
if I can understand what's wrong ...

> With the default acpi-20020726 I get temp readings, but it says ac is
> always on, and battery doesn't give any info at all. 

This should be repaired once you tweak the DSDT.

Please report back how it goes -- I'm using the 20020709 series of
patches on kernel 2.4.18, so if everything works out for you I
might upgrade to 20020726.


Sourav


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
