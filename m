From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [PATCH] Stall semantics
Date: Wed, 1 Oct 2003 12:45:32 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001124334.X85655@root.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DAF@orsmsx405.jf.intel.com>
 <20031001093943.J85056@root.org> <20031001171657.GW24824@parcelfarce.linux.theplanet.co.uk>
 <20031001101854.J85056@root.org> <20031001185524.GX24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031001185524.GX24824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 1 Oct 2003, Matthew Wilcox wrote:
> > > I think the current ACPI behaviour is probably adequate -- accommodate
> > > incopetent BIOS writers up to a point, then sleep, and damn them anyway.
> >
> > It damns us OS vendors a different way in that we get unacceptably long
> > idle spin loops on some machines.  Spinning for 1000 us is not correct any
> > way you interpret the standard.
>
> You have a machine which isn't able to stall for 1 millisecond?

The performance loss becomes more noticable when run repeatedly.  A single
1 ms stall is not horrible.  In any case, my latter statement is the
point.

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
