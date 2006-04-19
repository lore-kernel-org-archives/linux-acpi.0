From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
Date: Wed, 19 Apr 2006 10:22:04 -0600
Message-ID: <200604191022.05016.bjorn.helgaas@hp.com>
References: <200604181558.55296.bjorn.helgaas@hp.com> <4445D9FB.100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:26579 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750904AbWDSQWM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 12:22:12 -0400
In-Reply-To: <4445D9FB.100@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Moore, Robert" <robert.moore@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

On Wednesday 19 April 2006 00:34, Kenji Kaneshige wrote:
> I have a question. The ACPI container driver can be build as a
> kernel module. Should _OSI("Module Device") returns TRUE even
> when container driver module is not loaded? (Typically, _OSI is
> evaluated at _INI time, I think. So container driver module is
> not loaded at _OSI("Module Device") time anyway.)

Good question.  I think _OSI("Module Device") should return
true even if the container driver isn't loaded.

Do you think that's a bad idea?

I think it's OK if the namespace contains container devices
that we ignore until the driver is loaded.  Someday, the
presence of those devices should be enough to cause udev
to load the driver automatically.  But for now, I think we
have to do it manually.

> Bjorn Helgaas wrote:
> > Update _OSI strings to report that "Module Device" is supported.
> > 
> > This is Linux-specific, so it should be one of the Linux divergences
> > from the Intel ACPI CA.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Index: work-mm5/drivers/acpi/utilities/uteval.c
> > ===================================================================
> > --- work-mm5.orig/drivers/acpi/utilities/uteval.c	2006-04-18 15:31:22.000000000 -0600
> > +++ work-mm5/drivers/acpi/utilities/uteval.c	2006-04-18 15:32:38.000000000 -0600
> > @@ -69,6 +69,9 @@
> >  	/* Feature Group Strings */
> >  
> >  	"Extended Address Space Descriptor",
> > +#ifdef CONFIG_ACPI_CONTAINER
> > +	"Module Device",
> > +#endif
> >  };
> >  
> >  /* Local prototypes */
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
