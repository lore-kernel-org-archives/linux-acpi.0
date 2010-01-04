From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Mon, 04 Jan 2010 09:30:27 -0800
Message-ID: <4B4225B3.8070705@zytor.com>
References: <20100104162114.GA30113@percival.namespace.at> <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39847 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab0ADRfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 12:35:40 -0500
In-Reply-To: <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On 01/04/2010 09:15 AM, Len Brown wrote:
> 
> I believe that Venki is sending a patch to make all recent
> motherboards use acpi reset by default; and I'd rather
> see that kind of patch than this one.
> 
> I've had the patch below patch in acpi-test, and thus linus-next,
> and -mm since Nov 2008 to change the default for
> all systems w/ no issues.
> 

Maybe I'm misremembering, but didn't we have to pull this patch after it
hit mainstream the last time?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

