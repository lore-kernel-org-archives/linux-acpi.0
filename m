From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Add LAKML list to ACPI for ARM64 entry
Date: Mon, 14 Jan 2019 17:36:17 +0000
Message-ID: <20190114173617.GA26808@fuggles.cambridge.arm.com>
References: <20190111120419.10775-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190111120419.10775-1-lorenzo.pieralisi@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 11, 2019 at 12:04:19PM +0000, Lorenzo Pieralisi wrote:
> Patches for ACPI for ARM64 must be posted and reviewed on the Linux
> ARM kernel mailing list (in addition to linux-acpi@vger) since they
> affect (and are merged through) the ARM64 tree.
> 
> Make this explicit.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..442ec4db7342 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -365,6 +365,7 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  M:	Hanjun Guo <hanjun.guo@linaro.org>
>  M:	Sudeep Holla <sudeep.holla@arm.com>
>  L:	linux-acpi@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/acpi/arm64

Makes sense:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
