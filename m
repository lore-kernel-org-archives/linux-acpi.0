From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 05/14] Thermal: Obtain platform data for thermal zone
Date: Mon, 27 Aug 2012 08:59:27 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591AD512@BGSMSX101.gar.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-6-git-send-email-durgadoss.r@intel.com>
 <744357E9AAD1214791ACBA4B0B90926321014A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7788 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab2H0I7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 04:59:31 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926321014A@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

Hi Rui,

> >  /**
> >   * thermal_zone_device_register - register a new thermal zone device
> >   * @type:	the thermal zone device type
> > @@ -1443,6 +1459,11 @@ struct thermal_zone_device
> > *thermal_zone_device_register(const char *type,
> >  	if (result)
> >  		goto unregister;
> >
> > +	/* Retrieve platform level parameters for this zone */
> > +	result = retrieve_zone_params(tz);
> > +	if (result)
> > +		goto unregister;
> > +
> 
> As I said, if we need it, we should ask user to provide it during registration.
> What do you think?

That's Fine, we can provide it through tzd_register function call.

Thanks,
Durga
