From: Corey Minyard <minyard@acm.org>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Sat, 10 Feb 2007 22:53:43 -0600
Message-ID: <45CEA157.8050207@acm.org>
References: <200702102327.28312.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta16.adelphia.net ([68.168.78.211]:62227 "EHLO
	mta16.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbXBKExq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Feb 2007 23:53:46 -0500
In-Reply-To: <200702102327.28312.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: minyard@mvista.com, linux-acpi@vger.kernel.org

Len Brown wrote:
> Cory,
> acpi_find_bmc() appears to be searching for 
> multiple SPMI tables in the RSDT and running
> try_init_acpi() on each of them
> until it doesn't find any more.
>
> Is that the intent?
>
> Are here systems with multiple SPMI tables?
>   
I'm not sure about ACPI, but I know there are system with multiple 
SMBIOS table entries for management controllers, and I know there are 
system with multiple multiple management controller interfaces (and 
multiple management controllers with interfaces).  The current table for 
SPMI can only support one interface, so I don't know how you could 
represent more than one..
> static __devinit void acpi_find_bmc(void)
> {
>         acpi_status      status;
>         struct SPMITable *spmi;
>         int              i;
>
>         if (acpi_disabled)
>                 return;
>
>         if (acpi_failure)
>                 return;
>
>         for (i = 0; ; i++) {
>                 status = acpi_get_table(ACPI_SIG_SPMI, i+1,
>                                         (struct acpi_table_header **)&spmi);
>                 if (status != AE_OK)
>                         return;
>
>                 try_init_acpi(spmi);
>         }
> }
>
> I speculated recently that the only table signature
> that is (supposed to be) repeated in the RSDT is an SSDT.
> Maybe that speculation is wrong if there can be multiple SPMI tables...
>   
I don't know ACPI that well, but the IPMI spec states that in the case 
of multiple interfaces, a unique SPMI table should be provided for each 
of those interfaces.  So the IPMI spec seems to require support more 
than one.

-Corey
