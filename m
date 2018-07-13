From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] ACPI: button: hide unused procfs helpers
Date: Fri, 13 Jul 2018 17:29:18 +0800
Message-ID: <ade2d23b-bfc9-b828-aa18-ff5e1c87a40d@huawei.com>
References: <20180713071959.11220-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713071959.11220-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

sorry for noise,there has a fix:

[PATCH] acpi/button.c: fix defined but not used warning
https://lkml.org/lkml/2018/7/11/231

On 2018/7/13 15:19, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/acpi/button.c:255:12: warning: ‘acpi_button_state_seq_show’ defined but not used [-Wunused-function]
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/acpi/button.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 2345a5e..8538e25 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -252,6 +252,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_device *device = seq->private;
> @@ -262,6 +263,7 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
>  		   state < 0 ? "unsupported" : (state ? "open" : "closed"));
>  	return 0;
>  }
> +#endif
>  
>  static int acpi_button_add_fs(struct acpi_device *device)
>  {
> 
