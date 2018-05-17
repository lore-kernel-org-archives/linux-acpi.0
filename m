From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Thu, 17 May 2018 10:08:25 +0100
Message-ID: <829ce0f6-0234-c0f1-0f30-7fbb36fa6049@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <20180517065449.GA13589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517065449.GA13589@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Jeremy Linton <jeremy.linton@arm.com>, Catalin.Marinas@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@codeaurora.org, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org

Hi Greg,

On 17/05/18 07:54, Greg KH wrote:
> On Tue, May 15, 2018 at 12:15:08PM -0500, Jeremy Linton wrote:
>> Hi Greg,
>>
>> Have you had a chance to look at the cachinfo parts of this patch?
> 
> Nope :)
> 
> I didn't write that, and while it is dumped in the driver core section
> of the kernel, I know nothing about it. 

Sorry for that, I didn't find any better place at that time(neither
now), so I did put it there following topology :)

> If you get an ack from Sudeep for this, which you did, that's fine
> with me, merge away!
> 

Thanks, we plan to take it via ARM64, hence we needed your official
say(ACK) for that.

-- 
Regards,
Sudeep
