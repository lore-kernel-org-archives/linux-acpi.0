From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Kernel 2.5 configuration, was: compaq evo 800v dsdt
Date: Fri, 14 Feb 2003 10:36:02 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030214103602.GC8318@clara.net>
References: <F760B14C9561B941B89469F59BA3A847138050@orsmsx401.jf.intel.com> <1045159298.2048.22.camel@calvin.hjblocal.nl> <20030214073129.GX25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030214073129.GX25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Hilbert Barelds <list-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Ducrot Bruno [ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] wrote:
> The P4-M is supported by the speedstep "legacy" driver in cpufreq.

I think this is a big problem at the moment in the kernel 2.5 power
management configuration.  There are too many ways of doing the same
thing, and things which look as though they are new in 2.5 (cpufreq) say
that they are 2.4 and 'legacy'.  And SWSUSP, should it be on or off if you
want to try S3/4 BIOS?

What are the options which should be turned on to have the best
supported configuration for all ACPI features including S3/S4 sleep.

Which kernel and patches should I apply to have the best starting point
for helping debug?

Also, I've seen conflicting reports about whether you should use
/proc/acpi/sleep or the swsusp interface in order to trigger sleep
states.

I've compiled up a 2.5.60 kernel but I'm not sure I have the correct set
of options enabled.

Also, the kernel PCMCIA (yenta) drivers don't work for me on a Sony Vaio
GRX516MD.  I've been using pcmcia-cs drivers under 2.4 but I believe I
have to use the kernel drivers for 2.5 and they fail to allocate an IRQ
because of lack of resources for my wireless card when it is plugged.

How can I tell whether the failure to allocate an IRQ is a PCMCIA issue
or an ACPI issue?  Under 2.4 everything seems to want to use IRQ 9 but
it only seems to be a problem for USB which complains that it's seeing
IRQs for non USB events and doesn't actually function properly.

I've put as much information as I can think of on my home page at
http://dude.noc.clara.net/~faye/ if any other information is necessary,
I'll happily provide it.

Kernel 2.4 is working pretty well at the moment, but I really want to
help to get suspend functional.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Everything can be filed under "miscellaneous".


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
