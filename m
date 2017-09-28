From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v10 20/24] dt: bindings: smiapp: Document lens-focus and
 flash properties
Date: Fri, 29 Sep 2017 00:02:15 +0300
Message-ID: <20170928210215.bgtsjdj6fgcrce36@kekkonen.localdomain>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
 <20170911080008.21208-21-sakari.ailus@linux.intel.com>
 <20170918210028.67sbpuetdh5j7wpf@rob-hp-laptop>
 <ef8edab3-5b55-c298-2a40-72b5e22586ea@linux.intel.com>
 <CAL_Jsq+YKSDn7Hoq-2wRsGyGRbQvNPEVXrj13bSNCqQpKE2CvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+YKSDn7Hoq-2wRsGyGRbQvNPEVXrj13bSNCqQpKE2CvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rob,

On Tue, Sep 19, 2017 at 03:00:11PM -0500, Rob Herring wrote:
> On Mon, Sep 18, 2017 at 4:56 PM, Sakari Ailus
> <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > Hi Rob,
> >
> >
> > Rob Herring wrote:
> >>
> >> On Mon, Sep 11, 2017 at 11:00:04AM +0300, Sakari Ailus wrote:
> >>>
> >>> Document optional lens-focus and flash properties for the smiapp driver.
> >>>
> >>> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>
> >>
> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >
> >
> > Thanks for the ack. There have been since a few iterations of the set, and
> > the corresponding patch in v13 has minor changes to this:
> 
> My review script can't deal with subject changes...
> 
> > <URL:http://www.spinics.net/lists/linux-media/msg121929.html>
> >
> > Essentially "flash" was renamed to "flash-leds" as the current flash devices
> > we have are all LEDs and the referencing assumes LED framework's ways to
> > describe LEDs. The same change is present in the patch adding the property
> 
> So we're kind of creating a binding that mirrors the gpio bindings
> (*-gpios) which is a bit of an oddball as all other bindings have gone
> with a fixed property name and then a *-names property to name them.

It could be that "flash-leds" will remain the only one. Depending on
whether anyone would ever want to support a Xenon flash in which case we
could add a property for "flash-xenon" or such. Quite possibly not; LEDs
have improved in luminosity a lot over the recent years and aren't that far
from tiny Xenon flash devices. I don't remember seeing a mobile phone less
than five years or so with a Xenon flash.

> The main downside to this form is a prefixed property name is harder
> to parse and validate. So perhaps we should follow the more common
> pattern, but we're not really describing a h/w connection just an
> association. And now we also have the trigger source binding to
> associate LEDs with device nodes, so perhaps that should be used here.
> We shouldn't really have 2 ways to associate things in DT even if how
> that gets handled in the kernel is different.

trigger-sources is not really the same thing: it's present in the LED node,
not in the sensor to start with. The LED driver has no knowledge of the
Media device --- the sensor driver gains this information through the
endpoints. The sensor driver would need to find the node which contains a
phandle back to the sensor node.

Having this property in the sensor gives the association information
between the sensor and the LED. It could be present elsewhere, e.g. the
master device with DMA engines if there's no association with a sensor.

Some sensors do support strobing the flash, too. The flash type (Xenon or
LED) needs to be known to the strobe source (sensor).

The strobe wiring may not be there: the module vendors often omit that. Or
it could be omitted on the board. That's the case with LED flashes; they
can mostly be triggered using I²C as well albeit less precisely.

-- 
Kind regards,

Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
