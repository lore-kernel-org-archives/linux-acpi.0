From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 3/3] Synchronize wireless power state with hardware for
 Sony laptops
Date: Sat, 19 Apr 2008 02:45:05 +0300
Message-ID: <48093281.8030405@gmail.com>
References: <1208558495-22792-1-git-send-email-ynvich@gmail.com> <1208558495-22792-2-git-send-email-ynvich@gmail.com> <1208558495-22792-3-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:40132 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbYDRXpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 19:45:24 -0400
Received: by ug-out-1314.google.com with SMTP id z38so182922ugc.16
        for <linux-acpi@vger.kernel.org>; Fri, 18 Apr 2008 16:45:22 -0700 (PDT)
In-Reply-To: <1208558495-22792-3-git-send-email-ynvich@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it

Sergey Yanovich wrote:
> The drivers stores own representation of wireless power states. Since
> hardware switch takes presedence over software controls, internal
> data goes out of sync with device state, after the hardware switch
> is toggled.
> 
> This patch safeguards itself against possible conflicts with earlier
> models, and will only have any effect on the latest Type 4 devices.
> ---


> @@ -1833,11 +1846,15 @@ static ssize_t sony_pic_wifipower_show(struct device *dev,
>  static void __sony_pic_set_bluetoothpower(u8 state)
>  {
>  	state = !!state;
> -	if (spic_dev.bluetooth_power == state)
> +	mutex_lock(&spic_dev.lock);

This is redundant and causing a deadlock :) Correction follows.


-- 
Sergey Yanovich
