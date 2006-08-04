From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Check battery after resume
Date: Fri, 04 Aug 2006 15:46:31 +0200
Message-ID: <1154699191.4302.610.camel@queen.suse.de>
References: <1154625457.4302.556.camel@queen.suse.de>
	 <20060803190220.GD11577@redhat.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:63416 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161181AbWHDNm7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2006 09:42:59 -0400
In-Reply-To: <20060803190220.GD11577@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Thu, 2006-08-03 at 15:02 -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 07:17:37PM +0200, Thomas Renninger wrote:
> 
>  > +/* 
>  > + * returns:
>  > + *   0 on success
>  > + *  <0 on failure
>  > + *   1 if new battery found
>  > + *   2 if battery got removed
>  > + */
> 
> Why make this so complicated...
> 
>  > +	result = acpi_battery_check(battery);
>  > +	if (result > 0){
>  > +		acpi_bus_generate_event(device,
>  > +					ACPI_NOTIFY_DEVICE_CHECK,
>  > +					battery->flags.present);
>  > +	}
>  > +	return 0;
>  > +}
> 
> When we simply treat the result as a boolean ?

The return value is used to:
   check for error                       <0
   success, no battery insertion/removal 0
   battery insertion/removal             >0  (1/2)

The latter one is needed to inform userspace to reread complete battery
information (possibly from other BATx dir) if battery has been
inserted/removed.

   Thomas

