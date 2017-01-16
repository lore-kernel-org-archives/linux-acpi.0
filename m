From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Mon, 16 Jan 2017 22:41:26 +0800
Message-ID: <587CDB96.9000906@huawei.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
 <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
 <266105963441d1cdddeaf40c4b78c239@codeaurora.org>
 <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8587b5ab-59b1-feb7-09d9-7ade6d433a4c@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: harba@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rjwysocki@gmail.com, astone@redhat.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Charles Garcia Tobin <charles.garcia-tobin@arm.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2017/1/16 22:14, Marc Zyngier wrote:
> On 16/01/17 14:07, Agustin Vega-Frias wrote:
>> Hi Rafael,
>>
>> On 2017-01-03 16:56, Rafael J. Wysocki wrote:
>>> On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
>>> <agustinv@codeaurora.org> wrote:
>>>> Hi,
>>>>
>>>> Is there any more feedback on this beyond Lorenzo's suggestion to drop
>>>> the conditional check on the first patch?
>>>> How can we move forward on this series?
>>> Essentially, I need to convince myself that patches [1-2/3] are fine
>>> which hasn't happened yet.
>> Pinging again. Do you have any questions that might help with your
>> review? I have some minor changes I have to make to the driver itself
>> (patch 3) and I'd like to submit any changes you might want along with
>> those.
> I'd like to add that these two initial patches are now a prerequisite
> for Hanjun's series, so it'd be good to have an idea of where we're
> going on that front.

Is it helpful to test patch [1-2/3] on x86 machines (with different firmware) and
an IA64 machine (surely a different version of firmware :) ) with Lorenzo's suggestion
of removing  #ifdef CONFIG_ACPI_GENERIC_GSI for is_gsi()? If yes, I can do that as
I have such machines.

Thanks
Hanjun
