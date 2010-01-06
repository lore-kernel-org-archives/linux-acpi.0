From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Tue, 05 Jan 2010 22:06:29 -0800
Message-ID: <4B442865.7020500@zytor.com>
References: <4B42B3FD.7000608@zytor.com> <1262694629-7068-1-git-send-email-ch@zeha.at> <4B437127.1000605@zytor.com> <201001051926.30580.ch@zeha.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45352 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0AFGKc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 01:10:32 -0500
In-Reply-To: <201001051926.30580.ch@zeha.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hofstaedtler <ch@zeha.at>
Cc: x86@kernel.org, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com

On 01/05/2010 10:26 AM, Christian Hofstaedtler wrote:
>>
>> Why assume it is a buggy *new* BIOS rather than a buggy *old* BIOS?
> 
> Well, this is the same as with CONFIG_ACPI_BLACKLIST_YEAR. But yeah, I've also 
> thought about it, but then *I* really don't know how many such broken BIOSes 
> are there in the wild. And how many of them are new enough.
> 
> Also, I think we could push the year even more up, say, to 2009. On the 
> assumption that such new hardware which can't do BOOT_KBD is only being 
> produced now (late 2009). Better err on the safe side?
> 

2006-ish seems like a reasonable cutoff to me.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

