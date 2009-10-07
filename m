From: Andreas Mohr <andi@lisas.de>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
	to `__udivdi3' in menu governor)
Date: Wed, 7 Oct 2009 19:34:58 +0200
Message-ID: <20091007173457.GA25415@rhlx01.hs-esslingen.de>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de> <4ACCA44B.3070706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757786AbZJGRfg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ACCA44B.3070706@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Wed, Oct 07, 2009 at 07:23:07AM -0700, Arjan van de Ven wrote:
> Andreas Mohr wrote:
>> Hi,
>>
>> didn't find any report about this, so...
>>
>>   LD      .tmp_vmlinux1
>> drivers/built-in.o(.text+0xd85a1): In function `menu_select':
>> drivers/cpuidle/governors/menu.c:212: undefined reference to `__udivdi3'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> # gcc -v
>> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/specs
>> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
>> Thread model: posix
>> gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-49)
>
> seems you're the only user of this left.

Oh my...

> it's not floating point but a 64 bit division.
> The only one I can imagine is the one on line 213
>
> looking at it, can you try sticking (u32) at the end of line 212; that multiply is not very likely to exceed 32 bits

Nopeee.

        data->predicted_us = DIV_ROUND_CLOSEST((u32)
                data->expected_us * data->correction_factor[data->bucket],
                (u32)RESOLUTION * DECAY);

It did properly rebuild drivers/cpuidle/governors/menu.o.
Still happening.
IOW it must be somewhere inside the DIV_ROUND_CLOSEST macro or so.

Andreas Mohr
