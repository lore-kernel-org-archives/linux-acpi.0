From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] ACPI / CPPC: Add a helper to get desired performance
Date: Thu, 14 Feb 2019 11:42:49 +0100
Message-ID: <CAJZ5v0husvV--mD_8B9cXx6-rD1677s6zT6tcjwk3Dg-dNPAxw@mail.gmail.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com> <1550130368-60513-2-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550130368-60513-2-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, gcherianv@gmail.com, Prashanth Prakash <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>, Robert Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> This patch add a helper to get the value of desired performance
> register.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  1 +
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 217a782..93588c5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1051,6 +1051,44 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  }
>
>  /**
> + * cppc_get_desired_perf - Get the value of desired performance register.
> + * @cpunum: CPU from which to get desired performance.
> + * @desired_perf: address of a variable to store the returned desired performance
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
> +{
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +       struct cpc_register_resource *desired_reg;
> +       struct cppc_pcc_data *pcc_ss_data = NULL;
> +       int regs_in_pcc = 0;

It would be better to use bool here, but it would be even better to
not try to avoid calling cpc_read() in two branches.

> +
> +       desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +
> +       if (CPC_IN_PCC(desired_reg)) {

    int ret = 0;

> +               if (pcc_ss_id < 0)
> +                       return -EIO;
> +               pcc_ss_data = pcc_data[pcc_ss_id];
> +               down_write(&pcc_ss_data->pcc_lock);

    if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
            cpc_read(cpunum, desired_reg, desired_perf);
    else
            ret = -EIO;

    up_write(&pcc_ss_data->pcc_lock);
    return ret;

> +               regs_in_pcc = 1;
> +               if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
> +                       up_write(&pcc_ss_data->pcc_lock);
> +                       return -EIO;
> +               }
> +       }

cpc_read(cpunum, desired_reg, desired_perf);
return 0;

> +
> +       cpc_read(cpunum, desired_reg, desired_perf);
> +
> +       if (regs_in_pcc)
> +               up_write(&pcc_ss_data->pcc_lock);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> +
> +/**
>   * cppc_get_perf_caps - Get a CPUs performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
>   * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
