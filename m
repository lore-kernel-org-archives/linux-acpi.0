From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: RE: List noise.
Date: Tue, 27 Jan 2004 19:45:10 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0401271942300.6721-100000@elektron.its.tudelft.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A62@hdsmsx402.hd.intel.com>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A62-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Some people procmail emails for the following strings, which is alledgedly
present in most W32 executables:

 * IbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5vdCBiZSBydW4gaW4g|IbgBTM0hkJBUaGlzIHByb2dyYW0gbXVzdCBiZSBydW4gdW5kZXIgV2lu

Note: the pipe is the procmail OR, but I'm sure you know this.

Maybe this helps vs virusses.

Arjen

On Tue, 27 Jan 2004, Brown, Len wrote:

> Sure, I'm open to moving the list off sourceforge if there is clearly a
> better choice.  Two other problems we've seen on sf are
> 1. latency is sometimes huge
> 2. archives sometimes unavailable, and not indexed by google.
>
> In the mean-time, here are the mailman spam filters I've got on SF, a
> couple I've added in the last 30-minutes.  It doesn't look like it can
> search for a _missing_ field -- only positive matches.  I'm sure open to
> suggestions for further improvement.
>
> Thanks,
> -Len
>
> # Lines that *start* with a '#' are comments.
> to: friend-6zcLuMBsFRvQT0dZR+AlfA@public.gmane.org
> message-id: relay.comanche.denmark.eu
> message-id *externalmx.vasoftware.com*
> from: list-pJMVowSF+OPQT0dZR+AlfA@public.gmane.org
> from: .*@uplinkpro.com
> X-Spam-Flag: YES
> Content-Type: text/html
> Auto-Submitted: auto-generated
> Precedence: bulk
> Subject: *Returned mail*
> charset="Windows-1252"
>
>
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
> > David Woodhouse
> > Sent: Tuesday, January 27, 2004 10:00 AM
> > To: Dave Jones
> > Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: Re: [ACPI] List noise.
> >
> >
> > On Tue, 2004-01-27 at 14:41 +0000, Dave Jones wrote:
> > > On Tue, Jan 27, 2004 at 02:18:05PM +0000, David Woodhouse wrote:
> > >  > All this noise on the list would be so easily avoided if
> > the list wasn't
> > >  > accepting messages without a Message-ID, and wasn't
> > accepting bounces.
> > >  >
> > >  > It's not hard -- it'd take _moments_ to protect the list
> > against this.
> > >
> > > if you had control over the MTA, yes.
> > > Sourceforget lists don't offer this power sadly.
> >
> > Mailman lets you filter on certain headers though, and trap
> > messages for
> > moderation. Can't you do something like looking for a Message-ID
> > matching ^$ ?
> >
> > Likewise Return-Path matching <>?
> >
> > --
> > dwmw2
> >
> >
> >
> > -------------------------------------------------------
> > The SF.Net email is sponsored by EclipseCon 2004
> > Premiere Conference on Open Tools Development and Integration
> > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > http://www.eclipsecon.org/osdn
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
