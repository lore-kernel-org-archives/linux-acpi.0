From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: /proc/battery empty on Gateway 400VTX
Date: Wed, 8 Oct 2003 17:44:15 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84D76@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
   Your BIOS lacks ECDT. Maybe you should provide an ECDT according to =
EC device.

Thanks,
Shaohua


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Casey =
Harkins
Sent: 2003=C4=EA10=D4=C28=C8=D5 5:04
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] /proc/battery empty on Gateway 400VTX


Looking for help with getting ACPI battery monitoring to work on this
laptop. I'm running SourceMage GNU/Linux with:

	vanilla linux 2.4.22
	acpi 20030916 patch for 2.4.22
	dsdt-initrd patch v0.3 for 2.4.22

All other acpi functions seem to work (haven't tried suspending). =
Nothing
is reported when the battery module loads (it is being loaded between =
the
ac_adapter and button modules) and the /proc/battery directory exists =
but
is empty.

I tried dumping and fixing the dsdt. There was only 1 warning:

   dsdt.asl   281: Method(_WAK, 1) {
   Warning  2026 -           ^ Reserved method must return a value =
(_WAK)

I fixed this according to Richard Black's HOWTO and loaded it via the
initrd method using the dsdt-initrd patch listed above, though it seemed
to have no effect on the system.

There are some interesting errors in dmesg with or without the fixed =
dsdt.
Specifically:

---
evregion-0249 [22] ev_address_space_dispa: no handler for =
region(df5ecc68)
[EmbeddedControl]
 exfldio-0269 [21] ex_access_region      : Region EmbeddedControl(3) has
no handler
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] =
(Node
df5f1108), AE_NOT_EXIST
---

I've attached the dmesg outputs for both to this message along with the
original dsdt source. It might also be useful to know that =
'pci=3Dnoacpi'
was passed to the kernel for both of these dmesg outputs. With 2.4.22
(but not 2.4.19) the onboard ethernet does not get an IRQ without =
passing
the pci=3Dnoacpi option.

Thanks in advance for any help/guidance.


-casey



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
