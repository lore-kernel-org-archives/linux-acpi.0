From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain mapping
Date: Wed, 18 Jan 2017 20:00:44 +0200
Message-ID: <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org> <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35633 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdARSAq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 13:00:46 -0500
In-Reply-To: <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, msalter@redhat.com, mlangsdo@redhat.com, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>, guohanjun@huawei.com, charles.garcia-tobin@arm.com

On Wed, Jan 18, 2017 at 6:46 PM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a ResourceSource to specify
> an alternate interrupt controller. Introduce acpi_irq_get and use it
> to implement ResourceSource/IRQ domain mapping.
>
> The new API is similar to of_irq_get and allows re-initialization
> of a platform resource from the ACPI extended IRQ resource, and
> provides proper behavior for probe deferral when the domain is not
> yet present when called.
>

Care to use -M -C when prepare this patch?

>  drivers/acpi/gsi.c      |  98 -----------------
>  drivers/acpi/irq.c      | 282 ++++++++++++++++++++++++++++++++++++++++++++++++

-- 
With Best Regards,
Andy Shevchenko
