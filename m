From: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Subject: Re: CALL FOR TESTING (just for the record)
Date: Fri, 4 Oct 2002 14:36:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17xSk5-0000au-00@incognito>
References: <E17wsFd-0000WF-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E17wsFd-0000WF-00-HKCwXBn57GynvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

I know this is already out of date, but just for the record, I would like=
 to=20
say that my COMPAQ 12XL515 (1200 series) boots and works better than ever=
 (as=20
far as I could see) with the 20020918 ACPI version and kernel 2.4.18

Battery info and status are OK

Thermal management seems better

Events work (never worked before without the kacpid patch, and even with =
it=20
in the latter versions). Now I can test ospmd or acpid (by the way which =
is=20
the better?)

A strange issue also seems to have disapeared. I didn't think it was acpi=
=20
related, but as it disapeared with this last version, I have to assume it=
=20
was. Sometimes, I didn't found a rational to know exactly why or when, my=
=20
mouse became out of syncronism with the pointer in the screen. I had to p=
oint=20
a little bit to the right to hit a button. This used to happen with Mozil=
la,=20
Scilab and other programs, and the only way to regain syncronism was to=20
reboot or suspend and resume with swsusp. Killing the Xserver, or gpm did=
n't=20
work. My system runs Debian 3.0 and I use gpm to take advantage of the=20
Synaptics touchpad driver features. Does anyone have a clue on this? My=20
suspicion goes to temperature as I believe the system runs cooler now.

Best regards, and keep up the good work

Lu=EDs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
