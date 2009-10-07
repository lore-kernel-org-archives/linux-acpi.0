From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
 to `__udivdi3' in menu governor)
Date: Wed, 07 Oct 2009 10:45:10 -0700
Message-ID: <4ACCD3A6.9000306@linux.intel.com>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de> <4ACCA44B.3070706@linux.intel.com> <20091007173457.GA25415@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759591AbZJGRqP@vger.kernel.org>
In-Reply-To: <20091007173457.GA25415@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andreas Mohr wrote:
> Hi,
>> looking at it, can you try sticking (u32) at the end of line 212; that multiply is not very likely to exceed 32 bits
> 
> Nopeee.
> 
>         data->predicted_us = DIV_ROUND_CLOSEST((u32)
>                 data->expected_us * data->correction_factor[data->bucket],
>                 (u32)RESOLUTION * DECAY);
> 
> It did properly rebuild drivers/cpuidle/governors/menu.o.
> Still happening.
> IOW it must be somewhere inside the DIV_ROUND_CLOSEST macro or so.

it looks like your GCC has a problem dividing by a power of two though;
both DECAY and RESOLUTION are powers of two...
