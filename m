From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: High pitch noise produced when ACPI processor module loaded
Date: Mon, 6 Oct 2003 19:59:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031006175941.GN311@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84702C9300A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C9300A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> > Pavel Machek
> > > > This unfortunately seems fairly normal; at least all four 
> > notebooks I
> > > > had for testing produced some kind of cpu-related noise.
> > > 
> > > It's a *feature*.  I've implemented a Cx driver for FreeBSD and it's
> > > useful to be able to tell if the code really is entering 
> > the desired state
> > > by holding the laptop up to my ear.  I can differentiate 
> > all the Cx states
> > > but not in the Px states.  :)
> > 
> > ;-))))))))))))))
> > 
> > Well, if you have to *hold it up to your ear*, then yes, its a
> > feature. Unfortunately, I can hear it while working normally :-(.
> 
> Apparently it is a hardware problem. Says someone who knows:
> 
> "Well, it's not normal, but it means they used cheap capacitors. This is
> known as the acoustic noise issue. It's related to PCB vibration as a
> result of the piezo electric effect on the caps. What is the timer tick

Well, that means that thinkpad 560X, toshiba 4030cdt, hp omnibook xe3
and arima notebook (at least) have cheap capacitors. And it happened
in 2.2 days with apm, too, so I do not think it is too timer-tick
related.

> Since Linux (2.6 anyways) uses a 1ms timer tick, this will be seen more
> frequently on Linux. If it's really a bother, using a longer tick might
> be something to try...

Its not *that* bad, but I'd not call it feature, either.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
