From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI errors on dmesg
Date: Tue, 18 Oct 2005 11:55:20 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409D38CE0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
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
To: Alejandro Bonilla Beeche <abonilla-N/cRWR3FREN3ZuITGxAgx9i2O/JbrIOy@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 You'd better file this on bugzilla.kernel.org.


>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Alejandro Bonilla Beeche
>Sent: 2005=C4=EA10=D4=C218=C8=D5 9:10
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] ACPI errors on dmesg
>
>Hi,
>
>    I have debian Sid with 2.6.14-rc4-git. IBM T42. Please keep me on=20
>replys, I'm not in the ML.
>
>I think that whenever I put my PC on xlock(matrix screensaver BTW) for=20
>too long and then I come back, I see my gnome 2.10 battery=20
>icon says N/A.
>
>Then, dmesg is full of these messages.
>
>    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
>    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
>    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
>    ACPI-0213: *** Error: Method reached maximum reentrancy limit (255)
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c14cd4c0), AE_AML_METHOD_LIMIT
>
>abonilla@debian:~$ apt-cache show acpi | grep Version
>Version: 0.09-1
>abonilla@debian:~$ apt-cache show acpid | grep Version
>Version: 1.0.4-3
>
>/etc/init.d/acpid restart has no effect.
>
>abonilla@debian:~$ acpi -V
>     Thermal 1: ok, 40.0 degrees C
>  AC Adapter 1: off-line
>
>It is just not showing the battery information.
>
>Thanks,
>
>.Alejandro
>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
