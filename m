From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Wed, 06 Jan 2010 13:26:54 -0800
Message-ID: <4B45001E.7000404@zytor.com>
References: <20100104162114.GA30113@percival.namespace.at> <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain> <4B4225B3.8070705@zytor.com> <20100104174558.158cd512@infradead.org> <20100106143640.GB13984@srcf.ucam.org> <alpine.LFD.2.00.1001061321260.4086@localhost.localdomain> <20100106193608.GA21447@srcf.ucam.org> <alpine.LFD.2.00.1001061504110.4086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:37325 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab0AFVcX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 16:32:23 -0500
In-Reply-To: <alpine.LFD.2.00.1001061504110.4086@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On 01/06/2010 12:22 PM, Len Brown wrote:
>>
>> It's effectively guaranteed if the system is validated with Windows.
> 
> today's common industry practice != future guarantee
> 
> We can't rely on blind use of _OSI to mean "new enough", since
> it was supported back in W2K era.  That means we have to parse
> the OSI strings.  But what happens when a BIOS writer decides to
> evaluate _OSI("Windows Future") without evaluating any of the
> old strings we know about?  We would disable ACPI reset on such
> a future box?
> 

What about using _OSI() with a *blacklist*, i.e. treat _OSI("Unknown
String") as "new enough", whereas _OSI("Windows 2000") is ignored?

	-hpa

