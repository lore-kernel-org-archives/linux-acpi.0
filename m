From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] acpi/arm64: pr_err() strings should end with newlines
Date: Tue, 10 Oct 2017 17:33:50 +0800
Message-ID: <59DC93FE.2060004@huawei.com>
References: <d81bee42b06beefa9a7149b5b35bf884836c2595.1506321825.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d81bee42b06beefa9a7149b5b35bf884836c2595.1506321825.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2017/9/25 15:24, Arvind Yadav wrote:
> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Add changelog.
>
>  drivers/acpi/arm64/gtdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index 597a737..92f9edf 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -199,7 +199,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
>  	struct acpi_gtdt_timer_entry *gtdt_frame;
>  
>  	if (!block->timer_count) {
> -		pr_err(FW_BUG "GT block present, but frame count is zero.");
> +		pr_err(FW_BUG "GT block present, but frame count is zero.\n");
>  		return -ENODEV;
>  	}
>  

Make sense to me,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Lorenzo, could you pick this up for 4.15?

Thanks
Hanjun
