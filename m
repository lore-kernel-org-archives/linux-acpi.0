From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 00/13] ACPI graph support
Date: Fri, 24 Mar 2017 17:45:56 +0200
Message-ID: <20170324154556.GD2957@lahna.fi.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 16, 2017 at 02:31:08PM +0200, Sakari Ailus wrote:
> Hello everyone,
> 
> This is the fifth version of the ACPI graph support patchset.
> 
> The previous RFC version of the set is available here:
> 
> <URL:http://www.spinics.net/lists/linux-acpi/msg69547.html> 
> 
> There are also v1, v2, v3 and v4 which can be found here:
> 
> <URL:http://www.spinics.net/lists/linux-acpi/msg71661.html>
> <URL:http://www.spinics.net/lists/linux-acpi/msg71809.html>
> <URL:http://www.spinics.net/lists/linux-acpi/msg72171.html>
> <URL:http://www.spinics.net/lists/linux-acpi/msg72346.html>
> 
> This set contains patches written by Mika Westerberg and by myself. The 
> patchset brings support for graphs to ACPI. The functionality achieved by 
> these patches is very similar to what the Device tree provides: the port
> and the endpoint concept are being employed. The patches make use of the
> _DSD property and data extensions to achieve this. The fwnode interface is
> extended by graph functionality; this way graph information originating 
> from both OF and ACPI may be accessed using the same interface, without 
> being aware of the underlying firmware interface. 
> 
> The last patch of the set contains ASL documentation including an example.

It would be helpful if you include similar diffstat here as running 'git
format-patch --cover-letter ...' generates.

Anyway for patches 7-13,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
