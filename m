From: =?UTF-8?Q?Daniel_Gl=c3=b6ckner?= <dg@emlix.com>
Subject: acpi_find_gpio with absent GPIOs
Date: Fri, 23 Oct 2015 16:56:54 +0200
Message-ID: <562A4AB6.1010805@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I'm currently trying to use rfkill-gpio with a device that has just a
single GPIO assigned by ACPI. rfkill-gpio calls acpi_dev_add_driver_gpi=
os
to assign names to the ACPI GPIOs and then uses devm_gpiod_get_optional
to request both of them. The problem is that on the second call to
devm_gpiod_get_optional acpi_find_gpio falls back to using the GPIO ind=
ex
0 (from gpiod_get) in _CRS, which leads to the same GPIO being returned
as in the first call. Probing the driver then fails with -EBUSY.

In my opinion it is a bad idea to fall back to indexing the _CRS if the
con_id was found in the _DSD or the GPIOs added by
acpi_dev_add_driver_gpios, but I don't know if there are drivers relyin=
g
on this behavior.

Luckily acpi_get_gpiod_by_index returns -ENODATA if the name can't be
found and -ENOENT if the GPIO is absent, so we can distinguish the two
cases. -EPROBE_DEFER also should not make acpi_find_gpio try to use
another GPIO from the _CRS.

There is also the possibility that the GPIO index exceeds the size of
the package found in _DSD or added with acpi_dev_add_driver_gpios.
The former will return -EPROTO, the latter will forward the error
from acpi_dev_get_property_reference (usually -ENODATA). of_find_gpio
returns -ENOENT in this case.

So, what of this should be fixed?

Best regards,

  Daniel

--=20
Dipl.-Math. Daniel Gl=C3=B6ckner, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Stra=C3=9Fe 9, 37085 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B =
3160
Gesch=C3=A4ftsf=C3=BChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
