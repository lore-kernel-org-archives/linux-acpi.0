From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 31 Jul 2002 14:48:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207311848.OAA02789@buzzword-bingo.mit.edu>
References: <20020731184124.316.qmail@scrye.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 31 Jul 2002 12:41:21 MDT."
             <20020731184124.316.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
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


> well, I did that, but then iasl gives me: 
> 
> iasl-linux-20020725/iasl -tc -bb -i dsdt.asl-new
[...]
> Is this the wrong format from acpidmp?

Woah, I think you made the same mistake I did -- the utility
you're using gives a hex dump rather than ASL.  Use this 
utility:

http://people.freebsd.org/~takawata/pacpidump.tar.gz 

> Are you using the acpi-swspend patch? I am using the
> patch-acpi-acpi20020726-swsusp11.gz patch.

Yes -- but rev. swsusp9 versus acpi-20020709.  I will upgrade
both.

> >> The DRI patch seems to work great on it as well, so it can chvt
> >> away from X, echo 4 > /proc/acpi/sleep and suspend, and comes back
> >> ok. Great work on that!

Cool -- I'll try it out once I get the resume issue resolved.


Sourav




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
