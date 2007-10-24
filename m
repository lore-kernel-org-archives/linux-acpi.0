From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6 patch] acpi/battery.c: remove dead code
Date: Wed, 24 Oct 2007 21:18:53 +0400
Message-ID: <471F7E7D.1080501@gmail.com>
References: <20071024162537.GA30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37644 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbXJXRTD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 13:19:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so361829ugc
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 10:19:01 -0700 (PDT)
In-Reply-To: <20071024162537.GA30533@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> After commit f1d4661abe05d0a2c014166042d15ed8b69ae8f2 this was dead 
> code.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked. Thanks.
> 
> ---
> --- linux-2.6/drivers/acpi/battery.c.old	2007-10-23 18:44:13.000000000 +0200
> +++ linux-2.6/drivers/acpi/battery.c	2007-10-23 18:44:43.000000000 +0200
> @@ -550,18 +550,14 @@ static ssize_t acpi_battery_write_alarm(
>  	int result = 0;
>  	char alarm_string[12] = { '\0' };
>  	struct seq_file *m = file->private_data;
>  	struct acpi_battery *battery = m->private;
>  
>  	if (!battery || (count > sizeof(alarm_string) - 1))
>  		return -EINVAL;
> -	if (result) {
> -		result = -ENODEV;
> -		goto end;
> -	}
>  	if (!acpi_battery_present(battery)) {
>  		result = -ENODEV;
>  		goto end;
>  	}
>  	if (copy_from_user(alarm_string, buffer, count)) {
>  		result = -EFAULT;
>  		goto end;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

