From: Bamvor Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH v12 0/7] Enable PMUs in ACPI systems
Date: Sat, 14 Jan 2017 17:00:48 +0800
Message-ID: <CAOijeYJO4uen3dRWn31b6Bare=5Xf8cHrfj=1EXe5mvAyCkcdg@mail.gmail.com>
References: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36170 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdANJAt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Jan 2017 04:00:49 -0500
Received: by mail-it0-f68.google.com with SMTP id o138so7416546ito.3
        for <linux-acpi@vger.kernel.org>; Sat, 14 Jan 2017 01:00:49 -0800 (PST)
In-Reply-To: <1484068672-15852-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com, hanjun.guo@linaro.org

On Wed, Jan 11, 2017 at 1:17 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.

Tests on D03 of huawei. Looks good to me.

Tested-by Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
