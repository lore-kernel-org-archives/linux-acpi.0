From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Mon, 8 Aug 2005 21:29:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC1F9@pdsmsx403>
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
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
Could you try acpi_dbg_layer=3D0x10000  acpi_dbg_level =3D0xFFFFFFFF,
If you press sleep button, you should see=20
"Received DEVICE WAKE notification for device [SLPB]"

If yes, I don't think sleep button was confused by EC.

Thanks
Luming=20

>-----Original Message-----
>From: Paulo Vitor Magacho da Silva [mailto:pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org]=20
>Sent: 2005=C4=EA8=D4=C25=C8=D5 12:52
>To: Yu, Luming
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] EC Confusion
>
>Hi,
>
>I am sending the files. There are two. One for kernel=20
>2.6.12-rc2-mm2, which=20
>works for me. And the second one for kernel 2.6.13-rc5, with=20
>your patch.
>Both with acpi_dbg_layer=3D0x100006 acpi_dbg_level_0xFFFFFFFF?
>Hope it helps.
>
>Thanks,
>Paulo
>
>>
>>
>>On Friday 05 August 2005 09:57, Paulo Vitor Magacho da Silva wrote:
>> > Hello,
>> >
>> > I've tryed with this patch, but still doesn't work. I am=20
>sending the=20
>>dmesg
>> > so you can take a look.
>>Yes, the log file is  pretty  good.  Everything seems to work.
>>
>> > The kernel command line: ro root=3DLABEL=3D/ rhgb quiet acpi=3Don
>> > acpi_dbg_layer=3D0x100002 acpi_dbg_level=3D0xFFFFFFFF
>>Could you try acpi_dbg_layer=3D0x100006 acpi_dbg_level_0xFFFFFFFF?
>>reproduce the wrong behaviour, then capture dmesg and send to me.
>>
>> >
>> > Thanks,
>> > Paulo
>>
>>Thanks,
>>Luming
>>
>> > >
>
>_________________________________________________________________
>Chegou o que faltava: MSN Acesso Gr=A8=A2tis. Instale J=A8=A2!=20
>http://www.msn.com.br/discador
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
