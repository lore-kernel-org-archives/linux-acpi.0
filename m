From: "fil\.tri\@libero\.it" <fil.tri-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: (no subject)
Date: Sun, 30 May 2004 16:22:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <HYJ6LH$8F4FB33FB70F6F8E7D71D47BD17E0250@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi mailing acpi mailing <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 	
Hi to everyone, this is my first post in this list, and I wrote from =
Italy!

I have bought an notebook asus m3452ch (m3000n serie), and i ha=
ve installed
debian unstable.
The kernel is 2.6.6 version and I have a =
problem with the fan of cpu because it
start only when the temperature e=
xceed 70 celsius degree. It's normal?
There is a way to control the fan =
speed from userspace? 
In my kernel configuration I have:
support ACPI =
=3Dy
config_acpi_ac=3Dm
config_acpi_battery=3Dm
config_acpi_button=3Dm=

config_acpi_fan=3Dm
config_acpi_processor=3Dm
config_acpi_thermal=3Dm=

config_acpi_bus=3Dy
config_acpi_ec=3Dy
config_acpi_pci=3Dy
config_ac=
pi_system=3Dy

In /etc/modules I load this modules.
When I write : ech=
o on > /proc/acpi/fan/FN00/state the fan don't start. 
Maybe the fan is =
controlled from the bios, in this case I can't do nothing? I'm
afraid=0D
=
that I can damage my notebook.

Thanks,
Phil






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
