From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Check battery after resume
Date: Fri, 4 Aug 2006 13:09:19 -0400
Message-ID: <20060804170919.GL7265@redhat.com>
References: <1154625457.4302.556.camel@queen.suse.de> <20060803190220.GD11577@redhat.com> <1154699191.4302.610.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46245 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161328AbWHDRJZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2006 13:09:25 -0400
Content-Disposition: inline
In-Reply-To: <1154699191.4302.610.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Fri, Aug 04, 2006 at 03:46:31PM +0200, Thomas Renninger wrote:
 > On Thu, 2006-08-03 at 15:02 -0400, Dave Jones wrote:
 > > On Thu, Aug 03, 2006 at 07:17:37PM +0200, Thomas Renninger wrote:
 > > 
 > >  > +/* 
 > >  > + * returns:
 > >  > + *   0 on success
 > >  > + *  <0 on failure
 > >  > + *   1 if new battery found
 > >  > + *   2 if battery got removed
 > >  > + */
 > > 
 > > Why make this so complicated...
 > > 
 > >  > +	result = acpi_battery_check(battery);
 > >  > +	if (result > 0){
 > >  > +		acpi_bus_generate_event(device,
 > >  > +					ACPI_NOTIFY_DEVICE_CHECK,
 > >  > +					battery->flags.present);
 > >  > +	}
 > >  > +	return 0;
 > >  > +}
 > > 
 > > When we simply treat the result as a boolean ?
 > 
 > The return value is used to:
 >    check for error                       <0
 >    success, no battery insertion/removal 0
 >    battery insertion/removal             >0  (1/2)
 > 
 > The latter one is needed to inform userspace to reread complete battery
 > information (possibly from other BATx dir) if battery has been
 > inserted/removed.

The code cares about 2 possible states 'is there a battery added/removed'.
Yet there are 4 possible states for no obvious reason.
acpi_battery_check code could just as easily return
0=nothing changed, 1=battery added/removed, as you don't distinguish
between states '1' and '2' anyway.

		Dave

-- 
http://www.codemonkey.org.uk
