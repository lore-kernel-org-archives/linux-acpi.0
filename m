From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Documentation / ACPI: Fix location of GPIO documentation
Date: Fri, 23 May 2014 14:40:14 +0200
Message-ID: <CACRpkdZ60ZyX751BZgU+c_RSQ67TEEyhGp0GySP5r=NS22GjGA@mail.gmail.com>
References: <1400680705-11078-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62462 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbaEWMkP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 May 2014 08:40:15 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so5261633obc.21
        for <linux-acpi@vger.kernel.org>; Fri, 23 May 2014 05:40:14 -0700 (PDT)
In-Reply-To: <1400680705-11078-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, May 21, 2014 at 3:58 PM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:

> Commit fd8e198cfcaa ("Documentation: gpiolib: document new interface")
> moved Documentation/gpio.txt to Documentation/gpio/gpio-legacy.txt and added
> new documents for descriptor-based interface so fix the the location here to
> point Documentation/gpio/ since that what commit ccb6fbb99020
> ("Documentation / ACPI: update to GPIO descriptor API") was looking for.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Patch applied w/Mika's ACK.

Yours,
Linus Walleij
