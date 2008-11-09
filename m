From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: need help with buggy dsdt
Date: Mon, 10 Nov 2008 01:27:41 +0300
Message-ID: <491763DD.5050103@gmail.com>
References: <49175B25.6050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:65035 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbYKIW1p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 17:27:45 -0500
Received: by ug-out-1314.google.com with SMTP id 39so244634ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2008 14:27:44 -0800 (PST)
In-Reply-To: <49175B25.6050306@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "M. I. Veken" <miveken@gmail.com>
Cc: linux-acpi@vger.kernel.org

M. I. Veken wrote:
> i need help with my (buggy) dsdt:
>
> i get these errors when trying to recompile (iasl -tc dsdt.dsl):
> http://paste.ubuntu.com/69766/
>
it does not like your external referencies. remove them and you are down 
to 16 errors.
proper externals could be acquired from SSDTs nearby...
> here is my dsdt.dsl:
> http://paste.ubuntu.com/69765
>
> thank you in advance for the help
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

