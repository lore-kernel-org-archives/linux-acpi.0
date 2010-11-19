From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Fri, 19 Nov 2010 07:56:38 -0800
Message-ID: <AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50512 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754896Ab0KSP5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Nov 2010 10:57:17 -0500
In-Reply-To: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Nov 19, 2010 at 12:10 AM, Huang Ying <ying.huang@intel.com> wrote:
>
> This is used by APEI ERST and GEHS. But it is a generic hardware
> error reporting mechanism and can be used by other hardware error
> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.

Yeah, no.

Really.

We don't want some specific hardware error reporting mechanism.
Hardware errors are way less common than other errors, so making
something that is special to them just isn't very interesting.

I seriously suggest that the only _sane_ way to handle hardware errors is to
 (a) admit that they are rare
 (b) not try to use some odd special mechanism for them
 (c) just 'printk' them so that you can use the absolutely most
standard way to report them, and one that administrators are already
used to and has support for network logging with existing tools etc.
 (d) and if you want to make them persistent and NMI-safe, just do
that on the _printk_ level. That way, any NMI-safeness or persistency
helps everybody.

I really see _zero_ point to some hw-error-specific model.

                     Linus
