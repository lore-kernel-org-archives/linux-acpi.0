From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for ARMv8
Date: Fri, 8 Jan 2016 16:30:48 -0800
Message-ID: <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34106 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbcAIAay (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2016 19:30:54 -0500
Received: by mail-lf0-f42.google.com with SMTP id d17so19626519lfb.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jan 2016 16:30:53 -0800 (PST)
In-Reply-To: <1446857519-5908-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, Jon Masters <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>, Loc Ho <lho@apm.com>

Hi Borislav/Doung/etc,

> v3
> * Change the title of the patch to reflect the patch
> * Completely dropped the driver. Instead, move completely to the FW by
>   accessing the GIC directly.
> * Fix a bug with function acpi_gsi_to_irq
> * Enable APEI multiple GHES source to share an single external IRQ
>
> v2
> * Make all code more generic naming
> * Still waiting for comment from Linaro folks on APEI
>
> ---
> Loc Ho (2):
>   acpi: Fix proper return code for function acpi_gsi_to_irq
>   acpi: apei: Enable APEI multiple GHES source to share an single
>     external IRQ

It has been awhile and I thought I check again on this. Any issue with
these two changes as it is needed for ARMv8 64-bit APEI support.
Without these two changes, APEI support will NOT work with X-Gene
platforms.

-Loc
