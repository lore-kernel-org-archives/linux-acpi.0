From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Tue, 9 Aug 2005 14:14:16 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409130912@pdsmsx403>
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
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

To clearly illustrate the problem, please try acpi_dbg_layer=3D0x10
acpi_dbg_layer=3D0x10,
and retest kernel. If you press key,  you should immediately see
messages like:
"Execute Method: [\_SB_PCI0.LPCB.EC__._Q0D] "
That means EC works for this time. =20

Thanks,
Luming

>Hi,
>
>I all I got was :
>**** Context Switch from TID EEC to TID 7 ****
>acpi_bus-0306 [0007] [17] acpi_bus_generate_even: ----Entry
>acpi_bus-0330 [0007] [17] acpi_bus_generate_even: ----Exit-=20
>0000000000000000
>**** Context Switch from TID 7 to TID EEC ****
>acpi_bus-0376 [0EEC] [14] acpi_bus_receive_event: ----Exit-=20
>0000000000000000
>acpi_bus-0343 [0EEC] [14] acpi_bus_receive_event: ----Entry
>
>
>Thanks,
>Paulo
>
>>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>To: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>>CC: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>Subject: RE: [ACPI] EC Confusion
>>Date: Mon, 8 Aug 2005 21:29:09 +0800
>>
>>Hi,
>>Could you try acpi_dbg_layer=3D0x10000  acpi_dbg_level =3D0xFFFFFFFF,
>>If you press sleep button, you should see
>>"Received DEVICE WAKE notification for device [SLPB]"
>>
>>If yes, I don't think sleep button was confused by EC.
>>
>>Thanks
>>Luming
>>
>
>_________________________________________________________________
>MSN Messenger: converse online com seus amigos . =20
>http://messenger.msn.com.br
>
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
