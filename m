From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 2/2] ACPI: EC: Fall back to DSDT scan if ECDT is broken
Date: Fri, 24 Aug 2007 07:42:24 +0400
Message-ID: <46CE53A0.60701@suse.de>
References: <46CAE65E.3000703@suse.de> <46CAE733.1010109@suse.de> <200708232337.57454.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50975 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933283AbXHXDmk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Aug 2007 23:42:40 -0400
In-Reply-To: <200708232337.57454.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Len Brown wrote:
> On Tuesday 21 August 2007 09:22, Alexey Starikovskiy wrote:
>   
>> +            printk(KERN_ERR PREFIX "ECDT is broken\n");
>>     
>
> I think this is
> 1. guaranteed to happen
>   
No, it does not happen on machine with correct ECDT, e.g. my TP  is ok.
> 2. guaranteed to alarm users and be viewed as a regression.
>   
There is a message, that we are trying to get boot EC from just found
ECDT. If it fails, we tell why.
>    They have no clue what an ECDT is, and this warning
>    doesn't tell them what to do about it, if anything.
>
> -Len
>   

