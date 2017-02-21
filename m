From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 15/16] device property: Add fwnode_get_next_parent()
Date: Wed, 22 Feb 2017 00:00:07 +0100
Message-ID: <CAJZ5v0iWj1gBThCAbY2m+R6VEp-88Pn=5FckvKv9Q=d2cidYyQ@mail.gmail.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
 <9a481aec-92e6-ac01-b825-167bf73dfb11@redhat.com> <6293579.fEEljmGD4Z@aspire.rjw.lan>
 <7605668.5ZxNsBFnEG@aspire.rjw.lan> <20170221081749.GC16975@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221081749.GC16975-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 21, 2017 at 9:17 AM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> Hi Rafael,
>
> On Wed, Feb 08, 2017 at 01:19:57PM +0100, Rafael J. Wysocki wrote:
> ...
>> > > I think I agree with Rob's prior comments about making an ops struct for DT
>> > > vs ACPI.  Out of the 16 patches, 2/16, 3/16, 5/16 (multiple times), and this
>> > > patch all end up using the same construct.  Maybe it needs to be a separate
>> > > refactoring effort, but if it's happening this often just in this patch set,
>> > > it seems like it's getting time to clean things up.
>> >
>> > As long as there are two cases only (ACPI vs DT), an ops struct wouldn't
>> > really make things simpler and it would make the code more difficult to
>> > follow.
>> >
>> > But we do have a third case (static or built-in properties) and it doesn't
>> > seem to be covered at all.
>>
>> That said the ops struct could be introduced on top of this series just fine.
>> It even might be cleaner to do it this way, so I'm not asking for a redesign
>> here.
>>
>> I'd like the built-in properties to be covered too, however.
>
> That sounds good to me.

OK

Please update the patches to built-in properties into account, then. :-)

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
