From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Fri, 15 Apr 2016 10:48:50 -0700
Message-ID: <CAOesGMg5E4bcwQgt4+9JkLwmcZ_sj9sCE8ya50MEDQiizN-YUg@mail.gmail.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
	<1460706823-16566-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35402 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbcDORsv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 13:48:51 -0400
Received: by mail-ig0-f182.google.com with SMTP id gy3so25836083igb.0
        for <linux-acpi@vger.kernel.org>; Fri, 15 Apr 2016 10:48:50 -0700 (PDT)
In-Reply-To: <1460706823-16566-2-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arm@kernel.org" <arm@kernel.org>

On Fri, Apr 15, 2016 at 12:53 AM, Mark Brown <broonie@kernel.org> wrote:
> When ACPI was originally merged for arm64 it had only been tested on
> emulators and not on real physical platforms and no platforms were
> relying on it.  This meant that there were concerns that there might be
> serious issues attempting to use it on practical systems so it had a
> dependency on EXPERT added to warn people that it was in an early stage
> of development with very little practical testing.  Since then things
> have moved on a bit.  We have seen people testing on real hardware and
> now have people starting to produce some platforms (the most prominent
> being the 96boards Cello) which only have ACPI support and which build
> and run to some useful extent with mainline.
>
> This is not to say that ACPI support or support for these systems is
> completely done, there are still areas being worked on such as PCI, but
> at this point it seems that we can be reasonably sure that ACPI will be
> viable for use on ARM64 and that the already merged support works for
> the cases it handles.  For the AMD Seattle based platforms support
> outside of PCI has been fairly complete in mainline a few releases now.
>
> This is also not to say that we don't have vendors working with ACPI who
> are trying do things that we would not consider optimal but it does not
> appear that the EXPERT dependency is having a substantial impact on
> these vendors.
>
> Given all this it seems that at this point the EXPERT dependency mainly
> creates inconvenience for users with systems that are doing the right
> thing and gets in the way of including the ACPI code in the testing that
> people are doing on mainline.  Removing it should help our ongoing
> testing cover those platforms with only ACPI support and help ensure
> that when ACPI code is merged any problems it causes for other users are
> more easily discovered.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Acked-by: Graeme Gregory <graeme.gregory@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Al Stone <ahs3@redhat.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
