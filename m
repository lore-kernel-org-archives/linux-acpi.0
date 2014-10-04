From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v3 03/15] ACPI: Allow drivers to match using Device Tree compatible property
Date: Sat, 04 Oct 2014 02:02:17 +0200
Message-ID: <1573401.WKjUTvdzsT@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <20141003134303.GK26643@leverpostej> <20141003175910.GB7507@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003175910.GB7507@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, October 03, 2014 10:59:10 AM Dmitry Torokhov wrote:
> On Fri, Oct 03, 2014 at 02:43:03PM +0100, Mark Rutland wrote:
> > Hi Rafael,
> > 
> > On Wed, Oct 01, 2014 at 03:10:40AM +0100, Rafael J. Wysocki wrote:
> > > From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > 
> > > We have lots of existing Device Tree enabled drivers and allocating
> > > separate _HID for each is not feasible. Instead we allocate special
> > > _HID "PRP0001" that means that the match should be done using Device
> > > Tree compatible property using driver's .of_match_table instead.
> > 
> > That's hopefully not the precise meaning of "PRP0001" unless we're
> > attempting no semblance of OS independence here?
> > 
> > I'm still of the opinion that marrying ACPI to existing (and often
> > ill-defined) DT bindings is a bad idea. While it's expedient, I believe
> > this is going to be a long-term maintenance nightmare.
> > 
> > I'm very concerned with the prospect of model mismatch between the two
> > (e.g. DT clocks properties where ACPI has traditionally been in charge
> > of clock management). I've not seen any high-level guidelines w.r.t.
> > what should live in _DSD properties and what should not (at least not in
> > the ACPI spec itself). There are almost certainly properties that only
> > make sense if !ACPI, and likely there will be some that only make sense
> > if ACPI.
> > 
> > So I think that in its current level of standardisation, _DSD only makes
> > sense for simple device properties, and not relationships between
> > devices, except where ACPI already has some kind of a model (which
> > currently seems to cover interrupts and GPIOs). I'd also hope that we
> > could expose a 'clean' subset of DT bidnings (i.e. those which aren't
> > known to be kept around only for compatibility with legacy DTBs).
> > 
> > I do not believe it makes sense to share such a low-level interface.
> > Given the aforementioned model differences, and the fact that we don't
> > need to support _every_ device tree binding, I don't see why this can't
> > be handled with separate probe paths in the drivers we care about (as we
> > already do for DT vs platform data).
> 
> Because as a driver writer I do not want to implement N+1 ways of
> getting device configuration. I want one API that works independently of
> the underlying platform. The DT vs platform data is bad enough already.

Well stated, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
