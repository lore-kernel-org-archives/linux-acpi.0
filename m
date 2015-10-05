From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with "acpi=ht",
 disappearing with "acpi=off"
Date: Mon, 5 Oct 2015 13:46:45 +0300
Message-ID: <20151005104645.GA1506@lahna.fi.intel.com>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54328 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbbJEKqt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Oct 2015 06:46:49 -0400
Content-Disposition: inline
In-Reply-To: <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Niccol=F2?= Belli <niccolo.belli@linuxsystems.it>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Oct 03, 2015 at 12:11:54PM +0200, Niccol=F2 Belli wrote:
> On venerd=EC 2 ottobre 2015 12:19:19 CEST, Mika Westerberg wrote:
> >On Fri, Oct 02, 2015 at 11:59:38AM +0200, Niccol=F2 Belli wrote:
> >>Hi,
> >>This laptop suffers of random kernel hangs at boot: I tested kernel=
 4.1.8,
> >>4.2.1 and 4.3-rc3 and they are all affected.
> >>Every time I turn on my laptop I have to boot several times to be a=
ble to
> >>reach the sddm login because often I get hangs which prevent the sy=
stem
> >>to ...
> >
> >Does it work any better if you blacklist the crashing module
> >"snd_soc_rl6347a" (or set CONFIG_SND_SOC_RL6347A=3Dn)?
> >
>=20
> Hi,
> I tried to blacklist the crashing module (snd_soc_rl6347a) without an=
y
> success: it still loads. I booted kernel with
> modprobe.blacklist=3Dsnd_soc_rl6347a and I put "blacklist snd_soc_rl6=
347a" in
> /etc/modprobe.d/blacklist.conf. I even tried to recompile the kernel =
without
> that module, but there is no option in "make nconfig" to disable it, =
while
> adding "# CONFIG_SND_SOC_RL6347A is not set" to the config doesn't he=
lp
> because it keeps showing CONFIG_SND_SOC_RL6347A=3Dm in "make nconfig"=
 if I
> search for it with F8.
> I attached another log with modprobe.blacklist=3Dsnd_soc_rl6347a plus
> modprobe.d entries: https://bugzilla.kernel.org/attachment.cgi?id=3D1=
89361

What if you disable the whole ALSA SoC?

CONFIG_SND_SOC=3Dn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
