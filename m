From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC]convert ACPI driver model to Linux driver model - takes 2
Date: Thu, 13 Oct 2005 15:45:52 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC20F@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>+static int __init acpi_phys_bus_init(void)
>+{
>+	bus_register(&acpi_phys_bus_type);
>+
>+	phys_root =3D kzalloc(sizeof(struct acpi_phys_device),=20
>GFP_KERNEL);
>+	if (!phys_root)
>+		return -ENOMEM;
>+
>+	phys_root->acpi_dev =3D acpi_root;
>+	phys_root->phys_dev.release =3D acpi_phys_device_release;
>+	sprintf(phys_root->phys_dev.bus_id, "%s",=20
>acpi_root->pnp.bus_id);
>+	device_register(&phys_root->phys_dev);
>+
>+	/* enumerate devices */
>+	acpi_bus_register_driver(&dummy_driver);
>+	return 0;
>+}

The structure is in a mess. why not cut bus.c?

I like this:

acpi_bus_init(void)
{
...
bus_register(&acpi_bus_type);
...
driver_register(&acpi_bus_driver);
...
}



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
