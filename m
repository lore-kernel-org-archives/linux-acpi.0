From: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>
Subject: Battery critical event
Date: Thu, 30 Jan 2003 22:43:05 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18ecXL-0001PJ-00@incognito>
Reply-To: lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!,

After a long time using ACPI and swsusp, I decided to give a try to acpid=
 so=20
I could get a bit more of the behaviour of my laptop when it runs the OS =
it ,=20
brought from factory, namely the suspend-when-battery-is-critical-low.=20
However I found than with my actual configuration: linux 2.4.20+acpi20021=
212=20
the event I get when this happens is button/power. Is this a known featur=
e or=20
an aditional "bug" on my BIOS?=20

It is not a big deal, it's original behaviour under Windows is to suspend=
=20
when one presses the power button, so I simply attached the action of=20
suspending to the event power button, and the action shutdown to the even=
t=20
sleep button, but I wondered if this was expected also because I got erro=
rs=20
when this happened:

 ACPI-1103: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node=20
c117fde0), AE_TIME
ACPI-0323: *** Error: Handler for [Embedded_control] returned AE_TIME
ACPI-1103: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node=20
c117f900), AE_TIME

My machine is a COMPAQ Presario 12XL515 with DSDT overriden

Best regards,

Lu=EDs Neves


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
