From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fan resume handling - ACPI resume callbacks?
Date: Tue, 20 Sep 2005 09:42:39 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F171FD2A@pdsmsx406>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>I'm trying to implement resume support for the fan driver. From what I
>can tell through experimentation, the easiest solution is to check if
>the fan claims to be switched on, and if so to switch it off and on
>again. However, my resume callback never seems to be called. I've got
>
>static struct acpi_driver acpi_fan_driver =3D {
>        .name =3D         ACPI_FAN_DRIVER_NAME,
>        .class =3D        ACPI_FAN_CLASS,
>        .ids =3D          ACPI_FAN_HID,
>        .ops =3D          {
>                                .add =3D          acpi_fan_add,
>                                .remove =3D       acpi_fan_remove,
>                                .resume =3D       acpi_fan_resume,
>                        },
>};
>
>but adding printks to acpi_fan_resume doesn't seem to result in
anything
>in the kernel logs. Is this stuff supposed to work?
The ACPI driver model isn't plugged into Linux driver tree, so the
.resume method will never get called. I recently sent out some patches
into the list
(http://sourceforge.net/mailarchive/forum.php?thread_id=3D8172458&forum_i=
d
=3D6102). With the patches, the .resume will work. But Dominik thought =
we
should not introduce acpi bus, instead we should make most ACPI devices
as platform devices. I'm still evaluating it.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
