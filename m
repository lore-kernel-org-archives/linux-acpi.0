From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC/patch] ACPI in linux PnP layer
Date: Mon, 27 Sep 2004 11:33:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057534568C@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>For 3, perhaps a cleaner solution could be interaction between pnpacpi
>and "acpi bus" :
>when an acpi driver register, it remove the PNP id it want from the PNP
>layer (fail if there are already a pnp driver that use the id).
>
>And for the drivers that register before (pci_link if I remember), a
>flags could be added somewhere in acpi_device structure that tell the
>device is already registered by a driver.
>
>This add also the advantage of removing conflict between driver that
use
>acpi and those that use pnp for the same device(for example 8250_acpi.c
>and 8250_pnp.c) even if duplicate will be removed.
For this problem, another idea is register a default ACPI driver for all
PNP devices. Sure the driver is only for REAL PNP devices. The
functionality of the driver is link the device to PNP layer. This way in
the initializing code of pnpacpi isn't required to walk ACPI namespace.
The more important is it's easy to support hotplug PNP devices (just
hotplug the ACPI device is needed, which I have matured methods.). How
about it? I will try the method after the ACPI '.match' method is
merged.

>
>On the previous patch I send to the ML, I only change
>dev->active =3D device->status.functional to dev->active =3D
>device->status.enabled that you have already done in your patch.
>
>I also add a check for the pnpids : instead of testing in the length is
>7, I ckeck it verify [@-Z][@-Z][@-Z][0-9A-F][0-9A-F][0-9A-F][0-9A-F]\0
>regexp
>
>For that I modify pnpidacpi_to_pnpid
>
>
>+/*
>+ * Compatible Device IDs
>+ */
>+#define TEST_HEX(c) if (!(('0' <=3D c && c <=3D '9') || ('A' <=3D c && =
c <=3D
>'F'))) \
>+			return 0
>+#define TEST_ALPHA(c) if (!('@' <=3D c || c <=3D 'Z')) \
>+			return 0
>+
>+static int pnpidacpi_to_pnpid(char *id, char *str)
>+{
>+	TEST_ALPHA(id[0]);
>+	str[0] =3D id[0];
>+	TEST_ALPHA(id[1]);
>+	str[1] =3D id[1];
>+	TEST_ALPHA(id[2]);
>+	str[2] =3D id[2];
>+	TEST_HEX(id[3]);
>+	str[3] =3D tolower(id[3]);
>+	TEST_HEX(id[4]);
>+	str[4] =3D tolower(id[4]);
>+	TEST_HEX(id[5]);
>+	str[5] =3D tolower(id[5]);
>+	TEST_HEX(id[6]);
>+	str[6] =3D tolower(id[6]);
>+	if (id[7] !=3D '\0')
>+		return 0;
>+	str[7] =3D '\0';
>+
>+	return 1;
>+}
>
>and in pnpacpi_add_device
>
>+       if ((strlen(acpi_device_hid(device)) !=3D 7) ||
>+               is_exclusive_device(device))
>+               return 0;
>+
>+       pnpidacpi_to_pnpid(acpi_device_hid(device), id);
>become
>+       if ((!pnpidacpi_to_pnpid(acpi_device_hid(device), id)) ||
>+               is_exclusive_device(device))
>+               return 0;
>+
Nice, will add it soon, or you can add it in the patch.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
