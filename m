From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 15:34:16 +0200
Message-ID: <4E11C158.7050405@fedoraproject.org>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org> <4E117E61.2050808@sylvestre.me> <1309769864.1896.113.camel@rui> <4E11A4AA.2090106@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:34321 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1GDNeV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2011 09:34:21 -0400
In-Reply-To: <4E11A4AA.2090106@fedoraproject.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Marco Chiappero <marco@absence.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>

On 07/04/2011 01:31 PM, Michel Alexandre Salim wrote:
> Hi Rui,
>=20
> They apply cleanly on top of 3.0-rc5, but I'm getting a
> warning-treated-as-failure. Which kernel tree am I supposed to be
> applying this to -- linus' 3.0-rc5, a post-rc5 commit, drm-intel-fixe=
s
> or drm-intel-next?
>=20
> Thanks -- Michel
>=20
>   CC [M]  drivers/gpu/drm/i915/i915_drv.o
>   CC [M]  drivers/gpu/drm/i915/i915_dma.o
>   CC [M]  drivers/gpu/drm/i915/i915_irq.o
> drivers/gpu/drm/i915/i915_irq.c: In function =E2=80=98ivybridge_irq_h=
andler=E2=80=99:
> drivers/gpu/drm/i915/i915_irq.c:505:3: error: implicit declaration of
> function =E2=80=98intel_opregion_gse_intr=E2=80=99 [-Werror=3Dimplici=
t-function-declaration]
> cc1: some warnings being treated as errors
>=20
> make[4]: *** [drivers/gpu/drm/i915/i915_irq.o] Error 1
> make[3]: *** [drivers/gpu/drm/i915] Error 2
> make[2]: *** [drivers/gpu/drm] Error 2
> make[1]: *** [drivers/gpu] Error 2
> make: *** [drivers] Error 2
>=20
And if I comment out those two lines, compile finishes but fails becaus=
e
of undefined references -- seems like there's an Ivybridge-specific
references from another patch that I don't have.

Kernel: arch/x86/boot/bzImage is ready  (#3)
  Building modules, stage 2.
  MODPOST 2369 modules
ERROR: "igd_opregion_init" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "igd_opregion_intr" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "igd_opregion_enable_asle" [drivers/gpu/drm/i915/i915.ko] undefi=
ned!
ERROR: "igd_opregion_setup" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "igd_opregion_fini" [drivers/gpu/drm/i915/i915.ko] undefined!
WARNING: modpost: Found 3 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

> On 07/04/2011 10:57 AM, Zhang Rui wrote:
>> Hi, Michael,
>>
>> please check if the two patches attached help.
>>
>> thanks,
>> rui
>>
>> On Mon, 2011-07-04 at 16:48 +0800, Michel Alexandre Salim wrote:
>>> On 07/04/2011 10:46 AM, Michel Alexandre Salim wrote:
>>>> Here are the ectool dumps, before setting any brightness (backligh=
t=3D0),
>>>> after setting it to 5, and after setting it to 3, plus the typescr=
ipt
>>>> log of the commands issued and the sysfs readings.
>>>>
>>>> I then set brightness back to 0 (ec-after3.txt) -- didn't log the
>>>> keyboard interactions because it's the same (value for brightness
>>>> concurs with what is set, but actual_brightness is still -1)
>>>>
>>>> Let me know if you need anything else. Once we can at least pinpoi=
nt the
>>>> problem to the right subsystem, I'll add these attachments to the
>>>> correct bug report.
>>>>
>>>> Thanks,
>>>>
>>> And here's the last dump file, forgot to attach it earlier.
>>>
>>> Thanks,
>>>
>=20
>=20


--=20
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
