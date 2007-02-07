From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: hwsusp defunct
Date: Wed, 7 Feb 2007 20:10:05 +0800
Message-ID: <3877989d0702070410k77f67616qb4edff275b90c988@mail.gmail.com>
References: <45C5DBBA.20502@gmail.com> <200702041452.28874.rjw@sisk.pl>
	 <45C86405.1070902@gmail.com> <200702061855.49077.rjw@sisk.pl>
	 <45C9C0B6.9090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:41478 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161264AbXBGMKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 07:10:05 -0500
Received: by an-out-0708.google.com with SMTP id b33so156089ana
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2007 04:10:05 -0800 (PST)
In-Reply-To: <45C9C0B6.9090704@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org

=46or acpi issues, please enter bug into bugzilla.kernel.org with dmesg=
,
acpidump output .


On 2/7/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Cc: linux-acpi
> not-cc: linux-pm
>
> Rafael J. Wysocki napsal(a):
> > On Tuesday, 6 February 2007 12:18, Jiri Slaby wrote:
> >> This is blindly written dmesg after resume. See it whole at [2]:
> >> Suspending device 0.0
> >> ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (00000=
0007) is beyon
> >> d end of object [20070126]
> >> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PC=
I0.IDE0.GTM_]
> >> (Node dfe64fcc), AE_AML_PACKAGE_LIMIT
> >> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PC=
I0.IDE0.CHN0._
> >> GTM] (Node dfe649f0), AE_AML_PACKAGE_LIMIT
> >> ...
> >> hda: selected mode 0x45
> >> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero =
[20070126]
> >> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PC=
I0.IDE0.RATA]
> >> (Node dfe64ec8), AE_AML_OPERAND_VALUE
> >> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PC=
I0.IDE0.CHN0.D
> >> RV1._GTF] (Node dfe64964), AE_AML_OPERAND_VALUE
> >> do_drive_get_GTF: Run _GTF error: status =3D 0x3006
> >
> > This looks like an ACPI-vs-IDE problem.  You can try to use libata =
drivers instead
> > of the "old IDE" ones.
> >
> >> $ ls -l /sys/block/hda/device
> >> lrwxrwxrwx 1 root root 0 =FAno  6 12:14 /sys/block/hda/device ->
> >> ../../devices/pci0000:00/0000:00:1f.1/ide0/0.0
> >> $ ls -l /sys/block/hda/device/driver
> >> lrwxrwxrwx 1 root root 0 =FAno  6 12:15 /sys/block/hda/device/driv=
er ->
> >> ../../../../../bus/ide/drivers/ide-disk
> >> $ ls -l /sys/block/hda/device/driver/0.0
> >> lrwxrwxrwx 1 root root 0 =FAno  6 12:16 /sys/block/hda/device/driv=
er/0.0 ->
> >> ../../../../devices/pci0000:00/0000:00:1f.1/ide0/0.0
> >> # lspci -vvvxxs 0000:00:1f.1
> >> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) I=
DE Controller
> >> (rev 02) (prog-if 8a [Master SecP PriP])
> >>          Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
> >>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p- ParErr-
> >> Stepping- SERR- FastB2B-
> >>          Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=
 >TAbort-
> >> <TAbort- <MAbort- >SERR- <PERR-
> >>          Latency: 0
> >>          Interrupt: pin A routed to IRQ 5
> >>          Region 0: I/O ports at 01f0 [size=3D8]
> >>          Region 1: I/O ports at 03f4 [size=3D1]
> >>          Region 2: I/O ports at 0170 [size=3D8]
> >>          Region 3: I/O ports at 0374 [size=3D1]
> >>          Region 4: I/O ports at fc00 [size=3D16]
> >>          Region 5: Memory at 30100000 (32-bit, non-prefetchable) [=
size=3D1K]
> >> 00: 86 80 db 24 07 00 80 02 02 8a 01 01 00 00 00 00
> >> 10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
> >> 20: 01 fc 00 00 00 00 10 30 00 00 00 00 43 10 a6 80
> >> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
> >>
> >> Do you want acpidump?
> >
> > I'm not an ACPI expert, it won't tell me a lot, but perhaps you sho=
uld add
> > linux-acpi to the Cc list. ;-)
> [...]
>  > [1]
>  >   http://www.fi.muni.cz/~xslaby/sklad/config-mm
>  > [2]
>  >   http://www.fi.muni.cz/~xpapiez/test/dmesg-mm.txt
>
> Ok, acpi folks, any suggests?
>
> thanks,
> --
> http://www.fi.muni.cz/~xslaby/            Jiri Slaby
> faculty of informatics, masaryk university, brno, cz
> e-mail: jirislaby gmail com, gpg pubkey fingerprint:
> B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
