From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 00/17] Move firmware specific code to firmware
 specific locations
Date: Fri, 17 Mar 2017 00:50:20 +0200
Message-ID: <20170316225019.GK10701@valkosipuli.retiisi.org.uk>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
 <2385585.K4ms5H7miQ@aspire.rjw.lan>
 <20170315141918.GF10701@valkosipuli.retiisi.org.uk>
 <CAJZ5v0i5o+2FksW+NmYQugD6qL-1QmREd2isATifu9n0g69Q+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5o+2FksW+NmYQugD6qL-1QmREd2isATifu9n0g69Q+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 15, 2017 at 03:23:41PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 15, 2017 at 3:19 PM, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org> wrote:
> > On Mon, Mar 13, 2017 at 11:27:40PM +0100, Rafael J. Wysocki wrote:
> >> On Monday, March 06, 2017 05:42:46 PM Sakari Ailus wrote:
> >> > Hi,
> >> >
> >> > This set moves firmware specific implementations of the device / fwnode
> >> > property API to locations that are specific to firmware implementation,
> >> > still leaving property set (which isn't really firmware) implementation in
> >> > drivers/base/property.c.
> >> >
> >> > The set depends on the ACPI graph support v4 patches I posted a moment
> >> > ago.
> >> >
> >> > The patches may be found with dependencies here:
> >> >
> >> > <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>
> >> >
> >> > since v1:
> >> >
> >> > - Move the three bugfixes in front of the set into a separate patchset.
> >> >   There are no dependencies to those from the rest of the patches.
> >> >
> >> > - Rebase on current ACPI graph support patches (themselves on PM tree
> >> >   4.11-rc1 merge).
> >>
> >> To me, all material from patches [1-11/17] can easily go into one patch which
> >> would also help to review it quite a bit.
> >>
> >> Analogously, all material in patches [12-16/17] can go into one patch too.
> >>
> >> The split as is appears quite artificial, honestly.
> >
> > I believe it's easier to review the way it is. Each patch is simple and it's
> > easy to see where a particular piece of code is moved. I'm happy to fold
> > them, too, but I'd prefer keep "[PATCH v2 07/17] device property: Read
> > strings using string array reading functions" separate, as it changes the
> > implementation of reading single strings.
> >
> > How about that?
> 
> That's fine too.

I kept the last patch (device property: Implement fwnode_get_next_parent()
using fwnode interface) separate, too, as I noticed it is really separate
from moving the FW type specific parts behind an ops struct.

The details are on the cover page of v3 of the set.

-- 
Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
