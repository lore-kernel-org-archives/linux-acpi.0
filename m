From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] acpi : remove pointless variable initialization
Date: Sat, 15 Sep 2012 22:56:42 +0200
Message-ID: <201209152256.42695.rjw@sisk.pl>
References: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org> <1347614736-9553-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:55889 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2IOUuT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Sep 2012 16:50:19 -0400
In-Reply-To: <1347614736-9553-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

On Friday, September 14, 2012, Daniel Lezcano wrote:
> The 'errata' variable is a global variable which is set to zero,
> no need to do that with a memset in the init function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied to the linux-next branch of the linux-pm.git tree as v3.7 material.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_driver.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 9c9288b..e78c2a5 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -905,8 +905,6 @@ static int __init acpi_processor_init(void)
>  	if (acpi_disabled)
>  		return 0;
>  
> -	memset(&errata, 0, sizeof(errata));
> -
>  	result = acpi_bus_register_driver(&acpi_processor_driver);
>  	if (result < 0)
>  		return result;
> 

