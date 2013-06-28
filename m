From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: ghes: Remove redundant platform_set_drvdata()
Date: Fri, 28 Jun 2013 11:47:30 -0700
Message-ID: <CA+8MBbK2c1=egfx5Z7Oy6hQpuDU-YO2fFkyQqC1nL8Pz-LTs6Q@mail.gmail.com>
References: <1369827977-29975-1-git-send-email-sachin.kamat@linaro.org>
	<1557779.lOKEfHNnMB@vostro.rjw.lan>
	<CAK9yfHxdfjxwr8jgS6YUBC0gkQ_yKwO0eBJgFK+eGaWoOPCkPQ@mail.gmail.com>
	<2698240.JNzF6KSaOM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:35979 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3F1Srb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jun 2013 14:47:31 -0400
Received: by mail-vb0-f51.google.com with SMTP id x17so2015957vbf.24
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jun 2013 11:47:31 -0700 (PDT)
In-Reply-To: <2698240.JNzF6KSaOM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-acpi <linux-acpi@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

On Fri, Jun 28, 2013 at 3:44 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> This particular patch has to go through the Tony Luck's RAS tree as it
> modifies the APEI code.  I dropped it after we had a few patches in two trees
> by mistake.

I'll be happy to look at it ... but I do agree with Chen Gong's comment that
your commit message is missing some detail.  It would be nice to see a
call stack that shows where ghes_remove() is called ... pointing out where
we now write the NULL which is making this one redundant.  Since the callers
are via function pointers through the ghes_platform_driver structure, some
simple "grep" is insufficient to show where this function is called from.

Thanks

-Tony
