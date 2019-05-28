Return-Path: <SRS0=amFs=T4=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52660C04AB6
	for <linux-acpi@archiver.kernel.org>; Tue, 28 May 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23539208C3
	for <linux-acpi@archiver.kernel.org>; Tue, 28 May 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udG6T27C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfE1IeO (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 28 May 2019 04:34:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfE1IeO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 04:34:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so6006782lfe.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQlVBElgqXAsDEjOxVj9oK5E1X6lwcA+b9Oa3dAIje4=;
        b=udG6T27C4vdJ8zRIZhbkTWMPAJ+dtGnvQtSiuSdnq2ColNYCkE2PvnvMty+raYMKkH
         79zqDkoEkMJF9R85zm4zDZKeR1iEwuZ1Rt2B+7EaLfrK3bS9lgX4yE9ilGZce6u7iY/f
         /5zfPG8/NTnl9Di/S0ey7teztK73hy3mpScooR4aD5NS/9bOjXHjJ/SiVz9wVGIwqGft
         i20oZVz4vT8ysrW4zdU3vX6l2KiyA4aHJQ4nuM69GH4ko2LsN8KqUlm77NE5fw8/4HDt
         VMP57lwYrL2WWQqTCihljvptTWeMX9JPy/pgr/gUXnIqU/UewvjvBC6Pf0LBre7pVqZM
         xgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQlVBElgqXAsDEjOxVj9oK5E1X6lwcA+b9Oa3dAIje4=;
        b=pQpKvo3YSgV+9vHKyKynHr9dFjJ29gRGij34SOu5oT31Z5CzrdBdnKz5Q/zEk6EVRV
         ItL9+iw/uRfKfQtbMRQMuGiJKNkFheTvSN3QMoKqJn+csw114w1aAaBdEgK2XH5dji/I
         TyKJ+27f3p1/j3+MrbDBKl59N0XgzF9akwNlZxARaNO0tniSqgDho2fIv4su3uwdGUSi
         SYdWOm3GQnrOk0M94HUJ89A0x7yGqepVbYn4H3DBsDYoTBsPzYCnydh0mc+eYiWZkQ4o
         gqoQ+A1EjBPYD4gan8VIJCN054Hq+VpNaExbwM/na//dOeH8xFiwPL8qvhp2wNIeIEG6
         Gk0w==
X-Gm-Message-State: APjAAAX2Q1Ylc8Cqu8nkzbIhCT0DqjoZjx9rRF3u6m4RS/wUZd0hJWu4
        1g3IrSU7hrl65eBTl6R0ZcffS1dvslmRw8g+QGzW0w==
X-Google-Smtp-Source: APXvYqxEgjRjWENBkz7z95vx7w4Cpgl0m4NZZB0qQ+U9+mLZUVcLXmiPEJ9MA2A3h94RRT/FZGoGmDskw0N5eZFtLck=
X-Received: by 2002:ac2:48a8:: with SMTP id u8mr11205394lfg.141.1559032452849;
 Tue, 28 May 2019 01:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org> <20190527112720.2266-5-ard.biesheuvel@linaro.org>
In-Reply-To: <20190527112720.2266-5-ard.biesheuvel@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 10:34:01 +0200
Message-ID: <CACRpkdZt-AosWLPcwDQqi_2i4adDk-ioT3g3aTicyXiZpQOGGg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] gpio: mb86s7x: enable ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 27, 2019 at 1:27 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> support for ACPI GPIO interrupts routed via platform interrupts, by
> wiring the two together via the to_irq() gpiochip callback.
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume you want to merge this through the IRQ tree or the ACPI
tree, so go ahead.

If you want me to queue the whole thing in the GPIO tree just tell
me (once we have the ACKs in place).

Yours,
Linus Walleij
