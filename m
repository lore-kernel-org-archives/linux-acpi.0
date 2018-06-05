From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] drivers: base: cacheinfo: use OF property_read_u32
 instead of get_property,read_number
Date: Tue, 5 Jun 2018 17:26:08 +0100
Message-ID: <54785881-da7c-db68-c6a4-70cfd489c1fe@arm.com>
References: <1526898749-17263-1-git-send-email-sudeep.holla@arm.com>
 <1526907189-10031-1-git-send-email-sudeep.holla@arm.com>
 <CAHp75Vd_rQFX1s6jCbj-uLC3K70sSD=s0rt3sWme_f2m90NE5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd_rQFX1s6jCbj-uLC3K70sSD=s0rt3sWme_f2m90NE5A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org



On 05/06/18 17:21, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> of_property_read_u32 searches for a property in a device node and read
>> a 32-bit value from it. Instead of using of_get_property to get the
>> property and then read 32-bit value using of_read_number, we can
>> simplify it by using of_property_read_u32.
>>
> 
> LGTM.
> Thanks!
> 

Thanks, can I take is Ack ?

Anyways it's too late for v4.18, will repost after the merge window for
v4.19 with your Ack if you agree.

-- 
Regards,
Sudeep
