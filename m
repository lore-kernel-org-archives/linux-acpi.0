From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 1/5] ACPI: Atlas ACPI driver
Date: Fri, 14 Jul 2006 08:24:26 +0800
Message-ID: <756b48450607131724w236d8e0bka47fbfc3743305fa@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB6F76C15@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52173 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161153AbWGNAY1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 20:24:27 -0400
Received: by ug-out-1314.google.com with SMTP id u40so560619ugc
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jul 2006 17:24:26 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F76C15@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor_core@ameritech.net, "Yu, Luming" <luming.yu@intel.com>

On 7/14/06, Brown, Len <len.brown@intel.com> wrote:
> Note that this driver can not be accepted into the kernel without
> an entry being added to the MAINTAINERS file showing who is
> going to look after it.

Ok. I'll add a maintainers entry for myself.

> Yes, I know that you were following the existing examples of
> platform-specific drivers in /drivers/acpi, but those examples
> need to change (and they are a little more complex than this one
> b/c they scribble in their own unique ways /proc/acpi...)
> But think sonypi, instead.

Ok. Will do. I'll move it to drivers/input/touchscreen/ as per
Dmitry's suggestion.

> So when this does make it upstream, it will have to live outside
> the /drivers/acpi/ directory, and acpi should not be part of
> the driver name.  It should build depending on CONFIG_ACPI,
> and should load depending on acpi_disabled, and should use
> ACPI routines that are exported by the ACPI sub-system (it does,
> though the headers are so incestuous at this point that it isn't
> enforced)

Ok. Will do.

>
> thanks,
> -Len
>
> ps.
> I believe that you want to delete the reference below to
> /proc/acpi/event, yes?

Yes, I did. That one was posted here:

http://marc.theaimsgroup.com/?l=linux-acpi&m=115233799829220&w=2

Thanks,
jaya
