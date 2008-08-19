From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI failure
Date: Tue, 19 Aug 2008 14:56:54 +0200
Message-ID: <200808191456.55984.trenn@suse.de>
References: <200808191348.07644.progdan@progdansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:43505 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740AbYHSM46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Aug 2008 08:56:58 -0400
In-Reply-To: <200808191348.07644.progdan@progdansoft.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Vratil <progdan@progdansoft.com>
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

On Tuesday 19 August 2008 13:48:07 Dan Vratil wrote:
> Hi there,
> this mailing list is probably my last chance to get some help. I have=
 MSI
> laptop. It's Windows Vista compatible laptop. But I have problems wit=
h ACPI
> - since I use Linux on it.
> I'm running Linux on this laptop since 2.6.22. In this version I had
> problems with "crashing" ACPI . But with almost every new version, AC=
PI has
> being fixed and improved and in 2.6.25 it was working pretty well.
> Everything was working, then, for about a minute ACPI crashed (showin=
g no
> battery, no AC, temperature @ 146 C) and then it just restored and ke=
pt
> running. I haven't found any regularity in the crashing, I think it w=
as
> absolutely random.
> Then in one version (i think it was 2.6.25.6, but not sure) ACPI tabl=
es
> were updated to be compatible with Windows Vista, but it has broken d=
own my
> ACPI (strange, isn't it? Vista tables not working on Vista compatible
> notebook), so I returned to lower version.
> Few days ago I updated to 2.6.26.2. Still same - after some time ACPI
> crashes, but does not restore anymore (untill reboot). There is absol=
utely
> nothing about it in dmesg and logs.
> I've decided to check, if my DSDT is buggy or not. It was. I fixed it=
=2E I
> have also compiled kernel with ACPI debug statement enabled. Even wit=
h my
> fixed DSDT, ACPI is still broken, but I have some strange errors in d=
mesg
> during boot:
>
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
> ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f8=
175e8)
> [EmbeddedControl] [20080321]
> ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler
> [20080321] ACPI Error (psparse-0530): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (uteval-0233): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (evregion-0316): No handler for Region [EC__] (ffff81007f8=
175e8)
> [EmbeddedControl] [20080321]
> ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler
> [20080321] ACPI Error (psparse-0530): Method parse/execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
> ACPI Error (uteval-0233): Method execution failed
> [\_SB_.PCI0.SBRG.EC__.BAT1._STA] (Node ffff81007f81a000), AE_NOT_EXIS=
T
>
> Full DMESG output i've uploaded here: http://pastebin.com/m1359a16
>
> I'm not ACPI expert, so I have no idea about what this means, or if i=
t's
> important, but I hope, there is someone here who will have an idea an=
d will
> be able to tell me what should I do to fix it.

Looks like the Embedded Controller could not be set up?
Then a lot ACPI things probably do not work.

Could document above in a bugzilla entry:
http://bugzilla.kernel.org

Best check for the latest BIOS, attach acpidump and dmesg of the latest=
=20
mainline kernel (currently .27-rc3).

Also why you think the DSDT is broken and a diff how you fixed it would=
 be=20
great. Be aware that the latest BIOS might have modified/fixed DSDT cod=
e.

       Thomas

PS: Please add me to CC of the bug.
>
> Thanks for any response
>
> With regards
> Dan Vratil
>
>
>
> ---------------------------------
> Dan Vr=E1til
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
