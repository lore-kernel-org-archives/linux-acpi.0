From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] i2c: allow specify device properties in
 i2c_board_info
Date: Wed, 1 Feb 2017 09:10:39 -0800
Message-ID: <20170201171039.GB40045@dtor-ws>
References: <20170201021130.20586-1-dmitry.torokhov@gmail.com>
 <20170201021130.20586-5-dmitry.torokhov@gmail.com>
 <20170201152418.GQ17297@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34289 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbdBARKm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2017 12:10:42 -0500
Content-Disposition: inline
In-Reply-To: <20170201152418.GQ17297@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, Feb 01, 2017 at 05:24:18PM +0200, Mika Westerberg wrote:
> On Tue, Jan 31, 2017 at 06:11:30PM -0800, Dmitry Torokhov wrote:
> > With many drivers converting to using generic device properties, it is
> > useful to provide array of device properties when instantiating new i2c
> > client via i2c_board_info and have them automatically added to the device
> > in question.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/i2c/i2c-core.c | 16 +++++++++++++++-
> >  include/linux/i2c.h    |  3 +++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index f009549f86a5..3897e78e5e9a 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1335,15 +1335,29 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> >  	client->dev.fwnode = info->fwnode;
> >  
> >  	i2c_dev_set_name(adap, client);
> > +
> > +	if (info->properties) {
> > +		status = device_add_properties(&client->dev, info->properties);
> 
> I don't remember anymore how it was but is the driver core supposed to
> free this automatically when the device is removed or should we deal
> this in the i2c-core instead?
> 

It is done as part of device_del().

Thanks.

-- 
Dmitry
