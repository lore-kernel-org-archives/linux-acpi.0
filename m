From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: EC Confusion
Date: Thu, 4 Aug 2005 15:48:11 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8409038A2E@pdsmsx403>
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

 Please try debug patch filed at =
http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c71
which is against linux-2.6.13-rc5.

Thanks
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Paulo Vitor Magacho da Silva
>Sent: 2005=C4=EA8=D4=C24=C8=D5 5:08
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] EC Confusion
>
>Hello,
>
>   the kernel command line: ro root=3DLABEL=3D/ rhgb quiet acpi=3Don=20
>acpi_dbg_layer=3D0x14000F acpi_dbg_level=3D0x1F ec_polling
>   Is this correct ?
>   I still have the same problem. Here is the dmesg important=20
>part. I have=20
>to hit the sleep button 8 time before it works :
>acpi_ec-0810 [08] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [09] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [10] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [11] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [12] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [13] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [14] acpi_ec_gpe_query     : Evaluating _Q20
>acpi_ec-0810 [15] acpi_ec_gpe_query     : Evaluating _Q0D
>  evmisc-0152 [24] ev_queue_notify_reques: Dispatching=20
>Notify(80) on node=20
>dff217e8
>  evmisc-0161 [24] ev_queue_notify_reques: Notify value: 0x80 **Device=20
>Specific**
>
>  As I said, kernels 2.6.12-rc2-mm2 and kernel 2.6.7 work for me.
>
>Thanks,
>Paulo
>
>>From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>CC: "Paulo Vitor Magacho da Silva"=20
>><pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>,luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
>>Subject: Re: [ACPI] EC Confusion
>>Date: Wed, 3 Aug 2005 22:43:59 +0200
>>
>>On Wednesday, 3 of August 2005 22:05, Paulo Vitor Magacho da=20
>Silva wrote:
>> > Hi,
>> >
>> > I've tryed and had the same problem. How do I enable=20
>ec_polling ? During
>> > boot with ec_polling=3Don ?
>>
>>Just ec_polling,
>>
>>Rafael
>>
>>
>>--
>>- Would you tell me, please, which way I ought to go from here?
>>- That depends a good deal on where you want to get to.
>>		-- Lewis Carroll "Alice's Adventures in Wonderland"
>>
>>
>>-------------------------------------------------------
>>SF.Net email is Sponsored by the Better Software Conference & EXPO
>>September 19-22, 2005 * San Francisco, CA * Development=20
>Lifecycle Practices
>>Agile & Plan-Driven Development * Managing Projects & Teams *=20
>Testing & QA
>>Security * Process Improvement & Measurement *=20
>http://www.sqe.com/bsce5sf
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>_________________________________________________________________
>MSN Messenger: converse online com seus amigos . =20
>http://messenger.msn.com.br
>
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development=20
>Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams *=20
>Testing & QA
>Security * Process Improvement & Measurement *=20
>http://www.sqe.com/bsce5sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
