From: "Lu, Baolu" <baolu.lu@linux.intel.com>
Subject: [asus-nb-wmi] thermal device detected by asus-nb-wmi platform driver
Date: Fri, 21 Mar 2014 08:22:08 +0800
Message-ID: <532B8630.8030607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I booted Ubuntu13.10 onto ASUS T100 Tablet and upgraded it with upstrea=
m
kernel (3.14.0-rc7+). There is a thermal device under
/sys/devices/platform/asus-nb-wmi.

root@t100:~/linux# tree /sys/class/hwmon/
/sys/class/hwmon/
=E2=94=9C=E2=94=80=E2=94=80 hwmon0 -> ../../devices/platform/coretemp.0=
/hwmon/hwmon0
=E2=94=94=E2=94=80=E2=94=80 hwmon1 -> ../../devices/platform/asus-nb-wm=
i/hwmon/hwmon1

root@t100:/sys/devices/platform/asus-nb-wmi# ls
cpufv driver hwmon input modalias power subsystem uevent

root@t100:~/linux# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
Core 1: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
Core 2: +39.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
Core 3: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)

asus-isa-0000
Adapter: ISA adapter
temp1: +6280.0=C2=B0C

I didn't get any information about thermal interface in
"Documentation/ABI/testing/sysfs-platform-asus-wmi". Is this a thermal
sensor? If it's the fact, how can I change the environment so that this
sensor gives me variable data?

Thanks,
baolu
