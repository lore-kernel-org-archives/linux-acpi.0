From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Mon, 04 Jan 2010 19:37:33 -0800
Message-ID: <4B42B3FD.7000608@zytor.com>
References: <20100104162114.GA30113@percival.namespace.at> <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain> <4B4225B3.8070705@zytor.com> <alpine.LFD.2.00.1001041632330.4012@localhost.localdomain> <4B42A0CC.2090907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53418 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0AEDlz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2010 22:41:55 -0500
In-Reply-To: <4B42A0CC.2090907@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Andrey Borzenkov <arvidjaar@mail.ru>

On 01/04/2010 06:15 PM, Robert Hancock wrote:
> 
> Think you mean 2001, Vista was 2006..
> 
> I'm assuming that Windows is using ACPI reset these days, so presumably
> that's what we should be doing by default, and blacklisting machines
> where that doesn't work, rather than the reverse..

Using a DMI cutoff year in the mid-2000's seems like it would make sense.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

