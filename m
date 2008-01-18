From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from hp pavilion dv9047ea Turion X2
Date: Fri, 18 Jan 2008 15:12:29 -0500
Message-ID: <200801181512.29648.lenb@kernel.org>
References: <478C0D0E.1050402@versanet.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51432 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765474AbYARUMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:12:50 -0500
In-Reply-To: <478C0D0E.1050402@versanet.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "HasiHeike@versanet.de" <HasiHeike@versanet.de>
Cc: linux-acpi@vger.kernel.org

On Monday 14 January 2008 20:31, HasiHeike@versanet.de wrote:

> System Information
>         Manufacturer: Hewlett-Packard
>         Product Name: HP Pavilion dv9000 (RE372EA#ABD)
>         Version: Rev 1
>         Serial Number: CNF6330ND6
>         UUID: 434E4636-3333-304E-4436-00163674AE3C
>         Wake-up Type: Power Switch
>         SKU Number: RE372EA#ABD
>         Family: 103C_5335KV
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
>         Manufacturer: Quanta
>         Product Name: 30B9
>         Version: 65.29
>         Serial Number: None
> 

Does this system run any better or worse when booted with "acpi_osi=Linux"?

please send me the output from acpidump.

thanks,
-Len
