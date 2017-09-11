From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v9 00/23] Unified fwnode endpoint parser, async
 sub-device notifier support, N9 flash DTS
Date: Mon, 11 Sep 2017 11:24:02 +0300
Message-ID: <20170911082402.rz53v552iap5pdwv@valkosipuli.retiisi.org.uk>
References: <20170908131235.30294-1-sakari.ailus@linux.intel.com>
 <20170908132507.nqofkw2g43m7ydux@valkosipuli.retiisi.org.uk>
 <20170909093413.GN27428@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170909093413.GN27428@amd>
Sender: linux-media-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, niklas.soderlund@ragnatech.se, robh@kernel.org, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, linux-acpi@vger.kernel.org, mika.westerberg@intel.com, devicetree@vger.kernel.org, sre@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 09, 2017 at 11:34:13AM +0200, Pavel Machek wrote:
> On Fri 2017-09-08 16:25:07, Sakari Ailus wrote:
> > On Fri, Sep 08, 2017 at 04:11:51PM +0300, Sakari Ailus wrote:
> > > With this, the as3645a driver successfully registers a sub-device to the
> > > media device created by the omap3isp driver. The kernel also has the
> > > information it's related to the sensor driven by the smiapp driver but we
> > > don't have a way to expose that information yet.
> > 
> > The patches are also available here:
> > 
> > <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=fwnode-parse>
> 
> I merged the series on top of v4.14-rc0, and it does not break
> anything. So:
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks!

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
