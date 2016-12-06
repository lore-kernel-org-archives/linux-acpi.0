From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 7/7] arm: pmu: Add PMU definitions for cores not
 initially online
Date: Tue, 6 Dec 2016 15:21:18 +0000
Message-ID: <20161206152118.GK2498@arm.com>
References: <1480704961-6910-1-git-send-email-jeremy.linton@arm.com>
 <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1480704961-6910-8-git-send-email-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 02, 2016 at 12:56:01PM -0600, Jeremy Linton wrote:
> ACPI CPUs aren't associated with a PMU until they have been put
> online. This means that we potentially have to update a PMU
> definition the first time a CPU is hot added to the machine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 38 ++++++++++++++++++++++++++++++++++++--
>  include/linux/perf/arm_pmu.h |  4 ++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index fa40294..4abb2fe 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -711,6 +711,30 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
>  	return 0;
>  }
>  
> +static DEFINE_SPINLOCK(arm_pmu_resource_lock);

Why do you need this spinlock? The hotplug notifiers are serialised afaik,
and you don't take it anywhere else.

Will
