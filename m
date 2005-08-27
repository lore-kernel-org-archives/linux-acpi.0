From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Generic hotkey driver for dock ejecting
Date: Sat, 27 Aug 2005 22:43:14 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC202@pdsmsx403>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



>
>I'm playing with a Dell Latitude D610. By doing
>
>echo "0:\\_SB.PCI0.PCIE.GDCK::\\SB_PCI0.PCIE.GDCK::0:0"=20
>>/proc/hotkey/event_config
>
>I can get an event when I push the eject request button on the dock. I=20
>guess the appropriate thing to do in response to this is to call the=20
>dock's eject method (the dock appears to be \_SB.PCI0.PCIE.GDCK, which=20
>has _EJ0, _EJ3 and _EJ4 methods). How do I go about this?
>
>--=20
>Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
>

I think you need to find out the event number generated when pushing
button.
I call it external_event_num. And you need assign a interal_event_num
for it.
I want internal_event_num stand for common things.
Then register it by

echo
"0:\\_SB.PCI0.PCIE.GDCK::\\SB_PCI0.PCIE.GDCK:_EJxx:internal_event_num:ex
ternal_event_num" > event_config

You can invoke _Ejxx by=20

echo "internal_event_num:0:1:0" > /proc/acp/hotkey/action=20

Thanks,
Luming


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
