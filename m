From: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Mon, 16 Dec 2002 06:34:10 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021216143410.21977.qmail@web14502.mail.yahoo.com>
References: <20021215205944.GA6330@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021215205944.GA6330-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Herbert Nachtnebel' <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Therien, Guy" <guy.therien-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--- Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Hi!
> > What is really being proposed here is for Linux
> ACPI to be bug-for-bug
> > compatible with Microsoft.  This is impossible to
> do deterministically
> > because the MS interpreter is closed source.  The
> only standard that we have
> > that we can code to is the ACPI specification, and
> this has to be the last
> > word on the matter.
> 
> Okay, but we can try. We can for example ignore
> '*PNP101' and
> understand it as 'PNP101', with printk("Star is not
> valid character in
> device name"), which is way more helpufull than
> /proc/battery does not
> exist.
> 
> I believe CONFIG_ACPI_RELAXED_AML is good idea.
> 								Pavel

The opinions on this are going to break down along the
lines of who has working AML, and who doesn't, with
the tie-breaker going to the distro that wants to
have as many satisfied "customers" as possible.  Right
now, that distro is XP :-(

Anyway, I did a tightened up CONFIG_RELAXED_AML_PATCH
that restricts the slopiness along the lines that Alan
suggested, and also outputs a one-time warning for
any region access violation.

However, a more general implementation would provide
either a global nagged_already bit, or better yet
a per-object nagged_already bit. Or for the most
pedantic, per-object and per-violation-type
nagged_already bits.

Its nasty ugliness, no doubt, but I think that while
strict conformance to standards is a lofty goal, a
loftier goal is for mere mortals to be able to
install Linux on the most popular laptops.

BTW, Best Buy had the Toshiba Satellite 1115-S103 on
sale for only $500 USD yesterday (after $600 in
rebates and markdowns!).  The new bar has been set,
and these
sub-$1000 laptops with buggy AML are going to continue
to profilerate.

If we could agree to add the mechanism, then people
could contribute additional workarounds. It would
still be a controllable feature, turned on only if
desired.

-Rick
rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
