From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi:correctly check failed allocation
Date: Wed, 28 Oct 2015 04:15:40 +0100
Message-ID: <14755743.x0IPL3PNjt@vostro.rjw.lan>
References: <1444925970-28676-1-git-send-email-wuninsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47518 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754305AbbJ1Cqn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 22:46:43 -0400
In-Reply-To: <1444925970-28676-1-git-send-email-wuninsu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Insu Yun <wuninsu@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu

On Thursday, October 15, 2015 12:19:30 PM Insu Yun wrote:
> Since kobject_create_and_add can be failed in memory pressure,
> return value need to be checked and return ENOMEM.
> 
> Signed-off-by: Insu Yun <wuninsu@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 40a4265..e712a7b 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -878,6 +878,8 @@ int __init acpi_sysfs_init(void)
>  		return result;
>  
>  	hotplug_kobj = kobject_create_and_add("hotplug", acpi_kobj);
> +  if (!hotplug_kobj)
> +    return -ENOMEM;
>  	result = sysfs_create_file(hotplug_kobj, &force_remove_attr.attr);
>  	if (result)
>  		return result;
> 

Applied (with whitespace fixed), thanks!

Rafael

