From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: [PATCH] Stall semantics
Date: Wed, 1 Oct 2003 09:59:49 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001093943.J85056@root.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Sep 2003, Moore, Robert wrote:
> I'm questioning whether it is appropriate to *ever* call sleep since
> this behavior seems to violate the spec.

I believe it is correct, logic is below.

> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Tuesday, September 30, 2003 2:45 PM
> To: Moore, Robert
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] [PATCH] Stall semantics
>
> On Tue, 30 Sep 2003, Moore, Robert wrote:
> > The ACPI spec says this:
> >
> > 16.2.3.4.1.15  Stall (Stall for a Short Time)
>
> Yes, this is what I was referring to.
>
> > StallTerm	:= Stall(
> > 	MicroSecs	//TermArg=>Integer
> > )
> > The Stall term is used to implement short-term timing requirements.
> > Execution is delayed for at least the required number of microseconds.
> > The implementation of Stall is OS-specific, but must not relinquish
> > control of the processor. Because of this, delays longer than 100
> > microseconds must use Sleep instead of Stall.
> -----
> >
> > This seems to imply that sleep() cannot be used to implement long
> > "stalls" because it can relinquish the cpu.
>
> Please read the patch and the last sentence you quoted from the spec.
> Your code already calls Sleep instead of Stall for values > 1000 us.  I
> simply made it stick to the spec of > 100 us.

Let me quote that line again:
> Because of this, delays longer than 100 microseconds must use Sleep
> instead of Stall.

The current code is incorrect.  It uses Stall (i.e. a delay loop) for
waits of up to 1000 us, not 100 us like the standard.  My patch makes the
code match the standard.

Your point is whether Sleep should automatically be called by OSPM when
the AML specifies a Stall of more than a certain amount (let's stick to
100 us for this example).  I believe OSPM can and should automatically
call Sleep when the time requested exceeds the maximum for Stall.  Look at
that line again.  The key word is "use".  If OSPM automatically translates
the call, delays longer than 100 us will indeed _use_ Sleep instead of
Stall.  This gives correct, standard behavior even when the AML didn't
originally match the standard.

The fact of the matter is, there is plenty of AML out there which has this
problem.  And, the correct, intended behavior can still be produced when
parsing such AML without violating the spec.  This is the perfect example
of DWIM ("Do What I Mean").  The AML author intended to call Sleep for
such long stalls but made a small mistake.  In fact, the Intel author of
this section of ACPICA made the same mistake of not knowing the line at
which a Stall becomes a Sleep (i.e. 100 vs. 1000 us).

This is a very small change and not worth arguing about.  Let's move
forward with fixing more pressing problems like the "Utallocate 0 length"
errors that keep popping up.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
