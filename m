From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v4 00/16] ACPI graph support
Date: Tue, 7 Mar 2017 09:49:49 +0200
Message-ID: <20170307074948.GE3220@valkosipuli.retiisi.org.uk>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488809970-25568-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Mon, Mar 06, 2017 at 04:19:14PM +0200, Sakari Ailus wrote:
> This set contains patches written by Mika Westerberg and by myself. The 
> patchset brings support for graphs to ACPI. The functionality achieved by 
> these patches is very similar to what the Device tree provides: the port
> and the endpoint concept are being employed. The patches make use of the
> _DSD property and data extensions to achieve this. The fwnode interface is
> extended by graph functionality; this way graph information originating 
> from both OF and ACPI may be accessed using the same interface, without 
> being aware of the underlying firmware interface. 

I've tested the patches again on ARM (OF) and x86-64 (ACPI).

I have V4L2 patches depending on the ACPI graph patchset that I'd like to
have in during the same merge window. Would you either accept a pull
request, or could I have a branch on top of v4.11-rc1 containing these
patches only (for media tree)?

The patchset "Move firmware specific code to firmware specific locations"
depends on "Fwnode property API fixes for OF, pset". Would you prefer to
send the bugfixes as fixes to v4.11 or just put it all to v4.12?

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
