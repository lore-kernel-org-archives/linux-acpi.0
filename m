From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [RESEND] [PATCH 1/3] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Wed, 09 Sep 2009 18:22:00 +0100
Message-ID: <4AA7E438.4070905@tuffmail.co.uk>
References: <4A4A219C.2020802@tuffmail.co.uk> <1252339562.28499.13.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:12848 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZIIRWC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 13:22:02 -0400
Received: by ey-out-2122.google.com with SMTP id 25so1277324eya.19
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2009 10:22:04 -0700 (PDT)
In-Reply-To: <1252339562.28499.13.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

Maxim Levitsky wrote:
> Hi,
>
> So this is newer version of this patchset.
> When this will be merged?
>
>
> Last patch doesn't apply, seems that parts of yours patch were applied.
> I applied it manually.
>   
> Will soon test.
>
>
> Best regards,
> 	Maxim Levitsky
>   

I will submit "To: len" next time round.

You're right, it no longer applies cleanly to acpi-test.  ["patch" is
happy to apply it and warn about "fuzz", but git-am is more strict.  It
doesn't look like there's a real conflict.]

I look forward to your results.  Please tell me the diff you end up with
for the last patch and what tree you applied it on top of.  That way, if
I add "Tested-by: Maxim..." I can be certain we're talking about the
same patch :-).

Thanks!
Alan
