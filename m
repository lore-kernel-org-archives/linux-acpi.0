From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 1/3] device property: Move FW type specific functionality
 to FW specific files
Date: Fri, 24 Mar 2017 13:42:13 +0200
Message-ID: <20170324114212.GA16657@valkosipuli.retiisi.org.uk>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490353432-12017-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2017 at 01:03:50PM +0200, Sakari Ailus wrote:
> The device and fwnode property API supports Devicetree, ACPI and pset
> properties. The implementation of this functionality for each firmware
> type was embedded in the fwnode property core. Move it out to firmware
> type specific locations, making it easier to maintain.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Oh, this escaped me a bit early.

This set is the other part split off from the earlier "Move firmware
specific code to firmware specific locations" set. It depends on my earlier
the fwnode fixes, ACPI graph support patchsets and patch "device property:
Read strings using string array reading functions" that are intended for the
PM tree. They also depend on patch "of: Move OF property and graph API from
base.c to property.c" which is intended for the DT tree --- this patch
additionally depends on the patches on DT tree.

The only change in the patches from the previous set is rebase, and a new
patch adding support for fwnode_graph_get_remote_node() has been added. The
last patch is currently untested. I'll test it in the near future; this set
is not mergeable for a while until the dependent patches have been merged to
the respective trees and a new rc1 release is available.

I'm uploading the patches to the two branches here:

Fwnode fixes + ACPI graph support + "device property:
Read strings using string array reading functions":

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-all>

The previous patches on Rob H's for-next branch + "of: Move OF property
and graph API from base.c to property.c" + this patchset:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned-on-next>

It may still take a while until the patches get there.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
