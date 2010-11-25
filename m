From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Wed, 24 Nov 2010 23:19:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011242316390.637@x980>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
 <AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
 <AANLkTincYS7G1yb2ukT67qvpjwQmptXzQZabLQLYrEqn@mail.gmail.com>
 <AANLkTi=U7F7MS48dC=GgGqh=cm8YrtVhrm6sDXOma6Fc@mail.gmail.com>
 <AANLkTiki3d3Ft3-XJwFg8DUzUYcz3xPoYTzLZokLf+dv@mail.gmail.com>
 <4CE7CF95.2040608@teksavvy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:56951 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0KYETq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 23:19:46 -0500
In-reply-to: <4CE7CF95.2040608@teksavvy.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: huang ying <huang.ying.caritas@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>


> If you (and the code) are absolutely certain that a particular error instance
> is totally due to the BIOS, then stick the words "BIOS ERROR" into the 
> printk().

FYI, trenn added some printk prefixes for this case a while back;

#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "

cheers,
-Len Brown, Intel Open Source Technology Center

