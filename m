From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [PATCH 110/112] ACPI: update intrd DSDT override console messages
Date: Thu, 07 Feb 2008 12:06:01 +0100
Message-ID: <47AAE619.4070108@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:27286 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbYBGLGI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 06:06:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

(sorry for not keeping the message id, I'm not subscribed to linux-acpi)
> From: Len Brown <len.brown@intel.com>
> 
> also, address some checkpatch.pl violations
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/osl.c |   33 ++++++++++++++++++---------------
>  1 files changed, 18 insertions(+), 15 deletions(-)
:
>  
> -	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
> +	printk(KERN_INFO PREFIX "Checking initramfs for custom DSDT");
You need to also add a \n here. Otherwise in case of error it will look 
ugly ;-)

See you,
Eric
