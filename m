From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Re: need help with buggy dsdt
Date: Mon, 10 Nov 2008 12:01:36 +0000
Message-ID: <200811101201.36488.duartejcsilva@gmail.com>
References: <491813CF.3070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:36744 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYKJL4v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 06:56:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2268790fgg.17
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2008 03:56:49 -0800 (PST)
In-Reply-To: <491813CF.3070603@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

It means that you have unresolved externals in the DSDT. Something like this 
External (^CPU0._PPC) should be removed.
I had that problem on my DSDT too. But take care that if the same error doesnt 
occur during the initialization of the kernel (something like AE_NOT_FOUND 
Failure from lookup %s should be present in the kernel log) you shouldnt 
remove it ->> I guess <<-.

On Monday 10 November 2008 10:58:23 M. I. Veken wrote:
> i need help with my (buggy) dsdt:
>
> i get these errors when trying to recompile (iasl -tc dsdt.dsl):
> paste.ubuntu.com/69766/
>
> here is my dsdt.dsl:
> paste.ubuntu.com/69765/
>
> thank you in advance for the help
>
> PS sry for the links but i don't know how to manage that..
>
> > it does not like your external referencies. remove them and you are down
> > to 16 errors. proper externals could be acquired from SSDTs nearby...
>
> i don't understand that sry, could you explain please? why doesn't it like
> my links? what's that "down to 16 errors" about? what are SSDTs?
> sry for my noobishness:|
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

