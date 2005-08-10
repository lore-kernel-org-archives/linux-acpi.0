From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Wed, 10 Aug 2005 16:57:32 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409172BBB@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20
I just update burst ec patch against 2.6.13-rc6
at http://bugzilla.kernel.org/show_bug.cgi?id=3D3851
Could you test it?

Thanks,
Luming

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn-l3A5Bk7waGM@public.gmane.org]=20
>Sent: 2005=C4=EA8=D4=C210=C8=D5 14:55
>To: Paulo Vitor Magacho da Silva
>Cc: Yu, Luming; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] EC Confusion
>
>Paulo Vitor Magacho da Silva wrote:
>
>> Hi,
>>=20
>> I hit seven times the sleep button and I get the same message :
>> kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST]=20
>(Node c14d52e8)
>> kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR]=20
>(Node c14d5168)
>> Then, in the 8th time I get:
>> kernel:  Execute Method: [\_SB_.PCI0.LPC0.EC__._Q0D] (Node c14d5f28)
>> kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST]=20
>(Node c14d52e8)
>> kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR]=20
>(Node c14d5168)
>>=20
>
>Seems as if the ACPI events are buffered?
>I had a very similar bug report:
>________________________________________
>The ACPI events, which are triggered by keyboard (via Fn key,=20
>eg. to switch
>WiFi card on/off) are somehow buffered in the kernel. I have=20
>to push the key
>combination 8 times until acpi_listen (or cat=20
>/proc/acpi/event) gets the first
>event, then, if I push other combinations, I get the events=20
>from the "buffer".
>________________________________________
>
>EC burst mode did solve this problem on that machine.
>
>      Thomas
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
