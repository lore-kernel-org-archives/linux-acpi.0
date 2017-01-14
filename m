From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v7 08/15] ACPI: IORT: rename iort_node_map_rid() to make
 it generic
Date: Sat, 14 Jan 2017 11:25:18 +0800
Message-ID: <58799A1E.9070708@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-9-git-send-email-hanjun.guo@linaro.org>
 <20170113114747.GD20837@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113114747.GD20837@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, yimin@huawei.com, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Matthias Brugger <mbrugger@suse.com>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On 2017/1/13 19:47, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:32PM +0800, Hanjun Guo wrote:
>> iort_node_map_rid() was designed for both PCI and platform
>> device, but the rid means requester id is for ITS mappings,
> I do not understand what this means sorry.
>
>> rename iort_node_map_rid() to iort_node_map_id() and update
>> its argument names to make it more generic.
>>
> "iort_node_map_rid() was designed to take an input id (that is not
> necessarily a PCI requester id) and map it to an output id (eg an SMMU
> streamid or an ITS deviceid) according to the mappings provided by an
> IORT node mapping entries. This means that the iort_node_map_rid() input
> id is not always a PCI requester id as its name, parameters and local
> variables suggest, which is misleading.
>
> Apply the s/rid/id substitution to the iort_node_map_rid() mapping
> function and its users to make sure its intended usage is clearer."

Thank your patience, I will update the commit message.

Hanjun
