From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Date: Fri, 11 Jan 2019 12:33:08 +0100
Message-ID: <20190111113308.5lwgl5d7m7zjvidr@suse.de>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 07, 2019 at 04:42:07PM +0000, Lorenzo Pieralisi wrote:
> From: Qian Cai <cai@lca.pw>
> 
> Commit 8097e53eaba2 ("ACPI/IORT: Use helper functions to access
> dev->iommu_fwspec") changed by mistake the iort_fwspec_iommu_ops() stub
> definition (compiled in when CONFIG_IOMMU_API=n), that caused the
> following compilation failure:
> 
> drivers/acpi/arm64/iort.c:880:1: error: expected identifier or
> '(' before '{' token
>  { return NULL; }
>  ^
> drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops'
> used but never defined
>  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
>                                        ^~~~~~~~~~~~~~~~~~~~~
> 
> Fix it.
> 
> Fixes: 8097e53eaba2 ("ACPI/IORT: Use helper functions to access dev->iommu_fwspec")
> Signed-off-by: Qian Cai <cai@lca.pw>
> [lorenzo.pieralisi@arm.com: updated tags and log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Joerg Roedel <jroedel@suse.de>

Applied to iommu/fixes, thanks.
