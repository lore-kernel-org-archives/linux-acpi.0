From: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Subject: Re: Latest ACPI + cpufreq on a Dell Inspiron 2650
Date: Tue, 03 Dec 2002 12:42:51 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <00de01c29aeb$0583c8f0$3746028e@bio.dfo.ca>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B95D@orsmsx107.jf.intel.com>
 <200212030136.30159.chris@chrishowells.co.uk>
 <002401c29acd$e1316880$3746028e@bio.dfo.ca>
 <200212031601.20634.chris@chrishowells.co.uk>
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

From: "Chris Howells" <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
>
> > > * Entering S1 halts the system clock so the time when leaving S1 is the
> > > same as when it entered S1
> >
> > As it should.  You have to reset the clock.
>
> Oh really? Hrm.... so presumably the correct solution would be to do a
> "hwclock --hctosys" on leaving S1? *Wonders how to make it do this
> automatically*

It should generate an event to /proc/acpi/event, and the easiest way to use that
is to use acpid.  check syslog for messages from acpid, which correspond to
unprocessed events.

iirc, sometimes you might only get an event on pushing the suspend button, in
which case you run a script that completes the suspend, then sleeps a couple of
seconds, then runs hwclock to reset the clock.

> I'm not going to have this machine much longer because after a length battle
> with them including starting legal proceedings (the memory was(is) faulty and
> g++ kept suffering from Internal Compiler errors) I'm getting a refund.
> Hopefully the new machine will work as well or better :)

better, one hopes!



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
