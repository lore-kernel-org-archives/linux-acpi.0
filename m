From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Need for an ACPI webpage
Date: Fri, 18 Oct 2002 17:25:42 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210181725.42975.p_christ@hol.gr>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF31@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DF31-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Look at blacklist.c.
>
> Should we add these to that table?
 Perhaps

>
> The code is the only thing that is guaranteed to be up to date. I think it
> would be nice to have a more readable version of that list online, but it
> will quickly become outdated unless someone actively maintains it (you?) or
> it is auto-generated from the source.
>
> Regards -- Andy

The code itself may not be the best place for a newbie to look at. What about 
things that are already covered by an old ver or things that have been proven 
to fail? A second reason is that we could not practically have many patch 
DSDT's in our kernel (or can we?).
I wouldn't mind being one of the mainteners of the list, but I don't have much 
webspace for that. The best way could be to use this list (acpi-devel) to 
post requests like 'could you add the line "x-brand 2.5.x blah blah" to the 
table?' so that the maintener won't do much himself. Testing can not be done 
by one person, anyway.
One more way that the table won't get outdated is if we put it on an 
'official' server (like yours). This way readers will harass us about wrong 
entries.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
