From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 13:31:54 +0200
Message-ID: <4E11A4AA.2090106@fedoraproject.org>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org> <4E117E61.2050808@sylvestre.me> <1309769864.1896.113.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1309769864.1896.113.camel@rui>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Marco Chiappero <marco@absence.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

Hi Rui,

They apply cleanly on top of 3.0-rc5, but I'm getting a
warning-treated-as-failure. Which kernel tree am I supposed to be
applying this to -- linus' 3.0-rc5, a post-rc5 commit, drm-intel-fixes
or drm-intel-next?

Thanks -- Michel

  CC [M]  drivers/gpu/drm/i915/i915_drv.o
  CC [M]  drivers/gpu/drm/i915/i915_dma.o
  CC [M]  drivers/gpu/drm/i915/i915_irq.o
drivers/gpu/drm/i915/i915_irq.c: In function =E2=80=98ivybridge_irq_han=
dler=E2=80=99:
drivers/gpu/drm/i915/i915_irq.c:505:3: error: implicit declaration of
function =E2=80=98intel_opregion_gse_intr=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
cc1: some warnings being treated as errors

make[4]: *** [drivers/gpu/drm/i915/i915_irq.o] Error 1
make[3]: *** [drivers/gpu/drm/i915] Error 2
make[2]: *** [drivers/gpu/drm] Error 2
make[1]: *** [drivers/gpu] Error 2
make: *** [drivers] Error 2

On 07/04/2011 10:57 AM, Zhang Rui wrote:
> Hi, Michael,
>=20
> please check if the two patches attached help.
>=20
> thanks,
> rui
>=20
> On Mon, 2011-07-04 at 16:48 +0800, Michel Alexandre Salim wrote:
>> On 07/04/2011 10:46 AM, Michel Alexandre Salim wrote:
>>> Here are the ectool dumps, before setting any brightness (backlight=
=3D0),
>>> after setting it to 5, and after setting it to 3, plus the typescri=
pt
>>> log of the commands issued and the sysfs readings.
>>>
>>> I then set brightness back to 0 (ec-after3.txt) -- didn't log the
>>> keyboard interactions because it's the same (value for brightness
>>> concurs with what is set, but actual_brightness is still -1)
>>>
>>> Let me know if you need anything else. Once we can at least pinpoin=
t the
>>> problem to the right subsystem, I'll add these attachments to the
>>> correct bug report.
>>>
>>> Thanks,
>>>
>> And here's the last dump file, forgot to attach it earlier.
>>
>> Thanks,
>>


--=20
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
