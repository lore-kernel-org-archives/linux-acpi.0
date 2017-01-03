From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 3 Jan 2017 22:56:40 +0100
Message-ID: <CAJZ5v0h_v-iER5Fffdoczj4CAhetGYqOfJOhdO561_kNCnsEFg@mail.gmail.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org> <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32851 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936200AbdACV4l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jan 2017 16:56:41 -0500
In-Reply-To: <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun

On Tue, Jan 3, 2017 at 4:19 PM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> Hi,
>
> Is there any more feedback on this beyond Lorenzo's suggestion to drop
> the conditional check on the first patch?
> How can we move forward on this series?

Essentially, I need to convince myself that patches [1-2/3] are fine
which hasn't happened yet.

Thanks,
Rafael
