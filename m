From: Florian Bruhin <me@the-compiler.org>
Subject: Can't wake up screen after blanking
Date: Thu, 7 Jan 2016 18:13:32 +0100
Message-ID: <20160107171332.GS13305@tonks>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_mehl.schokokeks.org-22862-1452186814-0001-2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mehl.schokokeks.org ([46.4.40.247]:54579 "EHLO
	mehl.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcAGRSi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 12:18:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mehl.schokokeks.org-22862-1452186814-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently having trouble with a Kontron COMe-cBT6 module[1]: As
soon as the screen blanks (after a few minutes), I can't get it to
turn on again by a keypress.

I'm testing this with a Fedora 23 with a 4.2.3 kernel. The CPU is a
Intel Atom E3845.

It works fine on Windows 8 on the same hardware.
I'm not entirely sure if it's an ACPI issue, but I suspect it is?

dmesg doesn't show anything suspicious after the screen is blank, but
displays some interesting things during boot:

    [    0.131449] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep Sta=
te [\_S1_] (20150619/hwxface-580)
    [    0.131459] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep Sta=
te [\_S2_] (20150619/hwxface-580)

    [    0.176059] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI]
    [    0.176305] \_SB_.PCI0:_OSC invalid UUID
    [    0.176308] _OSC request data:1 1f 0=20
    [    0.176317] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
    [    0.176592] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 00=
00 [bus 00-3f] only partially covers this bridge
    [    0.176918] PCI host bridge to bus 0000:00

    [    4.269813] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
    [    4.271140] ACPI: Video Device [PEGP] (multi-head: yes  rom: no  pos=
t: no)
    [    4.271155] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup=
 failure, AE_NOT_FOUND (20150619/psargs-359)
    [    4.271165] ACPI Error: Method parse/execution failed [\_SB_.PCI0.RP=
01.PEGP.DD02._BCL] (Node ffff88017b0c2208), AE_NOT_FOUND (20150619/psparse-=
536)
    [    4.271370] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup=
 failure, AE_NOT_FOUND (20150619/psargs-359)
    [    4.271380] ACPI Error: Method parse/execution failed [\_SB_.PCI0.RP=
01.PEGP.DD02._BCL] (Node ffff88017b0c2208), AE_NOT_FOUND (20150619/psparse-=
536)

    [   11.432121] ACPI Warning: SystemIO range 0x0000000000003000-0x000000=
000000301F conflicts with OpRegion 0x0000000000003000-0x000000000000300F (\=
_SB_.PCI0.SBUS.SBU0) (20150619/utaddress-254)
    [   11.432134] ACPI: If an ACPI driver is available for this device, yo=
u should use it instead of the native driver

Full dmesg log: [2]

I tried "xset dpms force on" after the screen blanks, but that didn't help
either.

    $ lspci | grep VGA
    00:02.0 VGA compatible controller: Intel Corporation Atom Processor Z36=
xxx/Z37xxx Series Graphics & Display (rev 11)

    $ uname -a
    Linux localhost 4.2.3-300.fc23.x86_64 #1 SMP Mon Oct 5 15:42:54 UTC 201=
5 x86_64 x86_64 x86_64 GNU/Linux

acpidump after the screen blank: [3]

Please let me know if there's any other useful information I could
provide - or what a better place to post this would be if it isn't
actually an ACPI issue.

Thanks!

Florian

[1] http://www.kontron.com/products/boards-and-standard-form-factors/com-ex=
press/com-express-compact/come-cbt6.html
[2] http://paste.the-compiler.org/view/d2c13712
[3] http://paste.the-compiler.org/view/efb11d4a

--=20
http://www.the-compiler.org | me@the-compiler.org (Mail/XMPP)
   GPG: 916E B0C8 FD55 A072 | http://the-compiler.org/pubkey.asc
         I love long mails! | http://email.is-not-s.ms/

--=_mehl.schokokeks.org-22862-1452186814-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWjpy7AAoJEJFusMj9VaBysL8P+QGCgCehNwBBVCuu6/IQb0Ff
IthgjAb9dTYnLheQEtsvLBEVUTibB9R6orKmY7355PoIA7vJNlAiuGiW2FcH8MOr
SOSjt1Au8b+R3Stou60dzf1zuutSgA2m5yjjmzz7G7oFIMeH4KAHbbAa48dWVYcW
GDHf7UotMHWhi/ktEISzsC82kludJq3uNsTj5+FkKdOnXZTa5v9m3LyXZaanXjcJ
0JgHVDUcQol4yabZWgWJROH/logSJslTnqzNstyHmjC/6m42AXiCJcMV3MhbBUj2
XC4fK5nh9/klwyNfV03HdiuXbckac2JAQ+xSMj1jc9iThvaRiDcV0n3uPqdjGB9J
2y4QOOrKWEfILk1qub7Qdm0Zonh74h2t5gXHn6ZOanz7JgVMnPlG3ZJ8G31ptcKh
RZkN4odnDa376zcARhiIbYtJn0rPU+pd1s8iPAorL6Qdbhvzq8d5qwHGIdPUYA6t
YcaK9+CRbsPjV2aK7u3n7iDxIZBZ1vap5dUpCfsGXYkOsCLBUy11BnORDL6s0WIc
yAEE8oX5aN9ggHYt8gpBGqNB4Qr6c3R9vVqK5W/0bLiCbfUIxiMh6NuQXFB3m6o/
KnKmjBaCbQ9Q4tgmX1bEgh2bznQJH/ciFafPSQO6SQjlMUnGX6fr5hClvzah3kGr
PHGFsPg1SuunygVbfRa3
=Y8PO
-----END PGP SIGNATURE-----

--=_mehl.schokokeks.org-22862-1452186814-0001-2--
