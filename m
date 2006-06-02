From: "Andy Currid" <ACurrid@nvidia.com>
Subject: RE: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms
Date: Fri, 2 Jun 2006 11:22:00 -0700
Message-ID: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E508@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.143]:10785 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1751442AbWFBS3M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 14:29:12 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@muc.de>, akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, luming.yu@intel.com


As currently written, I think it's safe to call it. The sdt_entry table
will be empty if the user specified 'acpi=off', so the function will
return 0.

Andy

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Thursday, June 01, 2006 20:48
> To: akpm@osdl.org
> Cc: len.brown@intel.com; linux-acpi@vger.kernel.org; Andy 
> Currid; luming.yu@intel.com
> Subject: Re: [patch 12/13] Fix HPET operation on 64-bit 
> NVIDIA platforms
> 
> 
> >  #ifdef CONFIG_ACPI
> > -					/* All timer overrides on Nvidia
> > -				           seem to be wrong. 
> Skip them. */
> > -					acpi_skip_timer_override = 1;
> > -					printk(KERN_INFO 
> > -	     "Nvidia board detected. Ignoring ACPI timer override.\n");
> > +					/*
> > +					 * All timer overrides 
> on Nvidia are
> > +					 * wrong unless HPET is enabled.
> > +					 */
> > +					nvidia_hpet_detected = 0;
> > +					acpi_table_parse(ACPI_HPET,
> > +							
> nvidia_hpet_check);
> 
> I'm not sure it's safe to call acpi_table_parse() when the 
> user passed acpi=off 
> 
> Better would be probably to set a flag in the HPET callback 
> in arch/i386/kernel/acpi/boot.c
> 
> -Andi
> 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
