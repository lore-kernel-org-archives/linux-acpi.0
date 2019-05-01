From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH next 01/25] ACPI / DPTF: Use dev_get_drvdata()
Date: Wed, 01 May 2019 12:13:13 +0200
Message-ID: <1630516.6fPAFj0BIz@kreacher>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com> <20190423075020.173734-2-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423075020.173734-2-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, April 23, 2019 9:49:56 AM CEST Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/dptf/dptf_power.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index e1c242568341..0c081390930a 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -31,8 +31,7 @@ static ssize_t name##_show(struct device *dev,\
>  			   struct device_attribute *attr,\
>  			   char *buf)\
>  {\
> -	struct platform_device *pdev = to_platform_device(dev);\
> -	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);\
> +	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
>  	unsigned long long val;\
>  	acpi_status status;\
>  \
> 

Applied, thanks!
