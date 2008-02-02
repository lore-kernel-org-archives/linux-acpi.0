From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/10] ACPI: register ACPI Fan as generic thermal cooling device
Date: Sat, 2 Feb 2008 04:08:56 -0500
Message-ID: <200802020408.56587.lenb@kernel.org>
References: <1200556284.2935.124.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40498 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762097AbYBBJJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Feb 2008 04:09:12 -0500
In-Reply-To: <1200556284.2935.124.camel@acpi-sony.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com

On Thursday 17 January 2008 02:51, Zhang Rui wrote:
> +#ifdef CONFIG_ACPI_PROCFS
> =C2=A0
> =C2=A0static struct proc_dir_entry *acpi_fan_dir;
> =C2=A0
> @@ -167,7 +213,17 @@ static int acpi_fan_remove_fs(struct acp
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> +#else
> +static int acpi_fan_add_fs(struct acpi_device *device)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> =C2=A0
> +static int acpi_fan_remove_fs(struct acpi_device *device)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +#endif

commit 3c602840528cf1aa835e6e32d76a0a45936b8e4c
Author: Len Brown <len.brown@intel.com>
Date:   Sat Feb 2 04:05:54 2008 -0500

    ACPI: fan: build fix for CONFIG_ACPI_PROCFS=3Dn
   =20
    drivers/acpi/fan.c:340: error: =E2=80=98acpi_fan_dir=E2=80=99 undec=
lared (first use in this function)
   =20
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f6e8165..48cb705 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -337,10 +337,12 @@ static int __init acpi_fan_init(void)
 	int result =3D 0;
=20
=20
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_fan_dir =3D proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
 		return -ENODEV;
 	acpi_fan_dir->owner =3D THIS_MODULE;
+#endif
=20
 	result =3D acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
