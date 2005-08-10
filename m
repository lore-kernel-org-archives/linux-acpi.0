From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Wed, 10 Aug 2005 16:51:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409172B9D@pdsmsx403>
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
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 Hmm, I need to have your DSDT a look.
Your box got a lot of notify on AC, or BAT.

Thanks,
Luming

>-----Original Message-----
>From: Paulo Vitor Magacho da Silva [mailto:pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org]=20
>Sent: 2005=C4=EA8=D4=C210=C8=D5 11:59
>To: Yu, Luming; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: RE: [ACPI] EC Confusion
>
>
>Hi,
>
>I hit seven times the sleep button and I get the same message :
>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node=20
>c14d52e8)
>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node=20
>c14d5168)
>Then, in the 8th time I get:
>kernel:  Execute Method: [\_SB_.PCI0.LPC0.EC__._Q0D] (Node c14d5f28)
>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node=20
>c14d52e8)
>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node=20
>c14d5168)
>
>Thanks,
>Paulo
>
>>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>To: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>>CC: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>Subject: RE: [ACPI] EC Confusion
>>Date: Tue, 9 Aug 2005 14:14:16 +0800
>>
>>To clearly illustrate the problem, please try acpi_dbg_layer=3D0x10
>>acpi_dbg_layer=3D0x10,
>>and retest kernel. If you press key,  you should immediately see
>>messages like:
>>"Execute Method: [\_SB_PCI0.LPCB.EC__._Q0D] "
>>That means EC works for this time.
>>
>>Thanks,
>>Luming
>>
>> >Hi,
>> >
>> >I all I got was :
>> >**** Context Switch from TID EEC to TID 7 ****
>> >acpi_bus-0306 [0007] [17] acpi_bus_generate_even: ----Entry
>> >acpi_bus-0330 [0007] [17] acpi_bus_generate_even: ----Exit-
>> >0000000000000000
>> >**** Context Switch from TID 7 to TID EEC ****
>> >acpi_bus-0376 [0EEC] [14] acpi_bus_receive_event: ----Exit-
>> >0000000000000000
>> >acpi_bus-0343 [0EEC] [14] acpi_bus_receive_event: ----Entry
>> >
>> >
>> >Thanks,
>> >Paulo
>> >
>> >>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> >>To: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>> >>CC: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>> >>Subject: RE: [ACPI] EC Confusion
>> >>Date: Mon, 8 Aug 2005 21:29:09 +0800
>> >>
>> >>Hi,
>> >>Could you try acpi_dbg_layer=3D0x10000  acpi_dbg_level =
=3D0xFFFFFFFF,
>> >>If you press sleep button, you should see
>> >>"Received DEVICE WAKE notification for device [SLPB]"
>> >>
>> >>If yes, I don't think sleep button was confused by EC.
>> >>
>> >>Thanks
>> >>Luming
>> >>
>> >
>> >_________________________________________________________________
>> >MSN Messenger: converse online com seus amigos .
>> >http://messenger.msn.com.br
>> >
>> >
>
>_________________________________________________________________
>Chegou o que faltava: MSN Acesso Gr=A8=A2tis. Instale J=A8=A2!=20
>http://www.msn.com.br/discador
>
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
