From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 20/24] dt: bindings: smiapp: Document lens-focus and
 flash properties
Date: Tue, 19 Sep 2017 15:00:11 -0500
Message-ID: <CAL_Jsq+YKSDn7Hoq-2wRsGyGRbQvNPEVXrj13bSNCqQpKE2CvQ@mail.gmail.com>
References: <20170911080008.21208-1-sakari.ailus@linux.intel.com>
 <20170911080008.21208-21-sakari.ailus@linux.intel.com> <20170918210028.67sbpuetdh5j7wpf@rob-hp-laptop>
 <ef8edab3-5b55-c298-2a40-72b5e22586ea@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ef8edab3-5b55-c298-2a40-72b5e22586ea-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 18, 2017 at 4:56 PM, Sakari Ailus
<sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi Rob,
>
>
> Rob Herring wrote:
>>
>> On Mon, Sep 11, 2017 at 11:00:04AM +0300, Sakari Ailus wrote:
>>>
>>> Document optional lens-focus and flash properties for the smiapp driver.
>>>
>>> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
>
> Thanks for the ack. There have been since a few iterations of the set, and
> the corresponding patch in v13 has minor changes to this:

My review script can't deal with subject changes...

> <URL:http://www.spinics.net/lists/linux-media/msg121929.html>
>
> Essentially "flash" was renamed to "flash-leds" as the current flash devices
> we have are all LEDs and the referencing assumes LED framework's ways to
> describe LEDs. The same change is present in the patch adding the property

So we're kind of creating a binding that mirrors the gpio bindings
(*-gpios) which is a bit of an oddball as all other bindings have gone
with a fixed property name and then a *-names property to name them.
The main downside to this form is a prefixed property name is harder
to parse and validate. So perhaps we should follow the more common
pattern, but we're not really describing a h/w connection just an
association. And now we also have the trigger source binding to
associate LEDs with device nodes, so perhaps that should be used here.
We shouldn't really have 2 ways to associate things in DT even if how
that gets handled in the kernel is different.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
