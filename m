From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: RE: \_PR\CPU\_INI not called during initialization
Date: Tue, 7 Oct 2003 11:14:02 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031007111150.P6708@root.org>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DE8@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3DE8-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank you!  However, I hope you call _INI even if _STA is AE_NOT_FOUND.
See the ASL below to see that there is no _STA method.  If there IS a _STA
method and it returns "not present", it's fine not to call _INI.

For now, I unconditionally call _INI when attaching to a Processor.  It
works and now my mhz and mw settings for performance control are properly
reported.

-Nate

On Tue, 7 Oct 2003, Moore, Robert wrote:
> We are going to add this support for the next version of ACPI CA.
>
> The MS interpreter executes both _STA and _INI under processor objects.
> Bob
>
>
> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
> Sent: Tuesday, October 07, 2003 12:53 AM
> To: Moore, Robert
> Cc: Nate Lawson; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] RE: \_PR\CPU\_INI not called during initialization
>
> On Mon, Oct 06, 2003 at 03:58:32PM -0700, Moore, Robert wrote:
> > Nope. A Processor object is just that.  A Processor.  Not a Device.
> > Just because something can appear under _SB does not imply that it is
> a
> > Device object.
> >
> > However, once again, we need to see what MS does.
> > Bob
> >
>
> Some IBM laptops shipped with a Pentium have that,
> or equivalent:
>
>     Scope (\_PR)
>     {
>         Processor (CPU, 0x01, 0x00001010, 0x06)
>         {
>             Method (_INI, 0, NotSerialized)
>             {
>                 Store (\P0FQ, Index (DerefOf (Index (_PSS, 0x00)), 0x00))
>                 Store (\P0PW, Index (DerefOf (Index (_PSS, 0x00)), 0x01))
>                 Store (\P1FQ, Index (DerefOf (Index (_PSS, 0x01)), 0x00))
>                 Store (\P1PW, Index (DerefOf (Index (_PSS, 0x01)), 0x01))
>                 If (\PCEL)
>                 {
>                     Store (0xF6, Index (DerefOf (Index (_PSS, 0x01)), 0x05))
>                     Store (0x00, Index (DerefOf (Index (_PSS, 0x01)), 0x05))
>                 }
>             }


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
