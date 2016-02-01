From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH V2 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Mon,  1 Feb 2016 19:38:13 +0000
Message-ID: <1454355493-3242-1-git-send-email-alexey.klimov@arm.com>
References: <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51163 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbcBATiV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Feb 2016 14:38:21 -0500
In-Reply-To: <1453511240-20792-2-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ashwin.chaugule@linaro.org, pprakash@codeaurora.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi Prashanth and Ashwin,

On Sat, Jan 23, 2016 at 1:07 AM, Prashanth Prakash <pprakash@codeaurora.org> wrote:
> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>
> Previously the send_pcc_cmd() code checked if the
> PCC operation had completed before returning from
> the function. This check was performed regardless
> of the PCC op type (i.e. Read/Write). Knowing
> the type of cmd can be used to optimize the check
> and avoid needless waiting. e.g. with Write ops,
> the actual Writing is done before calling send_pcc_cmd().
> And the subsequent Writes will check if the channel is
> free at the entry of send_pcc_cmd() anyway.
>
> However, for Read cmds, we need to wait for the cmd
> completion bit to be flipped, since the actual Read
> ops follow after returning from the send_pcc_cmd(). So,
> only do the looping check at the end for Read ops.
>
> Also, instead of using udelay() calls, use ktime as a
> means to check for deadlines. The current deadline

udelay() is still there. Well, proposed approach in this patch is better than
current code but I will be much more happy to see approach without delay()s under
spin_lock if such approach exists.


> in which the Remote should flip the cmd completion bit
> is defined as N * Nominal latency. Where N is arbitrary
> and large enough to work on slow emulators and Nominal
> latency comes from the ACPI table (PCCT). This helps
> in working around the CONFIG_HZ effects on udelay()
> and also avoids needing different ACPI tables for Silicon
> and Emulation platforms.

What's the logic behind choosing N? Is it defined as 500 currently?
Can it be some kind of configurable module or boot parameter?
What if nominal latency given by firmware will be 100 mS?

Frankly speaking, I personally expect that slow emulator is going to fail
timing-sensitive activities and that's fine.
Your requirement to use same tables for emulator and hardware is understandable
too.


> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/acpi/cppc_acpi.c | 102 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 74 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6730f96..36c3e4d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -39,6 +39,7 @@
>
>  #include <linux/cpufreq.h>
>  #include <linux/delay.h>
> +#include <linux/ktime.h>
>
>  #include <acpi/cppc_acpi.h>
>  /*
> @@ -63,25 +64,56 @@ static struct mbox_chan *pcc_channel;
>  static void __iomem *pcc_comm_addr;
>  static u64 comm_base_addr;
>  static int pcc_subspace_idx = -1;
> -static u16 pcc_cmd_delay;
>  static bool pcc_channel_acquired;
> +static ktime_t deadline;
>
>  /*
>   * Arbitrary Retries in case the remote processor is slow to respond
> - * to PCC commands.
> + * to PCC commands. Keeping it high enough to cover emulators where
> + * the processors run painfully slow.
>   */
>  #define NUM_RETRIES 500
>
> +static int check_pcc_chan(void)
> +{
> +       int result = -EIO;
> +       struct acpi_pcct_shared_memory *generic_comm_base =
> +               (struct acpi_pcct_shared_memory *) pcc_comm_addr;
> +       ktime_t next_deadline = ktime_add(ktime_get(), deadline);
> +       int retries = 0;
> +
> +       /* Retry in case the remote processor was too slow to catch up. */
> +       while (!ktime_after(ktime_get(), next_deadline)) {
> +               if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
> +                       result = 0;
> +                       break;
> +               }
> +               /*
> +                * Reducing the bus traffic in case this loop takes longer than
> +                * a few retries.
> +                */
> +               udelay(3);
> +               retries++;

Looks like retries variable is not used properly. You just increment it and that's all.
Could you please check its usage or remove it?


> +       }
> +
> +       return result;
> +}
> +
>  static int send_pcc_cmd(u16 cmd)
>  {
> -       int retries, result = -EIO;
> -       struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
> +       int ret = -EIO;
>         struct acpi_pcct_shared_memory *generic_comm_base =
>                 (struct acpi_pcct_shared_memory *) pcc_comm_addr;
> -       u32 cmd_latency = pcct_ss->latency;
>
> -       /* Min time OS should wait before sending next command. */
> -       udelay(pcc_cmd_delay);
> +       /*
> +        * For CMD_WRITE we know for a fact the caller should have checked
> +        * the channel before writing to PCC space
> +        */
> +       if (cmd == CMD_READ) {
> +               ret = check_pcc_chan();
> +               if (ret)
> +                       return ret;
> +       }

For my eyes first pcc command to be called during booting is send_pcc_cmd(CMD_READ)
from cppc_get_perf_caps(). That means we go to the loop inside check_pcc_chan() and
to break that loop and successfully continue software expects bit PCC_CMD_COMPLETE to be
set.
I checked ACPI specs and didn't find any words about reset value of status register here.
If it's there could you please point me to it and place comment here? Or you shouldn't rely
on reset value of status reg (let's imagine that we rebooted kernel without informing firmware).
I actually hit this bug when I started to test your patches.


[snip]


Anyway, I tested your patches and ready to give reviewed-and-tested-by after resolving current issues
(and after re-testing). So, could you please keep me in c/c in next version?

Thanks,
Alexey.

