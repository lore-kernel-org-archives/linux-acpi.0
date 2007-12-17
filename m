From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/5] ACPI: WMI: Add ACPI-WMI mapping driver
Date: Mon, 17 Dec 2007 15:01:11 +0000
Message-ID: <200712171501.11885.carlos@strangeworlds.co.uk>
References: <20071217002317.4980.71135.stgit@localhost> <20071217002322.4980.57591.stgit@localhost> <47664403.5060902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:48656 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728AbXLQPCu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Dec 2007 10:02:50 -0500
In-Reply-To: <47664403.5060902@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <ayastarik@gmail.com>

On Monday 17 December 2007 09:40:19 Alexey Starikovskiy wrote:
> > +/*
> > + * WMI can have EmbeddedControl access regions. In which case, we just
> > want to + * hand these off to the EC driver.
> > + */
> > +static acpi_status
> > +acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
> > +		      u32 bits, acpi_integer *value,
> > +		      void *handler_context, void *region_context)
> > +{
> > +	int result = 0, i = 0;
> > +	u8 temp = 0;
> > +
> > +	if ((address > 0xFF) || !value)
> > +		return AE_BAD_PARAMETER;
> > +
> > +	if (function != ACPI_READ && function != ACPI_WRITE)
> > +		return AE_BAD_PARAMETER;
> > +
>
> You probably don't need to handle more than 1 byte here -- even in EC it
> is legacy...

So would putting back in something like:

if (bits != 8)
	return AE_BAD_PARAMETER;

Be the right solution? (acpi_strict test is removed compared to EC, since it's 
no longer exported, and WMI can be built as a module)

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
