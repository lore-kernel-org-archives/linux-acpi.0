From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Wed, 30 Mar 2016 19:02:37 +0100
Message-ID: <CAGCh1+mRC0i3aqujzhPQY3gW5McECEJCGxas8+d+uVVPiTo23A@mail.gmail.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33146 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbcC3SCy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2016 14:02:54 -0400
Received: by mail-io0-f173.google.com with SMTP id a129so76743239ioe.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Mar 2016 11:02:54 -0700 (PDT)
In-Reply-To: <1459360718-24125-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 30 March 2016 at 18:58, Mark Brown <broonie@kernel.org> wrote:
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

I agree,

Acked-by: Graeme Gregory <graeme.gregory@linaro.org>

Thanks

G

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..bf5dc1ac3446 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,7 +5,7 @@
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on !IA64_HP_SIM
> -       depends on IA64 || X86 || (ARM64 && EXPERT)
> +       depends on IA64 || X86 || ARM64
>         depends on PCI
>         select PNP
>         default y
> --
> 2.8.0.rc3
>
