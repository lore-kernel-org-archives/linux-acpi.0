From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Sun, 05 Oct 2014 23:40:44 +0200
Message-ID: <2046452.dH5gnGeAQK@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1817639.W8PYrU1iOP@vostro.rjw.lan> <25153910.sxFpRXQ3aL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <25153910.sxFpRXQ3aL@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, October 04, 2014 12:56:21 PM Arnd Bergmann wrote:
> On Saturday 04 October 2014 01:58:30 Rafael J. Wysocki wrote:
> > On Friday, October 03, 2014 05:02:13 PM Arnd Bergmann wrote:
> > > On Friday 03 October 2014 14:56:10 Mark Rutland wrote:
> > > > On Thu, Oct 02, 2014 at 03:55:56PM +0100, Arnd Bergmann wrote:
> > > > I'd certainly not like to see #foo-cells in _DSD given it should be
> > > > possible with a package to have a package description like the
> > > > following:
> > > > 
> > > >         Package () {
> > > >                 Package () { ^ref1, data, data }, 
> > > >                 Package () { ^ref2, dta, data, data },
> > > >         }
> > > > 
> > > > Where the #foo-cells is implicit in each instance. That makes variadic
> > > > properties possible, and makes it possible to perform validation on each
> > > > tuple even in the binary format, which we can't do with a DTB
> > > > 
> > > > I'm not so sure on foo-names unless we made names an explicit
> > > > requirement from the start (which I wish was the case on the DT side).
> > > > Even then we might need other parallel properties anyway (think
> > > > clock-indicies).
> > > 
> > > I suppose it might even be possible to define the ACPI references to
> > > have an optional string, so you can do
> > > 
> > >          Package () {
> > >                  Package () { ^ref1, data, data }, 
> > >                  Package () { "foo", ^ref2, data, data, data },
> > >          }
> > > 
> > > The parser should be able to interpret both anonymous and named
> > > references just by looking at the type of the first member.
> > > You might not want to allow mixing them in a single property, but
> > > that is more a style question than a technical requirement.
> > 
> > Yes, that only is a matter of implementing the parser.
> > 
> > For now, it simply is easier for us to parse the
> > 
> >         Package () { ^ref1, data, data }
> > 
> > format only, because we have functions for parsing lists of strings,
> > lists of numbers etc. for other purposes anyway and we can re-use them
> > for the names etc.  I don't see a reason why the parser cannot be extended in
> > the future to handle "all in one" packages, but not necessarily at the moment.
> 
> It only really makes sense to do it that way though if it's used
> consistently, and all references do naming like this rather than
> the foo-names method.

This almost sounds like "this will only makes sense if it's beautiful"
which I'm not sure I agree with. :-)

As long as it is clear what information is represented, I have no problems
with having multiple ways of expressing it and using them however people
like.  In fact, we don't even really know at this point which way will turn
out to be most convenient eventually.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
