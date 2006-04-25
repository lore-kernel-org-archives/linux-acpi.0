From: "Therien, Guy" <guy.therien@intel.com>
Subject: RE: [2/2] ACPI: report "Module Device" support via _OSI
Date: Tue, 25 Apr 2006 00:22:15 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D58E069@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54665 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751366AbWDYHWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2006 03:22:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

Bjorn's response to my statements is correct.
The idea is that _OSI tells the platform that the OS supports the
loading of a module device so the platform firmware can declare devices
under it instead of somewhere else. i.e. the platform can assume that
the devices will be loaded. 
I view it as a AMLI configuration interface - Does your ACPI
implementation support module devices? AMLI needs to know the general
answer - can a module device driver be loaded.
Guy

-----Original Message-----
From: Moore, Robert 
Sent: Friday, April 21, 2006 11:25 AM
To: Bjorn Helgaas
Cc: Kenji Kaneshige; Brown, Len; linux-acpi@vger.kernel.org; Andrew
Morton; Keshavamurthy, Anil S; Keiichiro Tokunaga; Motoyuki Ito;
Therien, Guy
Subject: RE: [2/2] ACPI: report "Module Device" support via _OSI

Adding Guy to the list


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi- 
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Friday, April 21, 2006 11:22 AM
> To: Moore, Robert
> Cc: Kenji Kaneshige; Brown, Len; linux-acpi@vger.kernel.org; Andrew 
> Morton; Keshavamurthy, Anil S; Keiichiro Tokunaga; Motoyuki Ito
> Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
> 
> On Friday 21 April 2006 11:23, Moore, Robert wrote:
> > Response from Guy Therien:
> >
> > When the module device is ignored the devices under it will not be 
> > enumerated and so those devices need to be declared elsewhere where 
> > they will be enumerated in the event that the OS does not support 
> > module device.
> >
> > Consider processors on hot plug modules that are not unpluggable on 
> > some OS. They need to be in the \_SB scope. If OS supports module 
> > device then they need to be under the module so the module can be 
> > ejected. They CANNOT be in 2 places at the same time.
> 
> I'm with you so far.  Does that have a bearing on what _OSI("Module
> Device") should return if there is a container module, but it isn't 
> loaded?
> 
> My theory is that if there is a container module, _OSI should return 
> true even if the module isn't loaded.  The firmware can then place the

> CPUs under the module device, and the OS will enumerate the CPUs when 
> the container driver is loaded.
> 
> This means CPUs will probably be discovered later than they are today.
> Is there a problem with that?
> 
> > > -----Original Message-----
> > > From: Kenji Kaneshige [mailto:kaneshige.kenji@jp.fujitsu.com]
> > > Sent: Thursday, April 20, 2006 1:33 AM
> > > To: Bjorn Helgaas
> > > Cc: Brown, Len; linux-acpi@vger.kernel.org; Andrew Morton; Moore,
> > Robert;
> > > Keshavamurthy, Anil S; Keiichiro Tokunaga; Motoyuki Ito
> > > Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
> > >
> > > Bjorn Helgaas wrote:
> > > > On Wednesday 19 April 2006 00:34, Kenji Kaneshige wrote:
> > > >
> > > >>I have a question. The ACPI container driver can be build as a 
> > > >>kernel module. Should _OSI("Module Device") returns TRUE even 
> > > >>when container driver module is not loaded? (Typically, _OSI is 
> > > >>evaluated at _INI time, I think. So container driver module is 
> > > >>not loaded at _OSI("Module Device") time anyway.)
> > > >
> > > >
> > > > Good question.  I think _OSI("Module Device") should return true

> > > > even if the container driver isn't loaded.
> > > >
> > > > Do you think that's a bad idea?
> > > >
> > > > I think it's OK if the namespace contains container devices that

> > > > we ignore until the driver is loaded.  Someday, the presence of 
> > > > those devices should be enough to cause udev to load the driver 
> > > > automatically.  But for now, I think we have to do it manually.
> > > >
> > >
> > > I see. I think you are right.
> > >
> > > But now, I'm wondering why ACPI firmware needs _OSI("Module
> > > Device") because I think module devices in the namespace will be 
> > > ignored by the OS if it doesn't support "Module Device"...
> > >
> > > Anyway, thank you for your answer.
> > >
> > > Thanks,
> > > Kenji Kaneshige
> > >
> > >
> > > >
> > > >>Bjorn Helgaas wrote:
> > > >>
> > > >>>Update _OSI strings to report that "Module Device" is
supported.
> > > >>>
> > > >>>This is Linux-specific, so it should be one of the Linux
> > divergences
> > > >>>from the Intel ACPI CA.
> > > >>>
> > > >>>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > >>>
> > > >>>Index: work-mm5/drivers/acpi/utilities/uteval.c
> > >
>>>===================================================================
> > > >>>--- work-mm5.orig/drivers/acpi/utilities/uteval.c
2006-04-18
> > > 15:31:22.000000000 -0600
> > > >>>+++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18
> > > 15:32:38.000000000 -0600
> > > >>>@@ -69,6 +69,9 @@
> > > >>> 	/* Feature Group Strings */
> > > >>>
> > > >>> 	"Extended Address Space Descriptor",
> > > >>>+#ifdef CONFIG_ACPI_CONTAINER
> > > >>>+	"Module Device",
> > > >>>+#endif
> > > >>> };
> > > >>>
> > > >>> /* Local prototypes */
> > > >>>-
> > > >>>To unsubscribe from this list: send the line "unsubscribe
> > linux-acpi"
> > > in
> > > >>>the body of a message to majordomo@vger.kernel.org More 
> > > >>>majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >>>
> > > >>
> > > >>-
> > > >>To unsubscribe from this list: send the line "unsubscribe
> > linux-acpi" in
> > > >>the body of a message to majordomo@vger.kernel.org More 
> > > >>majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >>
> > > >
> > > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
