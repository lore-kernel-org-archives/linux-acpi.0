From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Thu, 12 Jun 2014 12:52:24 -0400
Message-ID: <CAJ5Y-ea6teac4xksRTxrt5bxEHpUXumgypD5PJwnn39oYxN4Fg@mail.gmail.com>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
	<1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:63430 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbaFLQw3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 12:52:29 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so6027088wib.6
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2014 09:52:25 -0700 (PDT)
In-Reply-To: <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Mark Brown <broonie@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rjw@rjwysocki.net, Patch Tracking <patches@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Jassi,

On 12 June 2014 12:48, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> The current mailbox framework only supports DT based bindings.
> Add another mechanism for mailbox clients to register with mailbox
> controllers and request for specific mailbox channels. This enables
> usage of the mailbox framework on kernels with ACPI support.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/mailbox.c          | 155 ++++++++++++++++++++++++-------------
>  include/linux/mailbox_client.h     |   3 +
>  include/linux/mailbox_controller.h |   6 ++
>  3 files changed, 112 insertions(+), 52 deletions(-)
>

Can you please try this change on your platform(s) with DT support?

Cheers,
Ashwin
