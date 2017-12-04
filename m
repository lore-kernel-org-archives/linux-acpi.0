From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5 2/7] ACPI / bus: Introduce acpi_get_match_data() function
Date: Mon, 4 Dec 2017 22:59:07 +0100
Message-ID: <CAJZ5v0gCkY80+A=cZKzhKhxKObSgqN3k1JGgGQgW5cwRSvqt_Q@mail.gmail.com>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org> <1512188864-773-3-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40346 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbdLDV7I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 16:59:08 -0500
In-Reply-To: <1512188864-773-3-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sat, Dec 2, 2017 at 5:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> OF has of_device_get_match_data() function to extract driver specific data
> structure. Add a similar function for ACPI.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Haven't I ACKed this already?

Anyway, please resend the whole series with a CC to linux-acpi.

Thanks,
Rafael
