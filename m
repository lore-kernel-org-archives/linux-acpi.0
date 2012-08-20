From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 01/13] Thermal: Refactor thermal.h file
Date: Mon, 20 Aug 2012 20:53:14 +0300
Message-ID: <20120820175314.GO9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-2-git-send-email-durgadoss.r@intel.com>
 <20120820155817.GN9833@besouro>
 <4D68720C2E767A4AA6A8796D42C8EB591AA430@BGSMSX101.gar.corp.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:32991 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237Ab2HTRxW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 13:53:22 -0400
Received: by wgbez12 with SMTP id ez12so5282250wgb.6
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 10:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591AA430@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

Hello,

On Mon, Aug 20, 2012 at 04:42:12PM +0000, R, Durgadoss wrote:
> Hi Eduardo,
> 
> > -----Original Message-----
> > From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
> > Sent: Monday, August 20, 2012 9:28 PM
> > To: R, Durgadoss
> > Cc: lenb@kernel.org; Zhang, Rui; rjw@sisk.pl; linux-acpi@vger.kernel.org;
> > linux-pm@vger.kernel.org; eduardo.valentin@ti.com;
> > amit.kachhap@linaro.org; wni@nvidia.com
> > Subject: Re: [PATCH 01/13] Thermal: Refactor thermal.h file
> > 
> > Hello Durga,
> > 
> > On Thu, Aug 09, 2012 at 06:15:53PM +0530, Durgadoss R wrote:
> > > This file rearranges the code in thermal.h file,
> > 
> > I suppose you meant 'this patch'?
> 
> Oh yes. v2 on the way, will fix it there.

Oh.. Ok. I will go through V1 anyway, just in case.

> 
> > 
> > > in the following order, so that it is easy to
> > > read/maintain.
> > > 1. All #defines
> > > 2. All enums
> > > 3. All fops structures
> > > 4. All device structures
> > > 5. All function declarations
> > 
> > Cool!
> > 
> > >
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > ---
> > >  include/linux/thermal.h |   78 ++++++++++++++++++++++++++-------------
> > --------
> > >  1 file changed, 43 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 91b3481..8611e3e 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -29,6 +29,23 @@
> > >  #include <linux/device.h>
> > >  #include <linux/workqueue.h>
> > >
> > > +#define THERMAL_TRIPS_NONE	-1
> > > +#define THERMAL_MAX_TRIPS	12
> > > +#define THERMAL_NAME_LENGTH	20
> > > +
> > > +/* No upper/lower limit requirement */
> > > +#define THERMAL_NO_LIMIT	-1UL
> > > +
> > > +/* Unit conversion macros */
> > > +#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> > > +				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> > > +#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
> > > +
> > > +/* Adding event notification support elements */
> > > +#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
> > > +#define THERMAL_GENL_VERSION                    0x01
> > > +#define THERMAL_GENL_MCAST_GROUP_NAME
> > "thermal_mc_group"
> > > +
> > >  struct thermal_zone_device;
> > >  struct thermal_cooling_device;
> > >
> > > @@ -50,6 +67,30 @@ enum thermal_trend {
> > >  	THERMAL_TREND_DROPPING, /* temperature is dropping */
> > >  };
> > >
> > > +/* Events supported by Thermal Netlink */
> > > +enum events {
> > > +	THERMAL_AUX0,
> > > +	THERMAL_AUX1,
> > > +	THERMAL_CRITICAL,
> > > +	THERMAL_DEV_FAULT,
> > > +};
> > > +
> > > +/* attributes of thermal_genl_family */
> > > +enum {
> > > +	THERMAL_GENL_ATTR_UNSPEC,
> > > +	THERMAL_GENL_ATTR_EVENT,
> > > +	__THERMAL_GENL_ATTR_MAX,
> > > +};
> > > +#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX -
> > 1)
> > > +
> > > +/* commands supported by the thermal_genl_family */
> > > +enum {
> > > +	THERMAL_GENL_CMD_UNSPEC,
> > > +	THERMAL_GENL_CMD_EVENT,
> > > +	__THERMAL_GENL_CMD_MAX,
> > > +};
> > > +#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> > > +
> > >  struct thermal_zone_device_ops {
> > >  	int (*bind) (struct thermal_zone_device *,
> > >  		     struct thermal_cooling_device *);
> > > @@ -83,11 +124,6 @@ struct thermal_cooling_device_ops {
> > >  	int (*set_cur_state) (struct thermal_cooling_device *, unsigned
> > long);
> > >  };
> > >
> > > -#define THERMAL_NO_LIMIT -1UL /* no upper/lower limit requirement
> > */
> > > -
> > > -#define THERMAL_TRIPS_NONE -1
> > > -#define THERMAL_MAX_TRIPS 12
> > > -#define THERMAL_NAME_LENGTH 20
> > >  struct thermal_cooling_device {
> > >  	int id;
> > >  	char type[THERMAL_NAME_LENGTH];
> > > @@ -100,10 +136,6 @@ struct thermal_cooling_device {
> > >  	struct list_head node;
> > >  };
> > >
> > > -#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> > > -				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> > > -#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
> > > -
> > >  struct thermal_attr {
> > >  	struct device_attribute attr;
> > >  	char name[THERMAL_NAME_LENGTH];
> > > @@ -131,38 +163,13 @@ struct thermal_zone_device {
> > >  	struct list_head node;
> > >  	struct delayed_work poll_queue;
> > >  };
> > > -/* Adding event notification support elements */
> > > -#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
> > > -#define THERMAL_GENL_VERSION                    0x01
> > > -#define THERMAL_GENL_MCAST_GROUP_NAME
> > "thermal_mc_group"
> > > -
> > > -enum events {
> > > -	THERMAL_AUX0,
> > > -	THERMAL_AUX1,
> > > -	THERMAL_CRITICAL,
> > > -	THERMAL_DEV_FAULT,
> > > -};
> > >
> > >  struct thermal_genl_event {
> > >  	u32 orig;
> > >  	enum events event;
> > >  };
> > > -/* attributes of thermal_genl_family */
> > > -enum {
> > > -	THERMAL_GENL_ATTR_UNSPEC,
> > > -	THERMAL_GENL_ATTR_EVENT,
> > > -	__THERMAL_GENL_ATTR_MAX,
> > > -};
> > > -#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> > > -
> > > -/* commands supported by the thermal_genl_family */
> > > -enum {
> > > -	THERMAL_GENL_CMD_UNSPEC,
> > > -	THERMAL_GENL_CMD_EVENT,
> > > -	__THERMAL_GENL_CMD_MAX,
> > > -};
> > > -#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> > >
> > > +/* Function declarations */
> > 
> > for the functions exposed in this header,
> > should we also provide function nops when CONFIG_THERMAL is not set?
> > 
> 
> Theoretically agree with you.
> We will not enable thermal_sys.c if CONFIG_THERMAL is not set;
> and hence no driver should be using these API's in this case.
> So, I think it is better to throw errors rather than the driver assuming
> Thermal management will be done.
> Would prefer to leave it this way..
> 
> Thanks,
> Durga
