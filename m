From: Elias Gabriel Amaral da Silva <tolkiendili@gmail.com>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Sat, 20 Nov 2010 21:50:06 -0300
Message-ID: <AANLkTimy3d4KATWEhBJKFaKWD2FB7b9o8oavcwBsOnrs@mail.gmail.com>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
	<AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56385 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0KUAuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Nov 2010 19:50:08 -0500
In-Reply-To: <AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

2010/11/19 Linus Torvalds <torvalds@linux-foundation.org>:
> On Fri, Nov 19, 2010 at 12:10 AM, Huang Ying <ying.huang@intel.com> wrote:
>>
>> This is used by APEI ERST and GEHS. But it is a generic hardware
>> error reporting mechanism and can be used by other hardware error
>> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.
>
> Yeah, no.
>
> Really.
>
> We don't want some specific hardware error reporting mechanism.
> Hardware errors are way less common than other errors, so making
> something that is special to them just isn't very interesting.

Reading the following google paper on memory errors:

http://www.google.com/research/pubs/pub35162.html

I suppose they weren't really reporting memory errors with printk.
Because of this:

"The scale of the system and the data being collected make the
analysis non-trivial. Each one of many ten-thousands of machines in
the fleet logs every ten minutes hundreds of parameters, adding up to
many TBytes."

This would add up to gigabytes of generated data, for each machine, in
some minutes. It seems to me that printk isn't really suited to report
large amounts of raw data.
