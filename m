From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] ACPI/IORT: set online numa node for smmuv3 device
Date: Thu, 28 Mar 2019 11:32:38 +0000
Message-ID: <20190328113230.GA19628@red-moon>
References: <20190315021940.86905-1-wangkefeng.wang@huawei.com>
 <20190315021940.86905-2-wangkefeng.wang@huawei.com>
 <d45aa526-2cd9-2381-8856-6ddb7e7ced7d@arm.com>
 <20190320140016.GA8694@e107981-ln.cambridge.arm.com>
 <c0ba61db-0d99-0a50-92c6-cf6f9ad97872@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c0ba61db-0d99-0a50-92c6-cf6f9ad97872@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 21, 2019 at 02:08:47PM +0800, Kefeng Wang wrote:
> =

> On 2019/3/20 22:00, Lorenzo Pieralisi wrote:
> > On Wed, Mar 20, 2019 at 11:41:18AM +0000, Robin Murphy wrote:
> >> On 15/03/2019 02:19, Kefeng Wang wrote:
> >>> If there is only node 0 in system, but smmuv3 device is set to offline
> >>> node 1, parsed from proximity domain in SMMUv3 IORT table, it will le=
ad
> >>> to following crash,
> >> Surely that's just a firmware bug? If node 1 doesn't exist in the syst=
em
> >> then AFAICS if we're presented with a device claiming to be on that no=
de we
> >> can only assume the whole thing is bogus. Thus if we're going to work =
around
> >> it at all, it seems to me like we should reject the entire device rath=
er
> >> than just bodging it to some other node.
> =

> Yes, I met this oops with a wrong IORT configuration,
> =

> > I suspect that's the same issue this thread addressed:
> >
> > https://lore.kernel.org/linux-pci/CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTS=
owTt6t3XerpHnA@mail.gmail.com/
> =

> and the situation mentioned above should will trigger this issue too.
> =

> If the node is offline, we can just return from
> arm_smmu_v3_set_proximity(),=A0 any better way to fix this?

Add a return value to the set_promixity() callback and return failure on
hitting the issue above, therefore terminating device creation.

Thanks,
Lorenzo
