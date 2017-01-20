From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V11 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Fri, 20 Jan 2017 04:02:46 +0100
Message-ID: <CAJZ5v0i_wcnF3xM5_imEGdKW91ggUfCWCcjP-WNK-oMvO-KXMQ@mail.gmail.com>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36778 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdATDCs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2017 22:02:48 -0500
In-Reply-To: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme

On Fri, Jan 20, 2017 at 3:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> The first patch prevents the ACPI core from attempting to map IRQ resources
> with a valid ResourceSource as GSIs.
>
> The second patch adds support for ResourceSource/IRQ domain mapping and
> fixes IRQ probe deferral by allowing platform_device IRQ resources to be
> re-initialized from the corresponding ACPI IRQ resource.
>
> Both changes described above are conditional on the ACPI_GENERIC_GSI config.
>
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
>
> Tested on top of v4.10-rc4.
>
> Changes V10 -> V11:
> * Add probe table and use it to implement driver presence detection.
> * Fix kernel doc formatting in drivers/acpi/irq.c and some minor style issues.
> * Minor bug fixes in the driver.

I'm travelling now
(http://marc.info/?l=linux-pm&m=148410629024194&w=2), but I'll get
to this when I'm back.

Thanks,
Rafael
