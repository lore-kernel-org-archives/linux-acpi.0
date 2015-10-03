From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Sat, 03 Oct 2015 12:11:54 +0200
Message-ID: <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151002101919.GZ1551@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On venerd=C3=AC 2 ottobre 2015 12:19:19 CEST, Mika Westerberg wrote:
> On Fri, Oct 02, 2015 at 11:59:38AM +0200, Niccol=C3=B2 Belli wrote:
>> Hi,
>> This laptop suffers of random kernel hangs at boot: I tested kernel =
4.1.8,
>> 4.2.1 and 4.3-rc3 and they are all affected.
>> Every time I turn on my laptop I have to boot several times to be ab=
le to
>> reach the sddm login because often I get hangs which prevent=20
>> the system to ...
>
> Does it work any better if you blacklist the crashing module
> "snd_soc_rl6347a" (or set CONFIG_SND_SOC_RL6347A=3Dn)?
>

Hi,
I tried to blacklist the crashing module (snd_soc_rl6347a) without any=20
success: it still loads. I booted kernel with=20
modprobe.blacklist=3Dsnd_soc_rl6347a and I put "blacklist snd_soc_rl634=
7a" in=20
/etc/modprobe.d/blacklist.conf. I even tried to recompile the kernel=20
without that module, but there is no option in "make nconfig" to disabl=
e=20
it, while adding "# CONFIG_SND_SOC_RL6347A is not set" to the config=20
doesn't help because it keeps showing CONFIG_SND_SOC_RL6347A=3Dm in "ma=
ke=20
nconfig" if I search for it with F8.
I attached another log with modprobe.blacklist=3Dsnd_soc_rl6347a plus=20
modprobe.d entries: https://bugzilla.kernel.org/attachment.cgi?id=3D189=
361

Thanks,
Niccol=C3=B2 Belli
