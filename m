From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [Patch 1/2]  ACPI :Compare EC device in DSDT table with
	that	in ECDT table
Date: Tue, 18 Nov 2008 09:20:29 +0800
Message-ID: <1226971229.4062.85.camel@yakui_zhao.sh.intel.com>
References: <1226904541.4062.23.camel@yakui_zhao.sh.intel.com>
	 <49212B22.5030202@suse.de>
	 <1226914935.4062.67.camel@yakui_zhao.sh.intel.com>
	 <49214B9C.6030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1482 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYKRBMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 20:12:17 -0500
In-Reply-To: <49214B9C.6030204@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Mon, 2008-11-17 at 18:46 +0800, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> >> Couple of concerns -- I think, I already mentioned one, but still...
> >> 1. By parsing DSDT unconditionally, we loose all performance (if any) benefits of
> >> having ECDT table. If we just don't look into ECDT, we will save some efforts.
> >>     
> > Agree with what you said. It is not appropriate to punish the system
> > that already works well. It will take more time to execute the function
> > of acpi_ec_ecdt_probe if ECDT table exists. OS can't confirm whether the
> > ECDT table is correct before this check. Only after the check is added,
> > we can know whether the info defined in ECDT table is reliable. So in my
> > patch it is assumed that the info defined in ECDT table is not
> > reliable.
> So, either ECDT parse should go the way of do-do,
> or DSDT parse in presence of ECDT should not happen.
> I prefer second way -- as it is closer to the specification :)
> > for [EmbeddedControl] [20070126]

> >  
> >   
> >> 2. We are speaking about broken (hopefully rare) BIOS -- it might not be wise to punish everyone (see #1).
> >> How about adding check in acpi_ec_start(), that with the same GPE we found difference in addresses?
> >>     
> >    It is a good point to add the check in the acpi_ec_start. But in such
> > case there exists two issues:
> >      a. OS will scan the ACPI namespace to build the ACPI device tree
> > before the ACPI ec driver is registered. As the EC device is already
> > initialized, maybe the EC will be accessed in the scanning of ACPI
> > device tree.(For example: in the _STA object of battery, AC Adapter). In
> > such case some warning message will be reported.
> >      >ACPI: EC: input buffer is not empty, aborting transaction
> >     >[18.125459] ACPI Exception (evregion-0420): AE_TIME, Returned by Handler
> > for [EmbeddedControl] [20070126]
> >   
Yes. It is not good to add the strict check on the "good vendors". But
how can we know that it is "good vendors" before checking? Now it is
realized by our checking the ACPI tables manually. After the bug
reporters open a new bug and attach the acpidump, we check the acpidump
and find that the BIOS is broken(incorrect ECDT table).
          
> Remember, we are speaking about broken hardware, it is OK to spill some 
> errors, while
> we provide solution to user in the end. In this case only user of broken 
> hardware is punished, not everybody.
> >     
> >     After the acpi ec driver is registered, the above message won't be reported again.
> > But it seems very confusing.
> >
> >     b. On the laptops of bug 11880 all the info in ECDT table is incorrect. 
> > The EC GPE number and EC namepath are incorrect besides the EC Cmd/Status/Data I/O port.
> >     As there exists the ECDT table, the EC device will be initialized and the incorrect 
> > EC GPE is enabled before building ACPI device tree.  In such case although the EC address
> > info can be corrected by calling the ec_parse_device in acpi_ec_start, the EC GPE can't be
> > corrected(Still the incorrect GPE number is enabled for EC).
> You could insert some check like if ("errors in boot_ec" || 
> "acpi_ec_start does not find boot ec"), print same advice...
> 
> >  
> >   
> >> And if this check triggers, print "Your ECDT does not conform to DSDT. Add acpi_ec.skip_ecdt=1 kernel option."
> >> Add acpi_ec.skip_ecdt option and skip ECDT parse if it is set...
> >> 3. This patch seems to imply that DSDT contains single EC. As this is first place with such assumption,
> >>     
> >     Yes. What you said is right. One EC device is assumed in my patch.
> > In theory there exists more than one EC device. But it seems that now no
> > laptops have more than one EC devices. Can this case be ignored?
> >   
> I have notebook  with 2 EC on my desk at the moment, made by FIC/VIA.
> I don't like to break working hardware to enable broken.
Does there exist the ECDT table for one EC device on your laptop?
     In my patch it is meaningful for the laptop with ECDT table. If
there is no ECDT table, it will continue its original routine.

Do you mind that I reassign the bug 11880 to you?
Thanks.
> 
> Regards,
> Alex.

