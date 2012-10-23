From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI video: Ignore errors after _DOD evaluation.
Date: Tue, 23 Oct 2012 18:40:12 +0800
Message-ID: <1350988812.1859.3.camel@rui.sh.intel.com>
References: <1350088885-13918-1-git-send-email-e-mail@date.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6074 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab2JWKhK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Oct 2012 06:37:10 -0400
In-Reply-To: <1350088885-13918-1-git-send-email-e-mail@date.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Igor Murzov <e-mail@date.by>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Stefan Wilkens <stefanwilkens@gmail.com>, Sergey V <sftp.mtuci@gmail.com>, linux-kernel@vger.kernel.org

On =E5=85=AD, 2012-10-13 at 04:41 +0400, Igor Murzov wrote:
> There are systems where video module known to work fine regardless
> of broken _DOD and ignoring returned value here doesn't cause
> any issues later. This should fix brightness controls on some laptops=
=2E
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D47861
>=20
> Signed-off-by: Igor Murzov <e-mail@date.by>
> Reviewed-by: Sergey V <sftp.mtuci@gmail.com>

applied to my next branch.

thanks,
rui
> ---
> Previous discussion of the issue:
> http://thread.gmane.org/gmane.linux.acpi.devel/56345
>=20
>  drivers/acpi/video.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index f94d4c8..0230cb6 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1345,12 +1345,15 @@ static int
>  acpi_video_bus_get_devices(struct acpi_video_bus *video,
>  			   struct acpi_device *device)
>  {
> -	int status;
> +	int status =3D 0;
>  	struct acpi_device *dev;
> =20
> -	status =3D acpi_video_device_enumerate(video);
> -	if (status)
> -		return status;
> +	/*
> +	 * There are systems where video module known to work fine regardle=
ss
> +	 * of broken _DOD and ignoring returned value here doesn't cause
> +	 * any issues later.
> +	 */
> +	acpi_video_device_enumerate(video);
> =20
>  	list_for_each_entry(dev, &device->children, node) {
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
