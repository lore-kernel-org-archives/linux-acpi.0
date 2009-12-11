From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RESEND] [PATCH 1/3] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Fri, 11 Dec 2009 10:50:29 +0000
Message-ID: <9b2b86520912110250r7b5bb77bwd654696eff8e9d4f@mail.gmail.com>
References: <4A4A219C.2020802@tuffmail.co.uk>
	 <1252339562.28499.13.camel@maxim-laptop>
	 <4AA7E438.4070905@tuffmail.co.uk>
	 <1252531271.4174.5.camel@maxim-laptop>
	 <9b2b86520909100411o6dc850a5mc80792285411aff3@mail.gmail.com>
	 <alpine.LFD.2.00.0912092349030.24891@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43758 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbZLKKuY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 05:50:24 -0500
Received: by bwz27 with SMTP id 27so500601bwz.21
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2009 02:50:29 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0912092349030.24891@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

On 12/10/09, Len Brown <lenb@kernel.org> wrote:
>>
>> $ git fetch alan.bundle battery-check:battery-check
>> $ git checkout battery-check
>>
>> so long as you have the acpi-test commit I based it on.
>
> apparently I don't.  Can you re-send this as a plain patch?
>
> thanks,
> -Len

Sure.  I'll resend the first two patches in this series (the patch 3/3
was wrong and should not be applied).

Thanks
Alan
