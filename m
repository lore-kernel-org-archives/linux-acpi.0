From: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] ACPI IORT updates for v4.17
Date: Fri, 9 Mar 2018 13:48:24 +0000
Message-ID: <20180309134823.GF15537@arm.com>
References: <20180308115425.GA31267@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180308115425.GA31267@e107981-ln.cambridge.arm.com>
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
Cc: catalin.marinas@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia He <jia.he@hxt-semitech.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 08, 2018 at 11:54:25AM +0000, Lorenzo Pieralisi wrote:
> Jia He (1):
>       ACPI/IORT: Remove linker section for IORT entries again
> 
> Lorenzo Pieralisi (2):
>       ACPI/IORT: Remove temporary iort_get_id_mapping_index() ACPICA guard
>       ACPI/IORT: Remove obsolete ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define
> 
>  drivers/acpi/arm64/iort.c         | 12 ------------
>  include/asm-generic/vmlinux.lds.h |  1 -
>  2 files changed, 13 deletions(-)

Nice diffstat! ;)

I'll pull this into for-next/core.

Will
