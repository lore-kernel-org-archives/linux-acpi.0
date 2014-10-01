From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 16:14:20 +0200
Message-ID: <6852466.Q5TXcWChqW@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <2043842.LxdgdYRbIF@wuerfel> <20141001140441.GF1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141001140441.GF1786-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 01 October 2014 17:04:41 Mika Westerberg wrote:
> 
> > On the question what to put into the name and type fields, that is
> > unrelated. The type is supposed to be for the 'device_type' property
> > in DT, which we should never rely on in a driver that supports both
> > APCI and DT. In Linux we only use that for "pci", "cpu" and "memory",
> > all of which have their own way of getting probed in ACPI.
> > The "name" is normally ignored in DT as well, except for backwards
> > compatibility with old bindings, but I would argue that you should not
> > just put "prp0001" in there. Either leave it empty like type, or use
> > the name of the device as it appears in the ACPI tables, such as "DEV0"
> > or "PWM".
> 
> OK, I think it makes sense to leave them empty. I remember I tried that
> at some point but it didn't work without N and T fields. Is there some
> example what to put there in case of empty?
> 
> Something like "of:N*T*Cgpio-leds" perhaps?

Sorry, don't know. If I read the code right, the type field in DT ends
up being "<NULL>" for any device that doesn't set the device_type 
property, but that seems a bit silly and probably isn't worth copying.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
