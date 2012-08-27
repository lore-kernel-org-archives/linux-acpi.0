From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 07/14] Thermal: Update binding logic based on platform
 data
Date: Mon, 27 Aug 2012 10:29:42 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591AD675@BGSMSX101.gar.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-8-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B90926321029F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:38564 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab2H0K3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 06:29:46 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926321029F@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

> > +
> > +static void __unbind(struct thermal_zone_device *tz, int mask,
> > +			struct thermal_cooling_device *cdev) {
> > +	int i;
> > +
> > +	for (i = 0; i < tz->trips; i++)
> > +		if (mask & (1 << i))
> > +			thermal_zone_unbind_cooling_device(tz, i, cdev); }
> > +
> > +static void update_bind_info(struct thermal_cooling_device *cdev) {
> 
> I do not think this function name is accurate.
> 
> Update_bind_info is called when a new cooling device comes
> and do_binding is called when a new zone is registered, right?
> I think we should reflect this in the function name.
> Maybe something like this:
> Int do_bind(tz, cdev) {
> 	If (tz->ops->bind)
> 		Tz->ops->bind(tz, cdev);
> 	Else {
> 		Blabla
> 		...
> 	}
> }
> 
> Bind_cdev(cdev) {
> 	List_for_each_entry(tz, thermal_tz_list) {
> 		 Do_bind(tz, cdev);
> 	}
> }
> 
> Bind_tz(tz) {
> 	List_for_each_entry(cdev, thermal_cdev_list) {
> 		 Do_bind(tz, cdev);
> 	}
> }
> 

Will see how I can rename/make this patch cleaner..

Thanks,
Durga
