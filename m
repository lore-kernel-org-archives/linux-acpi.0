From: Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: Re: making progress with ACPI was: ACPI small patch update
Date: 29 Oct 2002 19:23:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1035915803.1442.82.camel@U414>
References: <E186Vl0-0005aM-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E186Vl0-0005aM-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

Behold, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> hath decreed:

> i find it fascinating that there are so many people on this list who
> want to see a bug tracking system, but don't feel able to keep a list
> of bugs themselves.  why is that?  expecting andy to set it up seems
> unreasonable.

I think the answer to this question is obvious. People who want a bug
tracking system are people who'd like to get involved with the project
either as a tester or more actively. They would assume there's no point
collecting bug reports the main developers never look at, probably don't
have the familiarity with the project to feel able to categorise bug
reports sanely and quite possibly have never set up or maintained a bug
tracking system. 

As far as I can see, there is already a perfectly functional bug
tracking system on sourceforge, which at worst and unmaintained will
keep a list of bugs in much the same way as this mailing list does. At
the moment there is a rather discrete note "Use the mailling list
instead" and its obviously not maintained in any shape or form. I'd
suggest changing that little label to "Make sure you include the kernel
version, acpi-patch version and hardware description in any bug reports"
and then at least the option is there for someone to step up to the task
of organising bug reports (which would be a lot more appealing than the
current "set up a bug-tracking system better than the sourceforge's and
maintain it").

This whole thread seems familiar... as I recall, the last time I brought
it up and the issue of some documentation I went away to try to write
some documentation for the /proc/acpi interface. As it turned out, I can
read what shows up in mine, I know what people on the mailling list have
said can be echoed to files to get things to happen, but since I have no
idea whether these are subject to change, which may change between
computers (eg. show whatever the manufacturer called something) it
seemed rather silly to contine, since such reverse engineering of the
interface could be done by anyone with equally qualitative results. I'd
hate to think everyone started submitting bug reports because Andrew's
latest code didn't behave like I said it would in my description of the
interface!

In my opinion, without up-to-date documentation (probably a spec as to
what happens in /proc/acpi) and a bug-tracking system, the acpi-project
demographic is going to stay pretty as "Andrew or one of the other 2-3
developers who contribute sizable slabs of code at a time", "niche
patches" (eg. what Ducrot Bruno has done with toshiba DSDTs),
"occasionally submits a patch which implimented something for them, but
couldn't be reused" or  "reads the list, occasionaly reports a problem".
What I think is needed, is for one of the "Andrew or one of the other
2-3 developers" to take a break for a day or two from coding to set
things up so the hurdle for getting involved isn't (or doesn't seem)
quite so high (hell, post a HOWTO-contribute-to-the-ACPI-project on the
project page listing what isn't being maintained would be a start).

Just my 2c, I'll go back to converting my friends over to GNU/linux 
again so no need to flame..

Huw



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
