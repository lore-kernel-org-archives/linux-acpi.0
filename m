From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V6 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
Date: Fri, 11 Nov 2016 21:26:42 +0800
Message-ID: <5825C712.5050009@linaro.org>
References: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
 <1477687696-1509-3-git-send-email-agustinv@codeaurora.org>
 <42ff0a81-7836-11f6-58e0-979bd1d0be20@linaro.org>
 <60c1d53146c0aebd3a05095823229224@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <60c1d53146c0aebd3a05095823229224@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: agustinv@codeaurora.org
Cc: mlangsdo@redhat.com, Gabriele Paoloni <gabriele.paoloni@huawei.com>, guohanjun@huawei.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, timur@codeaurora.org, linux-acpi@vger.kernel.org, msalter@redhat.com, charles.garcia-tobin@arm.com, harba@codeaurora.org, jason@lakedaemon.net, marc.zyngier@arm.com, jcm@redhat.com, cov@codeaurora.org, tglx@linutronix.de, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, astone@redhat.com, agross@codeaurora.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/10/2016 11:02 PM, agustinv@codeaurora.org wrote:
> Hey Hanjun,
>
> On 2016-11-09 21:36, Hanjun Guo wrote:
>> Hi Marc, Rafael, Lorenzo,
>>
>> Since we agreed to add a probe deferral if we failed to get irq
>> resources which mirroring the DT does (patch 1 in this patch set),
>> I think the last blocker to make things work both for Agustin and
>> me [1] is this patch, which makes the interrupt producer and consumer
>> work in ACPI, we have two different solution for one thing, we'd happy
>> to work together for one solution, could you give some suggestions
>> please?
>>
>> [1]:
>> https://mail-archive.com/linux-kernel@vger.kernel.org/msg1257419.html
>>
>> Agustin, I have some comments below.
>>
>> On 2016/10/29 4:48, Agustin Vega-Frias wrote:
>>> This allows irqchip drivers to associate an ACPI DSDT device to
>>> an IRQ domain and provides support for using the ResourceSource
>>> in Extended IRQ Resources to find the domain and map the IRQs
>>> specified on that domain.
>>>
>>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>>> ---
>>>  drivers/acpi/Makefile    |   1 +
>>>  drivers/acpi/irqdomain.c | 119
>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>
>> Could we just reuse the gsi.c and not introduce a new
>> file, probably we can change the gsi.c to irqdomain.c
>> or something similar, then reuse the code in gsi.c.
>
> I was thinking just that after we chatted off-list.

Great.

> I might revisit and see what I come up with given that we already have
> a device argument and we could pass the IRQ source there.

Sorry, I'm little confused here, why we "already have a device
argument"? in drivers/acpi/resource.c, it just use NULL as device
and we can't pass dev directly for the API is using now, could
you explain more?

Thanks
Hanjun
