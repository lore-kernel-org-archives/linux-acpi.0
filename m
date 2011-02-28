From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/4] printk: Allocate kernel log buffer earlier
Date: Mon, 28 Feb 2011 11:18:11 -0800
Message-ID: <AANLkTi=odO0pGRdk5=s4qWm6bqej=CdWyS4CTsTWBxEc@mail.gmail.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
	<20110225180634.017570095@gulag1.americas.sgi.com>
	<20110227120949.GF16453@elte.hu>
	<20110227121518.GA19165@elte.hu>
	<4D6AFBB0.70401@kernel.org>
	<20110228080642.GC1600@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56827 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab1B1TUO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2011 14:20:14 -0500
In-Reply-To: <20110228080642.GC1600@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mike Travis <travis@sgi.com>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Feb 28, 2011 at 12:06 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Yinghai Lu <yinghai@kernel.org> wrote:
>
>> + =A0 =A0 new_addr =3D memblock_alloc(new_log_buf_len, PAGE_SIZE);
>> + =A0 =A0 if (new_addr !=3D MEMBLOCK_ERROR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_log_buf =3D __va(new_addr);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_log_buf =3D alloc_bootmem(new_log_buf_=
len);
>
> alloc_bootmem() can fail, especially if someone uses a too large boot=
 parameter
> value - and your code does not check for failure.

alloc_bootmem will panic if it fails.

static void * __init ___alloc_bootmem(unsigned long size, unsigned long=
 align,
                                        unsigned long goal, unsigned lo=
ng limit)
{
        void *mem =3D ___alloc_bootmem_nopanic(size, align, goal, limit=
);

        if (mem)
                return mem;
        /*
         * Whoops, we cannot satisfy the allocation request.
         */
        printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size)=
;
        panic("Out of memory");
        return NULL;
}

so it should be ok.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
