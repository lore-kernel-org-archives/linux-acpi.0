From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/4] printk: Allocate kernel log buffer earlier
Date: Mon, 28 Feb 2011 11:46:58 -0800
Message-ID: <AANLkTi=Sn6DKAjGHQjtWGiLGh8vpuS-vmXK=TMDrbjdv@mail.gmail.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
	<20110225180634.017570095@gulag1.americas.sgi.com>
	<20110227120949.GF16453@elte.hu>
	<20110227121518.GA19165@elte.hu>
	<4D6AFBB0.70401@kernel.org>
	<4D6BF63D.2020404@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63763 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1B1Tq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2011 14:46:59 -0500
In-Reply-To: <4D6BF63D.2020404@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Feb 28, 2011 at 11:23 AM, Mike Travis <travis@sgi.com> wrote:
>
>
> Yinghai Lu wrote:
>>
>> On 02/27/2011 04:15 AM, Ingo Molnar wrote:
>>>
>>> * Ingo Molnar <mingo@elte.hu> wrote:
>>>
>>>> You could avoid all this ugly workaround of bootmem limitations by
>>>> moving the allocation to memblock_alloc() and desupporting the log=
_buf_len=3D
>>>> boot parameter on non-memblock architectures.
>>>
>>> memblock_alloc() could return -ENOSYS on architectures that do not
>>> implement it - thus enabling such optional features without ugly #i=
fdef
>>> CONFIG_HAVE_MEMBLOCK conditionals.
>>
>> Mike,
>>
>> please check updated patch...
>>
>> with the memblock change, you don't need to change acpi SRAT handlin=
g etc
>> any more.
>
> I had to debug a weird ACPI -> Node mapping last week and the
> "improved" SRAT messages helped that considerably. =A0It was
> far easier to spot which Node didn't have the correct assignments.
> I'd submit that patch even without needing fewer (like 512 lines
> max instead of 4096 lines max) bytes in the log buffer.

Your current change to ACPI srat is not complete yet.

you only handle x2apic entries.

According to ACPI 4.0 spec, We should have mixed entries with apic
entries and x2apic entries.
apic entries are for apic id < 255.
x2apic entries are for apic id > 255.

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
