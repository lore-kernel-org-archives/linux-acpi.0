From: "Peter Mahlknecht" <mali100@gmx.net>
Subject: ACPI reads wrong temperature
Date: Fri, 31 Oct 2008 15:02:47 +0100
Message-ID: <20081031140247.325670@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751372AbYJaOCt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Oct 2008 10:02:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,=20
I installed Debian Lenny (2.6.26-1-686) on my notebook (Samsung P40 wit=
h the latest Bios 09HK), but the notebook continued to shutting down wi=
th the message "Critical temperature reached (65535 C). Shutting down."=
=2E=20
To stop this I patched the thermal module, so that it ignores every tem=
perature above 1000 C.=20
The wrong temperatuer is also listed in /proc/acpi/thermal_zone/THRM/te=
mperature. Using lm-sensors I get the following output:=20
sensors=20
acpitz-virtual-0=20
Adapter: Virtual device=20
temp1:      +65535.0=B0C  (crit =3D +105.0=B0C)                 =20

max6657-i2c-0-4c=20
Adapter: SMBus I801 adapter at 18e0=20
M/B Temp:    +39.0=B0C  (low  =3D -65.0=B0C, high =3D +127.0=B0C) =20
                      (crit =3D +110.0=B0C, hyst =3D +100.0=B0C) =20
CPU Temp:    +44.4=B0C  (low  =3D +35.1=B0C, high =3D +57.1=B0C) =20
                      (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)=20


The acpitz-virtual-0 device is the temperature that the kernel-acpi-mod=
ule reads. The temperature listed under CPU Temp is the temperature rea=
d directly by lm-sensors, which seems to be right (at least it's in the=
 same range as when running windows).=20

Strange is, that during boot the right temperature seems to be read:
[   10.519291] ACPI: Thermal Zone [THRM] (58 C)

I had the same problem also with the 2.6.18-6-686 (Lenny) and with Ubun=
tu Hardy Heron (think the kernel was 2.6.24).=20

Can somenone give me a hint how I can fix the ACPI temperatuer reading?=
 What other logs, system outputs should I post?=20

B.R. Peter
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
