From: Luís Miguel Pires Neves <luis.p.neves-/UxMdeFaS/k@public.gmane.org>
Subject: S1bios
Date: Mon, 10 Mar 2003 22:51:53 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18sfx5-0001dg-00@incognito>
Reply-To: lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

This is just a request (desire).

As S1 is not completely working (backlight, disks spinning...), I wonder =
if=20
one couldn't find a temporary solution similar to S4bios for machines tha=
t=20
have S1 in bios.

I apologise if what I'm saying is stupid as I'm not a developper, just a=20
ordinary Linux user who has been following the development of ACPI and sw=
susp=20
in order to have it's Laptop with the usual functionality of laptops..

In my first times with Linux in this machine (COMPAQ Presario 12XL515) I=20
used APM with kernel 2.2.17 (Debian Potato's version) and I had "S1"=20
behaviour with apm -S. At the time it was the single working function as =
the=20
battery status/information wasn't there, and "S4" seemed also to be absen=
t (=20
I know now that it was there but it needed a proper configured partition)=
=2E=20
However with more recent kernels, both 2.2 and 2.4  (not patched with Deb=
ian=20
patches) I never had the APM sleeping function working again.

Anyway I started using ACPI for battery information, and Swsusp for=20
hibernation purposes, but I still miss the ability of putting the system =
in a=20
soft sleep so that I can move it from one place to another, or have a cup=
 of=20
coffee without having to wait still some time for a swsusp suspend/resume=
=20
cycle.

As S4Bios was created to use the ability of the machines who still have s=
ome=20
APM support to overcome the current limitations and difficulties of swsus=
p,=20
isn't it possible to do the same with S1?

Best regards,

Lu=EDs Neves



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
