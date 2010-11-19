From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Fri, 19 Nov 2010 19:54:07 +0800
Message-ID: <AANLkTik3ujs7-tMNUuk33wuMXFm+iusspMcR=yjPXtn_@mail.gmail.com>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
	<1290165768.2109.1537.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53747 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0KSLyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Nov 2010 06:54:08 -0500
In-Reply-To: <1290165768.2109.1537.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>

On Fri, Nov 19, 2010 at 7:22 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2010-11-19 at 16:10 +0800, Huang Ying wrote:
>> Hi, Len,
>>
>> This is used by APEI ERST and GEHS. But it is a generic hardware
>> error reporting mechanism and can be used by other hardware error
>> reporting mechanisms such as EDAC, PCIe AER, Machine Check, etc.
>>
>> The patchset is split from the original APEI patchset to make it
>> explicit that this is a generic mechanism, not APEI specific bits.
>>
>> [PATCH 1/2] Generic hardware error reporting mechanism
>> [PATCH 2/2] Hardware error record persistent support
>
> You call it generic, does that mean the EDAC guys agree, does it work on
> AMD and IA64?

I call it "generic", because it can be used by EDAC, PCIe AER, Machine
Check, etc to report hardware errors, and it can work on  AMD and
IA64.

> If not, Tony could you please apply a cluebat? I thought Intel was going
> to sit around the table with all hardware error people and come up with
> a unified thing at LPC?

Best Regards,
Huang Ying
