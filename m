From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Fix section to __init. Align with usage in acpixf.h . Fixes warning during compilation with clang.
Date: Thu, 02 May 2013 23:16:02 +0200
Message-ID: <27929805.ykWc87giNE@vostro.rjw.lan>
References: <1367314744-9659-1-git-send-email-dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55559 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab3EBVHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 May 2013 17:07:45 -0400
In-Reply-To: <1367314744-9659-1-git-send-email-dl9pf@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dl9pf@gmx.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

On Tuesday, April 30, 2013 11:39:04 AM dl9pf@gmx.de wrote:
> From: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
>=20
> Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>

I've queued this up for the v3.10-rc2 push.

Thanks,
Rafael


> ---
>  include/acpi/acpiosxf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 5b3d2bd..64b8c76 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -77,7 +77,7 @@ struct acpi_signal_fatal_info {
>  /*
>   * OSL Initialization and shutdown primitives
>   */
> -acpi_status __initdata acpi_os_initialize(void);
> +acpi_status __init acpi_os_initialize(void);
> =20
>  acpi_status acpi_os_terminate(void);
> =20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
