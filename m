From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Crash on boot with latest ACPI versions
Date: Sat, 24 May 2003 14:11:10 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2BC@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jean-Marc Valin <jean-marc.valin-ZbDpfo6ompS0w+vkrfm4Cg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jean-Marc Valin [mailto:jean-marc.valin-ZbDpfo6ompS0w+vkrfm4Cg@public.gmane.org]=20
> I've been experiencing crashes while booting with the latest ACPI
> driver. Since I can't use a screendump program, I tried to take a
> picture instead (sorry, bad quality):
> http://www.xiph.org/~jm/acpi_crash.jpg
>=20
> I'm using a Compaq Presario 1720CA laptop (PIII 1 GHz) under=20
> 2.4.20. The
> stock kernel ACPI doesn't crash (though battery status doesn't work),
> but the latest ACPI drivers (all versions less than 6-10 months old)
> crash on boot every time.

Hi. Yeah, stock 2.4.20 doesn't use ACPI for PCI IRQ routing, which lets
it dodge any issues in this very important area. So, it's hanging at
that spot in your picture?

Can you put printk functions at the top and bottom of
acpi_evaluate_object? This will narrow it down to a hang in the
interpreter, or somewhere else. Also, if you haven't turned on debug
messages, please do so.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
