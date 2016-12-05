From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 10:51:28 -0800
Message-ID: <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35270 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbcLESv7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Dec 2016 13:51:59 -0500
Received: by mail-ua0-f172.google.com with SMTP id 12so358033585uas.2
        for <linux-acpi@vger.kernel.org>; Mon, 05 Dec 2016 10:51:59 -0800 (PST)
In-Reply-To: <20161205130534.11080-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>

On Mon, Dec 5, 2016 at 5:05 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> Check the 'Register Bit Width' field of the ACPI Generic Address
> Structure that specifies the address of the UART registers to
> decide if the driver should use "mmio32" access instead of "mmio".
>
> If the driver is other than 16550 the access with is defined
> by the Interface Type field of the SPCR table.
>
> For discussion:
>
> https://lkml.kernel.org/r/7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com

Tested on X-Gene 1 and X-Gene 2 platforms.

Tested-by: Duc Dang <dhdang@apm.com>
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Reported-by: Heyi Guo <heyi.guo@linaro.org>
> ---
>  drivers/acpi/spcr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index e8d7bc7..6c6710b 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -70,6 +70,10 @@ int __init parse_spcr(bool earlycon)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +               if (table->serial_port.space_id ==
> +                       ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> +                   table->serial_port.bit_width == 32)
> +                       iotype = "mmio32";
>                 uart = "uart";
>                 break;
>         default:
> --
> 2.10.2
>
Thanks,
Duc Dang.
