From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [2.6.33-rc2] ACPI problems on HP nc6400 notebook
Date: Fri, 25 Dec 2009 12:15:49 +0100
Message-ID: <2d0a357f0912250315r1f3922e1ta731d03a313d69c6@mail.gmail.com>
References: <2d0a357f0912241711o97011od6c1750d7acf8b9e@mail.gmail.com>
	 <4B3413C4.6070602@gmail.com>
	 <2d0a357f0912250048h2bc987ccs4d4d253a4155becf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:2433 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZLYLPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Dec 2009 06:15:51 -0500
In-Reply-To: <2d0a357f0912250048h2bc987ccs4d4d253a4155becf@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, maciej.rutecki@gmail.com, landgraf@ru.ru, linux-acpi@vger.kernel.org

[CCed linux-acpi ML, maciej.rutecki@gmail.com and landgraf@ru.ru]
(see [2] and [3])

GOTCHA!

I reverted patches introduced in:

commit 2969cd482ebe9c5b82d55917b0cd41175eff042a:
"Merge branch 'misc-2.6.33' into release"

=2E..and now I could boot into 2.6.33-rc2.

Here the revert-acpi-patches:

$ ls debian/patches/revert-acpi-patches/
0001-Revert-hp-wmi-Fix-two-memleaks.patch
0002-Revert-acer-wmi-msi-wmi-Remove-needless-DMI-MODULE_A.patch
0003-Revert-dell-wmi-do-not-keep-driver-loaded-on-unsuppo.patch
0004-Revert-wmi-Free-the-allocated-acpi-objects-through-w.patch
0005-Revert-drivers-platform-x86-acerhdf.c-check-BIOS-inf.patch
0006-Revert-acerhdf-add-new-BIOS-versions.patch
0007-Revert-acerhdf-limit-modalias-matching-to-supported.patch
0008-Revert-toshiba_acpi-convert-to-seq_file.patch
0009-Revert-asus_acpi-convert-to-seq_file.patch
0010-Revert-ACPI-do-not-select-ACPI_DOCK-from-ATA_ACPI.patch
0011-Revert-MAINTAINERS-add-maintainer-for-msi-wmi-driver.patch
0012-Revert-fujitu-laptop-fix-tests-of-acpi_evaluate_inte.patch
0013-Revert-arch-x86-kernel-cpu-cpufreq-acpi-cpufreq.c-av.patch

In [1] you can find revert-acpi-patchset, dmesg & lspci outputs of my
new kernel.

Marciej and Werner can you please verify or dig deeper by partially
excluding the single reverts?
Thank you.

Kind Regards,
- Sedat -

[1] http://files.iniza.org/linux-kernel/BUG_2.6.33-rc2/
[2] http://marc.info/?l=3Dlinux-kernel&m=3D126171951030608&w=3D2
[3] http://marc.info/?l=3Dlinux-kernel&m=3D126173586309724&w=3D2

On Fri, Dec 25, 2009 at 9:48 AM, Sedat Dilek <sedat.dilek@googlemail.co=
m> wrote:
> Hi,
>
> as I suspected it is an ACPI issue while I tried to boot with "acpi=3D=
off".
>
> I have taken new screenshots and added dmesg (acpi=3Doff) and all
> messages in /var/log/* [1].
>
> It is possible to load acpi kernel-module afterwards?
> Or it is not possible whenn loading with acpi=3Doff?
>
> @Len Brown:
> There are two photos showing thermal problems.
> Notebook did shut down in the night.
> But this was before 2.6.33-rc2.
>
> I will not try a bisect (visting currently my brother and working wit=
h
> touchpad really sucks), but I will revert the wmi-related (wmi/hp-wmi=
)
> commits.
> There seems problems with wmi on other systems w/ 2.6.33-rc2 [2].
>
> Kind Regards,
> - Sedat -
>
> [1] http://files.iniza.org/linux-kernel/BUG_2.6.33-rc2/
> [2] http://marc.info/?l=3Dlinux-kernel&m=3D126171951030608&w=3D2
>
> On Fri, Dec 25, 2009 at 2:22 AM, Justin P. Mattock
> <justinmattock@gmail.com> wrote:
>> On 12/24/09 17:11, Sedat Dilek wrote:
>>>
>>> Hi,
>>>
>>> I build linux-2.6.33-rc2 on a Debian/sid 32-bit host.
>>> Unfortunately, this kernel falls in an unusable state (sort of loop=
)
>>> and does not a normal startup.
>>>
>>> With this setting (see below), I hoped to catch the early
>>> boot-messages (but, no success):
>>>
>>> # cat /etc/default/bootlogd
>>> # Run bootlogd at startup ?
>>> BOOTLOGD_ENABLE=3DYes
>>>
>>> Finally, I could take a picture [1].
>>> It seems to be that latest ACPI patches are breaking my system
>>> (speculating).
>>>
>>> Q: How can I log such early boot (error) messages to give a detaill=
ed log?
>>>
>>> Hope this helps fixing the problem.
>>>
>>> Kind Regards,
>>> - Sedat -
>>>
>>>
>>> [1] http://files.iniza.org/linux-kernel/DSCN2134.JPG
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>>
>>
>> you can try(if you have the port)
>> ohci1394_dma=3Dearly or the usb
>> early logging located in kernel hacking.
>>
>> but if this thing is hitting way early it
>> might be a bit more tricky.
>>
>> if you can try =C2=A0a bisect from the bad
>> kernel to the good.
>>
>> Justin P. Mattock
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
