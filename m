From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with "acpi=ht",
 disappearing with "acpi=off"
Date: Fri, 2 Oct 2015 13:19:19 +0300
Message-ID: <20151002101919.GZ1551@lahna.fi.intel.com>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57144 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbbJBKT0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Oct 2015 06:19:26 -0400
Content-Disposition: inline
In-Reply-To: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Niccol=F2?= Belli <niccolo.belli@linuxsystems.it>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Oct 02, 2015 at 11:59:38AM +0200, Niccol=F2 Belli wrote:
> Hi,
> This laptop suffers of random kernel hangs at boot: I tested kernel 4=
=2E1.8,
> 4.2.1 and 4.3-rc3 and they are all affected.
> Every time I turn on my laptop I have to boot several times to be abl=
e to
> reach the sddm login because often I get hangs which prevent the syst=
em to
> boot. Once booted I don't have any problem anymore, until the next bo=
ot.
>=20
> With "acpi=3Doff" the system boots flawlessly, while with "acpi=3Dht"=
 I still
> get random hangs, so I guess the problem is in the ACPI table parsing=
 code
> itself, or perhaps the SMP code.
>=20
> I recompiled kernel 4.3-rc3 with CONFIG_ACPI_DEBUG=3Dy and I attached=
 full log
> from a serial console, booting with "debug acpi.debug_level=3D0x2003"=
 (warn,
> error and tables debug enabled):
> https://bugzilla.kernel.org/attachment.cgi?id=3D189041
>=20
> Distro is Arch Linux. Please let me know if you need further logs.
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D105251

Does it work any better if you blacklist the crashing module
"snd_soc_rl6347a" (or set CONFIG_SND_SOC_RL6347A=3Dn)?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
