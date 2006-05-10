From: Corey Minyard <minyard@acm.org>
Subject: Re: Extra ACPI objects from an acpi PNP device?
Date: Wed, 10 May 2006 15:53:45 -0500
Message-ID: <446252D9.7090407@acm.org>
References: <CFF307C98FEABE47A452B27C06B85BB669C15D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:64158 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964868AbWEJUxr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 May 2006 16:53:47 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB669C15D@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, ambx1@neo.rr.com, Matt Domsch <Matt_Domsch@dell.com>

Brown, Len wrote:

>>I have a situation where I need to get an ACPI device.  The PNP system
>>seems like the way to go for this, but I need some extra objects from
>>the ACPI namespace for this device (_IFT and _SRV to be specific,
>>supposidly added in ACPI 3.0).  There doesn't seem to be a clean way to
>>do this right now.  What would be the best way to get these?
>>    
>>
>
>If your code knows about specific AML methods, then it is by-definition,
>ACPI-aware, and can't be hidden (completely) behind PNP.
>  
>
True, but the PNP stuff does a lot of the work :)

>Either that, or some ACPI-aware code needs to exist to intervene to
>allow your code to know know anything about ACPI.
>  
>
I was thinking of some way  to determine if it is ACPI and get the
handle, or a new call to get resources.

>So you could make it ACPI aware like 8250_acpi.c was, before it was
>deleted...
>  
>
So just use ACPI directly.  This will bypass the PNP port reservation
for that particular ACPI device, I assume.

Thanks,

-Corey
