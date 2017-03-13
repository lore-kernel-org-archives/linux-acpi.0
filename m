From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 00/17] Move firmware specific code to firmware specific locations
Date: Mon, 13 Mar 2017 23:27:40 +0100
Message-ID: <2385585.K4ms5H7miQ@aspire.rjw.lan>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday, March 06, 2017 05:42:46 PM Sakari Ailus wrote:
> Hi, 
> 
> This set moves firmware specific implementations of the device / fwnode
> property API to locations that are specific to firmware implementation,
> still leaving property set (which isn't really firmware) implementation in
> drivers/base/property.c.
> 
> The set depends on the ACPI graph support v4 patches I posted a moment
> ago.
> 
> The patches may be found with dependencies here:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned>
> 
> since v1:
> 
> - Move the three bugfixes in front of the set into a separate patchset.
>   There are no dependencies to those from the rest of the patches.
> 
> - Rebase on current ACPI graph support patches (themselves on PM tree
>   4.11-rc1 merge).

To me, all material from patches [1-11/17] can easily go into one patch which
would also help to review it quite a bit.

Analogously, all material in patches [12-16/17] can go into one patch too.

The split as is appears quite artificial, honestly.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
