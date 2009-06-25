From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Thu, 25 Jun 2009 09:31:09 +0800
Message-ID: <1245893469.15520.123.camel@rzhang-dt>
References: <4A38F2FA.5000207@uni-koblenz.de>
	 <1245286687.9076.101.camel@rzhang-dt>  <4A40928A.7000608@uni-koblenz.de>
	 <1245746655.15520.96.camel@rzhang-dt>  <4A40961D.50504@uni-koblenz.de>
	 <1245746886.15520.98.camel@rzhang-dt> <4A409CEA.6040900@uni-koblenz.de>
	 <037F493892196B458CD3E193E8EBAD4F01E90EF8BB@pdsmsx502.ccr.corp.intel.com>
	 <4A40A170.1050401@uni-koblenz.de> <1245805110.15520.101.camel@rzhang-dt>
	 <4A41EE23.6040806@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42186 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbZFYBaZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 21:30:25 -0400
In-Reply-To: <4A41EE23.6040806@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

please attach the full dmesg output in the bugzilla.
and let's move the discussion there. :)

thanks,
rui

On Wed, 2009-06-24 at 17:13 +0800, Sebastian Pohl wrote:
> Zhang Rui wrote:
> > On Tue, 2009-06-23 at 17:33 +0800, Sebastian Pohl wrote:
> >   
> >> Zhang, Rui wrote:
> >>     
> >>>   
> >>>       
> >>>> -----Original Message-----
> >>>> From: Sebastian Pohl [mailto:sebastianp@uni-koblenz.de]
> >>>> Sent: Tuesday, June 23, 2009 5:14 PM
> >>>> To: Zhang, Rui
> >>>> Cc: linux-acpi@vger.kernel.org; Mattia Dongili
> >>>> Subject: Re: acpi on sony vaio vgn-sz61mn
> >>>>     
> >>>>         
> >>>>>       
> >>>>>           
> >>>> Hi,
> >>>>
> >>>> this is before:
> >>>>
> >>>> /sys/firmware/acpi/interrupts/error:       0
> >>>> /sys/firmware/acpi/interrupts/ff_gbl_lock:       0    enabled
> >>>> /sys/firmware/acpi/interrupts/ff_pmtimer:       0    invalid
> >>>> /sys/firmware/acpi/interrupts/ff_pwr_btn:       0    invalid
> >>>>     
> >>>>         
> >>> [Rui] power button fixed event is invalid?
> >>> Please make sure CONFIG_ACPI_BUTTON=m/y
> >>>
> >>> Thanks,
> >>> rui
> >>>
> >>>   
> >>>       
> >> It was set to
> >>
> >> CONFIG_ACPI_BUTTON=m
> >>
> >> ist that right or should i change it?
> >>
> >>     
> > please make sure it's loaded.
> > please attach the output of "grep . /proc/acpi/button/*/*/*"
> >
> > thanks,
> > rui
> >   
> Hi,
> 
> the output is
> 
> /proc/acpi/button/lid/LID0/info:type:                    Lid Switch
> /proc/acpi/button/lid/LID0/state:state:      open
> /proc/acpi/button/power/PWRB/info:type:                    Power Button (CM)
> 
> I found it interesting that theres a lid switch status listed. So i 
> tried with a magnet to trigger it and it came out like this:
> 
> /proc/acpi/button/lid/LID0/info:type:                    Lid Switch
> /proc/acpi/button/lid/LID0/state:state:      closed
> /proc/acpi/button/power/PWRB/info:type:                    Power Button (CM)
> 
> So this makes me think that the lid-switch itself is somehow reporting 
> its status but it doesnt have any effects.
> 
> 
> regards
> 
>         sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

