From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Discussion on device's runtime wake capability
Date: Tue, 9 Oct 2012 22:44:10 +0800
Message-ID: <20121009144407.GA1426@localhost.localdomain>
References: <5073C2D0.1080900@intel.com>
 <744357E9AAD1214791ACBA4B0B90926322FF88@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49346 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab2JIOoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 10:44:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5256279pbb.19
        for <linux-acpi@vger.kernel.org>; Tue, 09 Oct 2012 07:44:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926322FF88@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Oct 09, 2012 at 06:39:08AM +0000, Zhang, Rui wrote:
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Aaron Lu
> > Sent: Tuesday, October 09, 2012 2:23 PM
> > To: Rafael J. Wysocki; Len Brown
> > Cc: Huang, Ying; Zhang, Rui; linux-acpi@vger.kernel.org
> > Subject: Discussion on device's runtime wake capability
> > Importance: High
> > 
> > Hi all,
> > 
> > We are using _PRW as a hint to see if a device supports wakeup, this is
> > fine for device which is able to wake the system in a sleep state, but
> > not to wake itself when system is at S0.
> > 
> > Moreover, when we are to arm the device runtime wake, I think there is
> > no need to power on the power resources referenced in _PRW, those power
> > resources should be used to give the device ability to wake the system
> > from a sleep state, not to wake itself when system is at S0, so
> > powering thoses power resources on for run wake is a waste.
> > 
> Sounds reasonable to me.
> To do runtime wake, we only need to power on the resources in _PR0.

That would keep the device in D0 state :-)
We can put the device into a lower power state which _S0W permits for
run wake.

-Aaron

> 
> > But I may miss something, so it would be very kind of you to point it
> > out if things are not like what I've thought, thanks.
> > 
> > BTW, _S0W seems to be a good hint whether the device supports run wake
> > from ACPI's perspective.
> >
> Agreed.
> 
>  
> > -Aaron
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
