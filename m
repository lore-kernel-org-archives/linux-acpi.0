From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pnpacpi: incorrect test
Date: Tue, 30 Oct 2012 13:05:14 -0600
Message-ID: <CAErSpo7gX2v4Fo0eMY0d5m2ZLsy5r8b2CFbMxqbhsEo8x45M0Q@mail.gmail.com>
References: <20121029160455.14886.37788.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45045 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965393Ab2J3TFg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2012 15:05:36 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so398303wgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2012 12:05:35 -0700 (PDT)
In-Reply-To: <20121029160455.14886.37788.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org

On Mon, Oct 29, 2012 at 10:05 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> TEST_ALPHA() is broken and always returns 0
>
> Resolves-bug:  https://bugzilla.kernel.org/show_bug.cgi?id=45171
> ---
>
>  drivers/pnp/pnpacpi/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index 26b5d4b..107b6b6 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -58,7 +58,7 @@ static inline int __init is_exclusive_device(struct acpi_device *dev)
>         if (!(('0' <= (c) && (c) <= '9') || ('A' <= (c) && (c) <= 'F'))) \
>                 return 0
>  #define TEST_ALPHA(c) \
> -       if (!('@' <= (c) || (c) <= 'Z')) \
> +       if (!('@' <= (c) && (c) <= 'Z')) \

The original is definitely broken.

I think the corrected test allows PNP IDs containing '@', which
doesn't appear legal per sec 6.1.5 of the ACPI 5.0 spec.  Should this
be

+       if (!('A' <= (c) && (c) <= 'Z')) \

instead?

>                 return 0
>  static int __init ispnpidacpi(const char *id)
>  {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
