From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] memblock: add error return when CONFIG_HAVE_MEMBLOCK
 is not set
Date: Thu, 31 Mar 2011 09:17:05 -0700
Message-ID: <AANLkTikCEnWjgqSaXnMWTEhzqK9h9Sra5_XRkAQwjZrd@mail.gmail.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
	<20110225180634.017570095@gulag1.americas.sgi.com>
	<20110227120949.GF16453@elte.hu>
	<20110227121518.GA19165@elte.hu>
	<4D6AFBB0.70401@kernel.org>
	<4D6BF63D.2020404@sgi.com>
	<AANLkTi=Sn6DKAjGHQjtWGiLGh8vpuS-vmXK=TMDrbjdv@mail.gmail.com>
	<4D6BFF46.3050001@sgi.com>
	<AANLkTi=Xf5RaF559QsRNijmG0YP7amkG569NZFhpt4QY@mail.gmail.com>
	<4D93CDD7.8000708@sgi.com>
	<AANLkTi=eRgp0wqpwq-W=E7ptrnQuM837+J+enEA2wey-@mail.gmail.com>
	<4D949C87.1000001@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D949C87.1000001@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2011 at 8:23 AM, Mike Travis <travis@sgi.com> wrote:
>
>>
>> setup_log_buf will pass function pointer, So this one is not needed,
>> right?
>
> The other function would need the #ifdef CONFIG_HAVE_MEMBLOCK before =
calling
> memblock_alloc which I thought was the point of this patch? =A0Note w=
e still
> have the last fallback of using alloc_boot_mem in kernel/init.c.

before that patch, it already use bootmem allocation.

So should be ok to drop this one.

Thanks

Yinghai
