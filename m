From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix build when CONFIG_IOMMU_API=n
Date: Fri, 11 Jan 2019 12:29:55 +0000
Message-ID: <20190111122955.GB30082@fuggles.cambridge.arm.com>
References: <20190107164208.27789-1-lorenzo.pieralisi@arm.com>
 <20190111113308.5lwgl5d7m7zjvidr@suse.de>
 <20190111113652.GA30082@fuggles.cambridge.arm.com>
 <20190111120859.iqq7gju2ecrmi66t@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190111120859.iqq7gju2ecrmi66t@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, Qian Cai <cai@lca.pw>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 11, 2019 at 01:08:59PM +0100, Joerg Roedel wrote:
> Hi Will,
> 
> On Fri, Jan 11, 2019 at 11:36:52AM +0000, Will Deacon wrote:
> > I've already got this one in arm64 for-next/fixes (should be in linux-next
> > already). Would you prefer me to drop it (which would mean a rebase :()? I
> > was planning to send a pull later today, since I have some other fixes
> > queued as well.
> 
> Ah okay, didn't check linux-next, just linus/master. Keep it in your
> tree, I'll drop it from my branch. It is not pushed yet anywhere public,
> so it's easy for me to do.

Thanks Joerg, that keeps things simple! Should land in -rc2.

Will
