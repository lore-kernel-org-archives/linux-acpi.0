From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 4/8] v4l: async: Provide interoperability between OF
 and fwnode matching
Date: Mon, 10 Apr 2017 14:28:57 +0300
Message-ID: <20170410112857.GP4192@valkosipuli.retiisi.org.uk>
References: <1491484330-12040-1-git-send-email-sakari.ailus@linux.intel.com>
 <1491484330-12040-5-git-send-email-sakari.ailus@linux.intel.com>
 <4169138.83VydnvH0Q@avalon>
 <20170407221047.GL4192@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170407221047.GL4192-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Laurent,

On Sat, Apr 08, 2017 at 01:10:47AM +0300, Sakari Ailus wrote:
> Hi Laurent,
> 
> On Fri, Apr 07, 2017 at 01:07:48PM +0300, Laurent Pinchart wrote:
> > Hi Sakari,
> > 
> > Thank you for the patch.
> > 
> > On Thursday 06 Apr 2017 16:12:06 Sakari Ailus wrote:
> > > OF and fwnode support are separated in V4L2 and individual drivers may
> > > implement one of them. Sub-devices do not match with a notifier
> > > expecting sub-devices with fwnodes, nor the other way around.
> > 
> > Shouldn't we instead convert all drivers to fwnode matching ? What's missing 
> > after the mass conversion in patch 5/8 ?
> 
> A lot of drivers use the OF frame work and thus do not deal with fwnodes
> directly. I haven't entirely converted them to use the fwnode API since
> making additional, unnecessary changes increases the likelihood of errors.

Doing the rest of the conversion was less work than I originally had
anticipated. The changes are obvious and very similar from driver to driver,
perhaps unsurprisingly. Nevertheless, additional testing coverage certainly
wouldn't hurt.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
