From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Check battery after resume
Date: Thu, 3 Aug 2006 15:02:20 -0400
Message-ID: <20060803190220.GD11577@redhat.com>
References: <1154625457.4302.556.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:6017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964863AbWHCTC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 15:02:27 -0400
Content-Disposition: inline
In-Reply-To: <1154625457.4302.556.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Thu, Aug 03, 2006 at 07:17:37PM +0200, Thomas Renninger wrote:

 > +/* 
 > + * returns:
 > + *   0 on success
 > + *  <0 on failure
 > + *   1 if new battery found
 > + *   2 if battery got removed
 > + */

Why make this so complicated...

 > +	result = acpi_battery_check(battery);
 > +	if (result > 0){
 > +		acpi_bus_generate_event(device,
 > +					ACPI_NOTIFY_DEVICE_CHECK,
 > +					battery->flags.present);
 > +	}
 > +	return 0;
 > +}

When we simply treat the result as a boolean ?

		Dave

-- 
http://www.codemonkey.org.uk
