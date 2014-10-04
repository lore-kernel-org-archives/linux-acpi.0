From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Sat, 04 Oct 2014 12:59:59 +0200
Message-ID: <8634377.yRllsv0gms@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <20141003143547.GP26643@leverpostej> <6568619.UkU5qISONv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6568619.UkU5qISONv-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 04 October 2014 02:13:23 Rafael J. Wysocki wrote:
> > Because people get the format wrong regardless of documentation. The
> > format:
> > 
> > Package () {
> >       Package () { ^ref1, data, data },
> >       Package () { ^ref2, data },
> >       Package () { ^ref3, data, data, data },
> > }
> > 
> > Is superior to the format:
> > 
> > Package () { ^ref1, data, data, ^ref2, data, ^ref3, data, data, data }
> > 
> > Because in the former you have delimiters that can be used to verify
> > each tuple. Imagine someone misses a data element for one of these
> > tuples. In the former layout you can detect this easily while in the
> > latter you cannot.
> 
> I agree with this particular thing (although other people seem to have
> problems with too many package nesting levels) but I'm not sure what that
> has to do with the example given above (let me quote again):
> 
> > Putting everything to a single package results this:
> > 
> >       Package () { "pwms", Package () {"led-red", ^PWM0, 0, 10, "led-green", ^PWM0, 1, 10 }}
> > 
> > But I think the below looks better:
> > 
> >       Package () { "pwms", Package () {^PWM0, 0, 10, ^PWM0, 1, 10 }}
> >       Package () { "pwm-names", Package () {"led-red", "led-green"}}
> > 
> > and it is trivial to match with the corresponding DT fragment.
> 
> that I was commenting.  Both cases contains the
> 
>         Package () { ^ref1, data, data, ^ref2, data, ^ref3, data, data, data }
> 
> format that you don't like, don't they?
> 

There are two independent issues:

a) avoiding the need for "pwm-names" by embedding the name in the
   "pwms" property

b) avoiding the need for "#pwm-cells" by having explicit separators between
   entries in a "pwms" property.

It would be possible to do one but not the other.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
