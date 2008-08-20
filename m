From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: ACPI failure
Date: Wed, 20 Aug 2008 09:07:33 +0800
Message-ID: <1219194453.12398.2.camel@yakui_zhao.sh.intel.com>
References: <200808191348.07644.progdan@progdansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57235 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbYHTAwz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Aug 2008 20:52:55 -0400
In-Reply-To: <200808191348.07644.progdan@progdansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Vratil <progdan@progdansoft.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2008-08-19 at 13:48 +0200, Dan Vratil wrote:
> Hi there,
> this mailing list is probably my last chance to get some help. I have=
 MSI=20
> laptop. It's Windows Vista compatible laptop. But I have problems wit=
h ACPI -=20
> since I use Linux on it.
> I'm running Linux on this laptop since 2.6.22. In this version I had =
problems=20
> with "crashing" ACPI . But with almost every new version, ACPI has be=
ing fixed=20
> and improved and in 2.6.25 it was working pretty well. Everything was=
 working,=20
> then, for about a minute ACPI crashed (showing no battery, no AC, tem=
perature=20
> @ 146 C) and then it just restored and kept running. I haven't found =
any=20
> regularity in the crashing, I think it was absolutely random.
> Then in one version (i think it was 2.6.25.6, but not sure) ACPI tabl=
es were=20
> updated to be compatible with Windows Vista, but it has broken down m=
y ACPI=20
> (strange, isn't it? Vista tables not working on Vista compatible note=
book), so=20
> I returned to lower version.
> Few days ago I updated to 2.6.26.2. Still same - after some time ACPI=
 crashes,=20
> but does not restore anymore (untill reboot). There is absolutely not=
hing=20
> about it in dmesg and logs.
> I've decided to check, if my DSDT is buggy or not. It was. I fixed it=
=2E I have=20
> also compiled kernel with ACPI debug statement enabled. Even with my =
fixed=20
> DSDT, ACPI is still broken, but I have some strange errors in dmesg d=
uring=20
> boot:
There is a similar bug in bugzilla.kernel.org
  http://bugzilla.kernel.org/show_bug.cgi?id=3D11255
 =20
  Maybe you can attach the output of acpidump, dmesg, custom DSDT.=20

Thanks.
>=20
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
> ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f8=
175e8)=20
> [EmbeddedControl] [20080321]
> ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler [=
20080321]
> ACPI Error (psparse-0530): Method parse/execution failed=20
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (uteval-0233): Method execution failed=20
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f8=
175e8)=20
> [EmbeddedControl] [20080321]
> ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler [=
20080321]
> ACPI Error (psparse-0530): Method parse/execution failed=20
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (uteval-0233): Method execution failed=20
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
>=20
> Full DMESG output i've uploaded here: http://pastebin.com/m1359a16
>=20
> I'm not ACPI expert, so I have no idea about what this means, or if i=
t's=20
> important, but I hope, there is someone here who will have an idea an=
d will be=20
> able to tell me what should I do to fix it.
>=20
> Thanks for any response
>=20
> With regards
> Dan Vratil
>=20
>=20
>=20
> ---------------------------------
> Dan Vr=C3=A1til
> progdan@progdansoft.com
> ICQ 249163429
> Jabber progdan@jabber.cz
> Tel. +420 732 326 870
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
