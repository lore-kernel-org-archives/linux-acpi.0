From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Mon, 16 Jan 2017 14:14:35 +0000
Message-ID: <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
 <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
 <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdAPOOl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Jan 2017 09:14:41 -0500
In-Reply-To: <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <guohanjun@huawei.com>, Charles Garcia Tobin <charles.garcia-tobin@arm.com>r

On 16/01/17 14:07, Agustin Vega-Frias wrote:
> Hi Rafael,
> 
> On 2017-01-03 16:56, Rafael J. Wysocki wrote:
>> On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
>> <agustinv@codeaurora.org> wrote:
>>> Hi,
>>>
>>> Is there any more feedback on this beyond Lorenzo's suggestion to drop
>>> the conditional check on the first patch?
>>> How can we move forward on this series?
>>
>> Essentially, I need to convince myself that patches [1-2/3] are fine
>> which hasn't happened yet.
> 
> Pinging again. Do you have any questions that might help with your
> review? I have some minor changes I have to make to the driver itself
> (patch 3) and I'd like to submit any changes you might want along with
> those.

I'd like to add that these two initial patches are now a prerequisite
for Hanjun's series, so it'd be good to have an idea of where we're
going on that front.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
