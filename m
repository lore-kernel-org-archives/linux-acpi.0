From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: my KDE-4.4.2 Battery Monitor ppplet dislikes the ACPI changes in 2.6.34-rc3 betweeen f5284e7..cf90bfe
Date: Thu, 8 Apr 2010 22:31:42 +0200
Message-ID: <201004082231.42327.rjw@sisk.pl>
References: <201004081812.10656.toralf.foerster@gmx.de> <201004081817.29561.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201004081817.29561.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 08 April 2010, Toralf F=F6rster wrote:
>=20
> Toralf F=F6rster wrote at 18:12:09
> > because now it tells me that my ThinkPad T400 has 0 cpus and 0 batt=
eries
> > ...
>=20
> FWIW :=20
>=20
> tfoerste@n22 ~/tmp $ grep "ACPI E" dmesg-2.6.34-rc3-00406-gcf90bfe
> ACPI Error: Null Object! Obj=3D(null) State=3Df676bc00 Num=3D0=20
> (20100121/dswstate-183)
> ACPI Error (psparse-0537): Method parse/execution failed=20
> [\_SB_.PCI0.LPC_.EC__.GBIF] (Node f70d4e28), AE_BAD_PARAMETER
> ACPI Error (psparse-0537): Method parse/execution failed=20
> [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node f70d4d60), AE_BAD_PARAMETER
> ACPI Exception: AE_BAD_PARAMETER, Evaluating _BIF (20100121/battery-4=
05)
> thinkpad_acpi: ThinkPad ACPI Extras v0.24

Please always Cc linux-acpi when reporting ACPI problems (now added).

Thanks,
Rafael
