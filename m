From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: RE: redhat comment about intel not taking patches?
Date: Wed, 12 Feb 2003 23:58:13 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <34814.192.168.10.204.1045123093.squirrel@benham.net>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E3DB-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: john.cagle-VXdhtT5mjnY@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'll send this one reply to the list as a sort of apology to HP (Compaq). 
My last two laptops where HP, my current laptop is Compaq and the next
laptop I've been thinking of buying is Compaq.  HP/Compaq is my laptop of
choice and I recommend them to people who ask my opinion as well as
purchase them for my users where I work.
The point of the email Mr. Cagle replied to was not so much to be about
Compaq's DSDTs as it was about whether or not ACPI would be feasable in
mainstream distros as standard while it still had the "bios blacklisted"
with no attempts to work around them in the code.  I don't have figures of
how many systems are affected but as Linux distros try to go mainstream,
they're going to have to push for the broadest compatability group and "go
complain to your bios mfg" isn't going to be a successful business model.
I certainly don't want to start any unpleasantness so I'm more than
willing to discuss the rest of my comments with HP off-list.  HP/Compaq
makes great laptops and I don't want it to appear otherwise.
Darren
ISS-Houston said:
> Can you be more specific in your comments regarding Compaq hardware?
> We test our ProLiant servers with Linux and ACPI, and our BIOS is
> designed for many different operating systems, including Linux, Unix
> and NetWare. On the other hand, it is unreasonable to expect that our
> laptop and desktop divisions test with Linux ACPI for two big reasons:
> first, the Linux OS has a very small share of those markets, and
> second, Red Hat's releases don't even have ACPI support.
>
> Thanks,
> John
> --------------------------------
> John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> Principal Member Technical Staff
>   Industry Standard Servers
>    Hewlett-Packard Company
>    http://www.hp.com/linux
>       jcagle-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>
>> -----Original Message-----
>> From: Darren Benham [mailto:dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org]
>> Sent: Wednesday, February 12, 2003 8:55 PM
>> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> Subject: RE: [ACPI] redhat comment about intel not taking patches?
>>
>>
>> Is ACPI going to be able to go mainstream in any of the major
>> releases w/o making some effort to work in non-standard BIOS
>> (read, the BIOSes written directly for Windows)?  Is it ever
>> likely that pressure would work against those Bios
>> manufacturers that dont' follow spec?  I mean, Compaq is on
>> the list of partners for ACPI and their DSDT's are crap, with
>> asterisks in names and functions returning values that
>> shouldn't, etc. Grover, Andrew said:
>> >> From: Kevin Fenzi [mailto:kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org]
>> >> RedHat is playing with enabling ACPI in their next
>> release. (At least
>> >> in the beta for the next release: phoebe).
>> >>
>> >> Noticed this changelog comment in the phoebe kernel:
>> >>
>> >> * Thu Nov 07 2002 Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> >> - - remove ACPI again because Intel is unwilling to take patches
>> >>
>> >> What patches are they talking about?
>> >>
>> >> Is there any way we could fix up the communication
>> breakdown between
>> >> RedHat/Intel?
>> >>
>> >> It would be great if ACPI would work out of the box on my
>> laptop with
>> >> a RedHat kernel. At a minimum I guess it would require acpi to be
>> >> able to detect the compaq *PNP stuff and remove the * so the table
>> >> works.
>> >
>> > I have been in contact with a number of distributions concerning
>> > inclusion of ACPI support. I think the new licensing and
>> some recent
>> > source improvements helped a lot to make people feel better about
>> > ACPI, but there still are a number of critical bugs that
>> are affecting
>> > a significant percentage of systems. These need to be fixed. These
>> > have to do with *any* ACPI-related oopses, failure to boot
>> using ACPI,
>> > and failure to shutdown cleanly.
>> >
>> > ACPI is not going to be in the next RH release but we are really
>> > pushing to get it in subsequent releases, but we need to fix those
>> > critical bugs.
>> >
>> > Regards -- Andy
>> >
>> >
>>
>>
>> --
>> Darren


-- 
Darren




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
