From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Mon, 24 Jan 2011 09:22:30 +0800
Message-ID: <1295832150.1866.797.camel@rui>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
	 <201101211312.16929.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41298 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab1AXBYF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jan 2011 20:24:05 -0500
In-Reply-To: <201101211312.16929.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2011-01-21 at 20:12 +0800, Thomas Renninger wrote:
> On Friday, January 21, 2011 11:52:39 AM R, Durgadoss wrote:
> > Hi Len,
> > 
> > This patch from Thomas fixes the compile dependency.
> > Looks fine as far as I have tested.
> > 
> > Could you please apply it on top of the old patch ?
> I tried to not export thermal_netlink_event in #ifndef CONFIG_NET
> case, but as it uses an enum which should only exist in CONFIG_NET
> case it doesn't work out that easy...
> 
oh, right.

IMO,
enum events {
       THERMAL_AUX0,
       THERMAL_AUX1,
       THERMAL_CRITICAL,
       THERMAL_DEV_FAULT,
};
should not be included in the ifdef case.

BTW: Durgadoss, what does THERMAL_AUX0 and THERMAL_AUX1 mean?
Sorry I missed this in the original patch, but these two events do not
look like something the generic thermal driver knows.

If you really need these kind of events, I'd prefer something like this:
enum events {
	THERMAL_CRITICAL,
	/* user defined thermal events */
	TEHRMAL_USER0,
	TEHRMAL_USER1,
	THERMAL_DEV_FAULT,
};

or
enum events {
	THERMAL_CRITICAL,
	/* user defined thermal events */
	TEHRMAL_USER_AUX0,
	TEHRMAL_USER_AUX1,
	THERMAL_DEV_FAULT,
};


> Therefore please apply this one as it is.
> 
which one? do I miss something again? :)

thanks,
rui

> Thanks,
> 
>    Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


