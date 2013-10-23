From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH 1/3] ACPI: Remove UART and KMI entries from DTS file
Date: Wed, 23 Oct 2013 19:28:59 +0800
Message-ID: <5267B2FB.9020807@linaro.org>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com> <1382402029-13381-2-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37147 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3JWL2v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 07:28:51 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so830438pab.24
        for <linux-acpi@vger.kernel.org>; Wed, 23 Oct 2013 04:28:51 -0700 (PDT)
In-Reply-To: <1382402029-13381-2-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: brandon.anderson@amd.com, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, graeme.gregory@linaro.org, Suravee.Suthikulpanit@amd.com

On 2013-10-22 8:33, brandon.anderson@amd.com wrote:
> From: Brandon Anderson <brandon.anderson@amd.com>
> 
> Remove DTS definition of UART and KMI so that ACPI definition in DSDT can take care of driver probing for these devices.
> 
> 
> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
> ---
>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +++++++---
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 ++++
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    4 ++++
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 

I think this patch should be the last one, because this patch will
stop the UART working and break the git bisect.

Thanks
Hanjun

