From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 14 Apr 2016 11:49:11 -0700
Message-ID: <CAOesGMiqpm1TjiOpCv+kYp60FrhRhs3Leomv5KyySk8k15YFNw@mail.gmail.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
	<20160412172315.GH8066@e104818-lin.cambridge.arm.com>
	<CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
	<20160414182520.GA8663@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36363 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcDNStM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2016 14:49:12 -0400
Received: by mail-io0-f175.google.com with SMTP id u185so112870877iod.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 Apr 2016 11:49:12 -0700 (PDT)
In-Reply-To: <20160414182520.GA8663@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Apr 14, 2016 at 11:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 14, 2016 at 11:02:15AM -0700, Olof Johansson wrote:
>
>> Switch the default from y to n on ARM64 (or default !ARM64) and I'll
>> be happy to ack it.
>
>> Mostly because it doesn't make sense for people building their own
>> configs for embedded systems to get it turned on by default. Anyone
>> running on a server is likely to clone an existing distro config in
>> the first place.
>
> I can send a followup patch for that (I actually already wrote that
> after the discussion with Will), but I do think we should enable it in
> defconfig for the testing.

That sounds good.

So, to clarify: a follow-up patch (to arm@kernel.org) to turn on ACPI
in arm64 defconfig, and a respin of this patch to change the default.


-Olof
