From: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Subject: AC adapter info always on-line
Date: Fri, 4 Oct 2002 14:43:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17xSk5-0000au-01@incognito>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

In my last message I forgot one issue.

I just tried aKpi in my laptop, and with it I found that=20
/proc/acpi/ac_adapter/ACAD/state is always "on-line" even if I'm running =
on=20
battery. I used to have wmacpi running so I never noticed this because wm=
acpi=20
uses the "charging/discharging" state of the battery to inform about this=
=2E

I believe this is probably a error in my DSDT, so if someone could help m=
e in=20
veryfing this I would be grateful.

My dsdt and other files are on:

http://www.estg.iplei.pt/~lneves/files-cpq12xl515.tgz

Thanks in advance,

Lu=EDs Neves


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
