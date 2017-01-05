From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 03/14] ACPI: ARM64: IORT: add missing comment for
 iort_dev_find_its_id()
Date: Thu, 5 Jan 2017 14:05:06 +0800
Message-ID: <4915fe90-ea61-45b5-491d-0628456abed2@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-4-git-send-email-hanjun.guo@linaro.org>
 <20170104143442.GA8604@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170104143442.GA8604@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, charles.garcia-tobin@arm.com, yimin@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On 2017/1/4 22:34, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:34PM +0800, Hanjun Guo wrote:
>> We are missing req_id's comment for iort_dev_find_its_id(),
>> add it back.
>
> "Add missing req_id parameter to the iort_dev_find_its_id() function
> kernel-doc comment."
>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Majun <majun258@huawei.com>
>> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>  drivers/acpi/arm64/iort.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 46e2d82..174e983 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>>  /**
>>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>>   * @dev: The device.
>> + * @req_id: Device's Requster ID
>
> s/Requster/Requester
>
> We can send it upstream independently along with some other patches
> in this series but I will have a look at the whole series first.

Do you mean go to 4.10-rcx?

Thanks
Hanjun
