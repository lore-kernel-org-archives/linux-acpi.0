From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 08/14] ACPI: ARM64: IORT: rework iort_node_get_id()
Date: Thu, 5 Jan 2017 16:19:58 +0800
Message-ID: <41ea75c7-e371-a9a6-6143-af34c42ab59e@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-9-git-send-email-hanjun.guo@linaro.org>
 <20170104175822.GD8604@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170104175822.GD8604@red-moon>
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

Hi Lorenzo,

On 2017/1/5 1:58, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:39PM +0800, Hanjun Guo wrote:
>> iort_node_get_id() has two output, one is the mapped ids,
>> the other is the referenced parent node which is returned
>> from the function.
>>
>> For now we need a API just return its parent node for
>> single mapping, so just update this function slightly then
>> reuse it later.
>
> I think we need to fix iort_node_get_id() first though, I am referring
> to the index usage in relation to acpi_iort_id_mapping.output_reference
> and related parent pointer retrieval as you reported to me, I am happy
> to send it upstream independently.

Sure, please.

>
> As for this patch it is ok even though we can create an API that
> just retrieve a node parent without fiddling about with passing
> a NULL pointer for the id_out to achieve the same.

Since you commented "[PATCH v6 05/14] ACPI: platform-msi: retrieve dev
id from IORT" which also refer to this API, I will reply in that
email.

Thanks
Hanjun
