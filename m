From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] ACPI/IORT: Reject platform device creation on NUMA
 node mapping failure
Date: Tue, 16 Apr 2019 18:05:35 +0100
Message-ID: <20190416170535.GB7342@fuggles.cambridge.arm.com>
References: <20190408104658.GB2727@red-moon>
 <20190408152112.42056-1-wangkefeng.wang@huawei.com>
 <20190416170220.GF14705@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190416170220.GF14705@red-moon>
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 16, 2019 at 06:02:20PM +0100, Lorenzo Pieralisi wrote:
> [+Will]
> 
> there is not enough material for an IORT pull request this cycle but
> this patch should be merged and IORT code goes usually via arm64, can
> you pick it up or if you prefer I can resend it on LAKML and CC you in
> if it makes it any simpler ?
> 
> On Mon, Apr 08, 2019 at 11:21:12PM +0800, Kefeng Wang wrote:
> > In a system where, through IORT firmware mappings, the SMMU device is
> > mapped to a NUMA node that is not online, the kernel bootstrap results
> > in the following crash:

Queued for 5.2. Thanks for the heads-up.

Will
