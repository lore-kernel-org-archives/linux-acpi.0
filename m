From: salva_ste-nc/lrvXPQ4s@public.gmane.org
Subject: Re:acpi and presario 700
Date: Fri, 18 Oct 2002 08:27:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D929B6A000178E7@ims4c.cp.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
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

>I own a presario 714EA with RedHat Linux 7.3 again.
>do you have info for acpi?
>i'm a newbie (acpi is in my kernel but how to apply?)

Presario 7xx and linux acpi had began to work fine from september patches=

of acpi (before you had to use the kacpid patch together with acpi). Now
just take last kernel and last acpi patch and to compile everything acpi
related, if you compile acpi as a module don't forget to load acpi module=
s.

acpi can control everything in this laptops but the thermal zone and fans=
,
I guess these features are BIOS controlled and if you want to have a comp=
lete
acpi control you have to rewrite DSDT ...

Note: if you want S3 you must use 2.5 kernels

Bye, Stefano



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
