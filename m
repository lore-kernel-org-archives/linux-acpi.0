From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH] et8ek8: Add support for flash and lens devices
Date: Tue, 12 Sep 2017 14:06:45 +0300
Message-ID: <20170912110645.npkpl4elmbrjavla@valkosipuli.retiisi.org.uk>
References: <20170908131235.30294-1-sakari.ailus@linux.intel.com>
 <20170908131822.31020-18-sakari.ailus@linux.intel.com>
 <20170909214724.GA18677@amd>
 <20170911131831.GA12658@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:35068 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751289AbdILLGt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Sep 2017 07:06:49 -0400
Content-Disposition: inline
In-Reply-To: <20170911131831.GA12658@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, niklas.soderlund@ragnatech.se, robh@kernel.org, hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, linux-acpi@vger.kernel.org, mika.westerberg@intel.com, devicetree@vger.kernel.org, sre@kernel.org

Hi Pavel,

On Mon, Sep 11, 2017 at 03:18:31PM +0200, Pavel Machek wrote:
> Parse async sub-devices by using
> v4l2_subdev_fwnode_reference_parse_sensor_common().
> 
> These types devices aren't directly related to the sensor, but are
> nevertheless handled by the et8ek8 driver due to the relationship of these
> component to the main part of the camera module --- the sensor.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> This enables me to do autofocus on n900.
> 
> Depends on Sakari's series, so best solution would be to append it there.

I added this after the smiapp driver changes.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
