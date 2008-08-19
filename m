From: Dan Vratil <progdan@progdansoft.com>
Subject: ACPI failure
Date: Tue, 19 Aug 2008 13:48:07 +0200
Message-ID: <200808191348.07644.progdan@progdansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from antispam.gigant.cz ([88.208.119.5]:45218 "EHLO
	antispam.gigant.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYHSMGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Aug 2008 08:06:24 -0400
Received: from notas.localnet (ip-89-102-154-41.karneval.cz [89.102.154.41])
	by antispam.gigant.cz (Postfix) with ESMTP id E93BF17CC74F
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2008 13:48:08 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi there,
this mailing list is probably my last chance to get some help. I have M=
SI=20
laptop. It's Windows Vista compatible laptop. But I have problems with =
ACPI -=20
since I use Linux on it.
I'm running Linux on this laptop since 2.6.22. In this version I had pr=
oblems=20
with "crashing" ACPI . But with almost every new version, ACPI has bein=
g fixed=20
and improved and in 2.6.25 it was working pretty well. Everything was w=
orking,=20
then, for about a minute ACPI crashed (showing no battery, no AC, tempe=
rature=20
@ 146 C) and then it just restored and kept running. I haven't found an=
y=20
regularity in the crashing, I think it was absolutely random.
Then in one version (i think it was 2.6.25.6, but not sure) ACPI tables=
 were=20
updated to be compatible with Windows Vista, but it has broken down my =
ACPI=20
(strange, isn't it? Vista tables not working on Vista compatible notebo=
ok), so=20
I returned to lower version.
=46ew days ago I updated to 2.6.26.2. Still same - after some time ACPI=
 crashes,=20
but does not restore anymore (untill reboot). There is absolutely nothi=
ng=20
about it in dmesg and logs.
I've decided to check, if my DSDT is buggy or not. It was. I fixed it. =
I have=20
also compiled kernel with ACPI debug statement enabled. Even with my fi=
xed=20
DSDT, ACPI is still broken, but I have some strange errors in dmesg dur=
ing=20
boot:

ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f817=
5e8)=20
[EmbeddedControl] [20080321]
ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler [20=
080321]
ACPI Error (psparse-0530): Method parse/execution failed=20
[\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIST
ACPI Error (uteval-0233): Method execution failed=20
[\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIST
ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f817=
5e8)=20
[EmbeddedControl] [20080321]
ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler [20=
080321]
ACPI Error (psparse-0530): Method parse/execution failed=20
[\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIST
ACPI Error (uteval-0233): Method execution failed=20
[\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIST

=46ull DMESG output i've uploaded here: http://pastebin.com/m1359a16

I'm not ACPI expert, so I have no idea about what this means, or if it'=
s=20
important, but I hope, there is someone here who will have an idea and =
will be=20
able to tell me what should I do to fix it.

Thanks for any response

With regards
Dan Vratil



---------------------------------
Dan Vr=E1til
progdan@progdansoft.com
ICQ 249163429
Jabber progdan@jabber.cz
Tel. +420 732 326 870
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
