From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ, limit the range of einj_param
Date: Thu, 15 Mar 2012 16:54:24 +0800
Message-ID: <4F61AE40.1020908@linux.intel.com>
References: <4F506E8A.8010901@linux.intel.com> <1330747003-11891-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14315 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760734Ab2COIy3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2012 04:54:29 -0400
In-Reply-To: <1330747003-11891-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On 3/3/2012 11:56 AM, Chen Gong wrote:
> On the platforms with ACPI4.x support, parameter extension
> is not always doable, which means only parameter extension
> is enabled, einj_param can take effect.
>
> v2->v1: stopping early in einj_get_parameter_address for einj_param
>
> Signed-off-by: Chen Gong<gong.chen@linux.intel.com>
> ---
>   drivers/acpi/apei/einj.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 4ca087d..3d3816f 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
>   			return v5param;
>   		}
>   	}
> -	if (paddrv4) {
> +	if (param_extension&&  paddrv4) {
>   		struct einj_parameter *v4param;
>
>   		v4param = acpi_os_map_memory(paddrv4, sizeof(*v4param));

Hi, Len

Any comment for this?
