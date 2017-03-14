From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] ACPI / APEI: use setup_deferrable_timer
Date: Tue, 14 Mar 2017 12:06:48 -0600
Message-ID: <eaf4a45e-2f63-7e04-5022-26f702522da4@codeaurora.org>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Works for me!

On 3/10/2017 5:46 PM, Geliang Tang wrote:
> Use setup_deferrable_timer() instead of init_timer_deferrable() to
> simplify the code.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>   drivers/acpi/apei/ghes.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b192b42..33ca196 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1005,9 +1005,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>   
>   	switch (generic->notify.type) {
>   	case ACPI_HEST_NOTIFY_POLLED:
> -		ghes->timer.function = ghes_poll_func;
> -		ghes->timer.data = (unsigned long)ghes;
> -		init_timer_deferrable(&ghes->timer);
> +		setup_deferrable_timer(&ghes->timer, ghes_poll_func,
> +				       (unsigned long)ghes);
>   		ghes_add_timer(ghes);
>   		break;
>   	case ACPI_HEST_NOTIFY_EXTERNAL:

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
