From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Stall semantics
Date: Fri, 3 Oct 2003 13:23:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3DD1@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Here's what the MS interpreter does for Stall(n);

1) If n <=3D 255 (MAX_BYTE), perform the stall.
2) If n > 255, throw an error and abort the control method.

In this case, I suggest that we simply duplicate the MS behavior, it
seems like a good compromise and also provides ACPI CA with exact
compatibility.

Bob


-----Original Message-----
From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]=20
Sent: Wednesday, October 01, 2003 10:27 AM
To: Matthew Wilcox
Cc: Moore, Robert; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] [PATCH] Stall semantics

On Wed, 1 Oct 2003, Matthew Wilcox wrote:
> On Wed, Oct 01, 2003 at 09:59:49AM -0700, Nate Lawson wrote:
> > Let me quote that line again:
> > > Because of this, delays longer than 100 microseconds must use
Sleep
> > > instead of Stall.
> >
> > The current code is incorrect.  It uses Stall (i.e. a delay loop)
for
> > waits of up to 1000 us, not 100 us like the standard.  My patch
makes the
> > code match the standard.
> >
> > Your point is whether Sleep should automatically be called by OSPM
when
> > the AML specifies a Stall of more than a certain amount (let's stick
to
> > 100 us for this example).  I believe OSPM can and should
automatically
> > call Sleep when the time requested exceeds the maximum for Stall.
Look at
> > that line again.  The key word is "use".  If OSPM automatically
translates
> > the call, delays longer than 100 us will indeed _use_ Sleep instead
of
> > Stall.  This gives correct, standard behavior even when the AML
didn't
> > originally match the standard.
>
> Fundamentally, we're outside the specification and into nasal demon
> territory.  We can do whatever we like.  The question is: what to do
that
> will break the least number of machines.  Sleeping unexpectedly can
easily
> break code -- this is why you can't schedule while holding a spinlock,
> for example.  Of course, Stalling for too long is also a bad idea.

You're assuming the AML mistake is made both ways.  If it is uniformly
made one way, it's easy to work around correctly.

> I think the current ACPI behaviour is probably adequate -- accommodate
> incopetent BIOS writers up to a point, then sleep, and damn them
anyway.

It damns us OS vendors a different way in that we get unacceptably long
idle spin loops on some machines.  Spinning for 1000 us is not correct
any
way you interpret the standard.

If we can't reach agreement, it's better to leave things the same.  The
other part of my patch is still useful in reducing redundant code.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
