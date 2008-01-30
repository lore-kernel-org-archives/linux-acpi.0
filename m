From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: an error an bug
Date: Wed, 30 Jan 2008 11:33:51 +0300
Message-ID: <47A0366F.9030705@gmail.com>
References: <0JVF00AOLT076N@szxml04-in.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:30823 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbYA3Iee (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2008 03:34:34 -0500
Received: by fg-out-1718.google.com with SMTP id e21so155043fga.17
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jan 2008 00:34:33 -0800 (PST)
In-Reply-To: <0JVF00AOLT076N@szxml04-in.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: xuqiang <likes@huawei.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>

Hi Likes,

What kernel are you using?
Please open bug in bugzilla.kernel.org for ACPI and provide all needed 
information, including dmesg (from the beginning) and acpidump.

xuqiang wrote:
> hi,all:
>    an error happened. in an hour, more than 30 million lines were repeated and writed to /var/log/messages and /var/log/warn.
> Jan  1 05:08:06 bond0 kernel:     ACPI-0347: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY
> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed [\_SB_.RDPE] (Node cdf7aec0), AE_NO_MEMORY
> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed [\_SB_.RPME] (Node cdf7ae20), AE_NO_MEMORY
> Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method execution failed [\_GPE._L18] (Node cdf7ad80), AE_NO_MEMORY
> Jan  1 05:08:06 bond0 kernel:     ACPI-0295: *** Error: AE_NO_MEMORY while evaluating method [_L18] for GPE[ 0]
> ]
>  where can I get enough information to understand the error or who can tell me  what the method means?		
>
> likes
> likes@huawei.com
> 2008-01-30
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

