From: "Andreas Leppert" <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: Re: RE: throttling is not changing
Date: Fri, 17 Sep 2004 23:41:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1570523035@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ronald.Hitz-1NtEGJHV5g0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Roland,

if you mean the howto on http://www.cpqlinux.com/acpi-howto.html, then i have to say "no". 

i have got a reply from robert moore. he said that the if statements (the errors) cannot be in the definition block in my dsdt. he advised me to create a _INI method in the _SB scope. i did this and load the custom dsdt with the acpi-patch-kernel option, but that didn't the trick.

anyway, thank you
Andi Leppert

Ronald.Hitz-1NtEGJHV5g0@public.gmane.org schrieb am 17.09.04 22:05:51:
> 
> Hi Andi,
> 
> did You the failure in the acpi-howto ?
> 
> Maybe there is a hint to fix it.
> 
> regards
> 
> Ronald Hitz
> 
____________________________________________________
Aufnehmen, abschicken, nah sein - So einfach ist 
WEB.DE Video-Mail: http://freemail.web.de/?mc=021200



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
