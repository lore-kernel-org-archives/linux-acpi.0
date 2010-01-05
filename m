From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Mon, 4 Jan 2010 17:45:58 -0800
Message-ID: <20100104174558.158cd512@infradead.org>
References: <20100104162114.GA30113@percival.namespace.at>
	<alpine.LFD.2.00.1001041209300.4012@localhost.localdomain>
	<4B4225B3.8070705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48848 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab0AEBoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 20:44:23 -0500
In-Reply-To: <4B4225B3.8070705@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <lenb@kernel.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Mon, 04 Jan 2010 09:30:27 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 01/04/2010 09:15 AM, Len Brown wrote:
> > 
> > I believe that Venki is sending a patch to make all recent
> > motherboards use acpi reset by default; and I'd rather
> > see that kind of patch than this one.
> > 
> > I've had the patch below patch in acpi-test, and thus linus-next,
> > and -mm since Nov 2008 to change the default for
> > all systems w/ no issues.
> > 
> 
> Maybe I'm misremembering, but didn't we have to pull this patch after
> it hit mainstream the last time?

can we do it based on the dmi/acpi year?
Eg for all 2008 and later machines or something, while leaving the
older ones as is



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
