From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches?
Date: Wed, 12 Feb 2003 18:55:24 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32786.192.168.10.204.1045104924.squirrel@benham.net>
References: <F760B14C9561B941B89469F59BA3A84725A175@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A175-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
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

Is ACPI going to be able to go mainstream in any of the major releases w/o
making some effort to work in non-standard BIOS (read, the BIOSes written
directly for Windows)?  Is it ever likely that pressure would work against
those Bios manufacturers that dont' follow spec?  I mean, Compaq is on the
list of partners for ACPI and their DSDT's are crap, with asterisks in
names and functions returning values that shouldn't, etc.
Grover, Andrew said:
>> From: Kevin Fenzi [mailto:kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
>> RedHat is playing with enabling ACPI in their next release. (At least
>> in the beta for the next release: phoebe).
>>
>> Noticed this changelog comment in the phoebe kernel:
>>
>> * Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> - - remove ACPI again because Intel is unwilling to take patches
>>
>> What patches are they talking about?
>>
>> Is there any way we could fix up the communication breakdown between
>> RedHat/Intel?
>>
>> It would be great if ACPI would work out of the box on my laptop with
>> a RedHat kernel. At a minimum I guess it would require acpi to be able
>> to detect the compaq *PNP stuff and remove the * so the table works.
>
> I have been in contact with a number of distributions concerning
> inclusion of ACPI support. I think the new licensing and some recent
> source improvements helped a lot to make people feel better about ACPI,
> but there still are a number of critical bugs that are affecting a
> significant percentage of systems. These need to be fixed. These have
> to do with *any* ACPI-related oopses, failure to boot using ACPI, and
> failure to shutdown cleanly.
>
> ACPI is not going to be in the next RH release but we are really
> pushing to get it in subsequent releases, but we need to fix those
> critical bugs.
>
> Regards -- Andy
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-- 
Darren




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
