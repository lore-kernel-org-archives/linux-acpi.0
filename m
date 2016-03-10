From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: remove unused device_decode
Date: Fri, 11 Mar 2016 00:34:37 +0100
Message-ID: <2515416.Thqv36oC92@vostro.rjw.lan>
References: <1455576004-11839-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64852 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932995AbcCJXcn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:32:43 -0500
In-Reply-To: <1455576004-11839-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, February 15, 2016 10:40:04 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> device_decode is now no longer used, so we may as well remove it.
> Fixes gcc 6 warning:
>=20
> drivers/acpi/acpi_video.c:221:19: warning: =E2=80=98device_decode=E2=80=
=99 defined
>  but not used [-Wunused-const-variable]
>  static const char device_decode[][30] =3D {
>                    ^~~~~~~~~~~~~
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
