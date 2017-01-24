From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
Date: Tue, 24 Jan 2017 21:50:59 +0800
Message-ID: <58875BC3.4090101@linaro.org>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170124105717.GB6277@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ding Tianhong <dingtianhong@huawei.com>, Fu Wei <fu.wei@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On 01/24/2017 06:57 PM, Mark Rutland wrote:
> On Tue, Jan 24, 2017 at 06:39:51PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Add hisilicon timer specific erratum fixes.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 80d6f76..3e62a09 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
>>   	void *context;
>>   };
>>
>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>> +static void __init hisi_erratum_workaroud_enable(void *context)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
>> +		if (!strcmp(context, ool_workarounds[i].id)) {
>> +			timer_unstable_counter_workaround = &ool_workarounds[i];
>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>> +			pr_info("arch_timer: Enabling workaround for %s\n",
>> +				timer_unstable_counter_workaround->id);
>> +			break;
>> +		}
>> +	}
>> +}
>> +#endif
>> +
>>   /* note: this needs to be updated according to the doc of OEM ID
>>    * and TABLE ID for different board.
>>    */
>>   static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>> +	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>> +	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>> +	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>> +#endif
>>   };
>
> NAK. This duplicates logic unnecessarily (for enabling the workaround),
> and (ab)uses the id, which was intended to be specific to DT (since it
> is a DT property name).
>
> We should split the matching from the particular workaround (and
> enabling thereof), so that we can go straight from ACPI match to
> workaround (without having to use the DT id in this manner), and don't
> have to duplicate the logic to enable the workaround.

maybe we can add ACPI quirk matching information in
struct arch_timer_erratum_workaround, then reuse the
code for both ACPI and DT, but it needs further cleanup
to support multi platforms sharing the same erratum in
ACPI way.

Thanks
Hanjun
