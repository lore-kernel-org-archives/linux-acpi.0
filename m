From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/5] ACPI: Atlas ACPI driver
Date: Thu, 13 Jul 2006 16:49:43 -0400
Message-ID: <d120d5000607131349x12f5ee15v2217980fe5ee00f3@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6F76C15@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:5174 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030379AbWGMUtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 16:49:45 -0400
Received: by ug-out-1314.google.com with SMTP id y2so491616uge
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jul 2006 13:49:44 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F76C15@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, jayakumar.acpi@gmail.com, "Yu, Luming" <luming.yu@intel.com>

On 7/13/06, Brown, Len <len.brown@intel.com> wrote:
> Jaya,
> Thanks for updating this patch.
>
> Note that this driver can not be accepted into the kernel without
> an entry being added to the MAINTAINERS file showing who is
> going to look after it.
>
> Preferably, that person should be inside Atlas, or have documentation
> or other connections or insight into the platform.  I can't maintain it
> because I don't have any of the above, and while this platform
> specific driver uses ACPI, it is not part of ACPI.
>
> Yes, I know that you were following the existing examples of
> platform-specific drivers in /drivers/acpi, but those examples
> need to change (and they are a little more complex than this one
> b/c they scribble in their own unique ways /proc/acpi...)
> But think sonypi, instead.
>

If you prefer I can stuff it in drivers/input/touchscreen/ .

-- 
Dmitry
