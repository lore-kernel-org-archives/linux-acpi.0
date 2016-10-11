From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: Add ARM64-specific ACPI maintainers entry
Date: Tue, 11 Oct 2016 23:52:59 +0200
Message-ID: <10118372.T2zXaxxCRu@vostro.rjw.lan>
References: <20161005112540.22189-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161005112540.22189-1-lorenzo.pieralisi@arm.com>
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
Cc: linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 05, 2016 12:25:40 PM Lorenzo Pieralisi wrote:
> The ARM64 architecture defines ARM64 specific ACPI bindings to
> configure and set-up arch specific components. To simplify
> code reviews/updates and streamline the maintainership structure
> supporting the arch specific code, a new arm64 directory was created in
> /drivers/acpi, to contain ACPI code that is specific to ARM64
> architecture.
> 
> Add the ARM64-specific ACPI maintainers entry in MAINTAINERS for
> the newly created subdirectory and respective code content.
> 
> Lorenzo Pieralisi will be in charge of submitting and managing
> the pull requests on behalf of all maintainers listed.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Link: http://lkml.kernel.org/r/1603704.EGiVTcCxLR@vostro.rjw.lan
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f593300..2a70dd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -316,6 +316,14 @@ W:	https://01.org/linux-acpi
>  S:	Supported
>  F:	drivers/acpi/fan.c
>  
> +ACPI FOR ARM64 (ACPI/arm64)
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Hanjun Guo <hanjun.guo@linaro.org>
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-acpi@vger.kernel.org
> +S:	Maintained
> +F:	drivers/acpi/arm64
> +
>  ACPI THERMAL DRIVER
>  M:	Zhang Rui <rui.zhang@intel.com>
>  L:	linux-acpi@vger.kernel.org
> 

Applied (with tags).

Thanks,
Rafael
