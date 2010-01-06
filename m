From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Wed, 6 Jan 2010 14:36:40 +0000
Message-ID: <20100106143640.GB13984@srcf.ucam.org>
References: <20100104162114.GA30113@percival.namespace.at> <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain> <4B4225B3.8070705@zytor.com> <20100104174558.158cd512@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51112 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab0AFOiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 09:38:50 -0500
Content-Disposition: inline
In-Reply-To: <20100104174558.158cd512@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

On Mon, Jan 04, 2010 at 05:45:58PM -0800, Arjan van de Ven wrote:

> can we do it based on the dmi/acpi year?
> Eg for all 2008 and later machines or something, while leaving the
> older ones as is

I think a saner model would be to use a similar method to Windows - 
that is, change behaviour based on the OSI calls that the firmware 
makes. If the firmware supports Vista, it's probably safe to use the 
ACPI reboot method.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
