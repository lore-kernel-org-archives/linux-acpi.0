From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
Date: Fri, 15 Apr 2016 10:48:11 -0700
Message-ID: <CAOesGMj5h9VtB+vArUEB4PzQavAgkUg0q19XL7ZVrVKNcwty9g@mail.gmail.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35759 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcDORsM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 13:48:12 -0400
Received: by mail-io0-f180.google.com with SMTP id g185so141855128ioa.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Apr 2016 10:48:12 -0700 (PDT)
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arm@kernel.org" <arm@kernel.org>

On Fri, Apr 15, 2016 at 12:53 AM, Mark Brown <broonie@kernel.org> wrote:
> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Olof Johansson <olof@lixom.net>
