From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 1/2] x86: Enable fast strings on Intel if BIOS hasn't
 already
Date: Sun, 7 Aug 2011 16:44:33 -0700
Message-ID: <493994B35A117E4F832F97C4719C4C040132C5FBE0@orsmsx505.amr.corp.intel.com>
References: <cover.1312630712.git.luto@mit.edu>
 <9a8f28ccbe44cd323a01e9a23b531cb869185a21.1312630712.git.luto@mit.edu>
 <493994B35A117E4F832F97C4719C4C040132C5FB69@orsmsx505.amr.corp.intel.com>
 <CAObL_7F2+eXTPo7a631Lh7GD_UpDQXgW_GSDp9Km7pwhwmM6Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59094 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab1HGXpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Aug 2011 19:45:24 -0400
In-Reply-To: <CAObL_7F2+eXTPo7a631Lh7GD_UpDQXgW_GSDp9Km7pwhwmM6Cw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

> -----Original Message-----
> From: amluto@gmail.com [mailto:amluto@gmail.com] On Behalf Of Andrew
> Lutomirski
> Sent: Saturday, August 06, 2011 4:32 PM
> To: Yu, Fenghua
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; Matthew Garrett; Le=
n
> Brown; linux-acpi@vger.kernel.org; Ingo Molnar
> Subject: Re: [PATCH v2 1/2] x86: Enable fast strings on Intel if BIOS
> hasn't already
>=20
> On Sat, Aug 6, 2011 at 3:33 PM, Yu, Fenghua <fenghua.yu@intel.com>
> wrote:
> >> -----Original Message-----
> >> From: Andy Lutomirski [mailto:luto@MIT.EDU]
> >> Sent: Saturday, August 06, 2011 4:43 AM
> >> To: x86@kernel.org; linux-kernel@vger.kernel.org
> >> Cc: Yu, Fenghua; Matthew Garrett; Len Brown; linux-
> >> acpi@vger.kernel.org; Ingo Molnar; Andy Lutomirski
> >> Subject: [PATCH v2 1/2] x86: Enable fast strings on Intel if BIOS
> >> hasn't already
> >>
> >> Intel SDM volume 3A, 8.4.2 says:
> >>
> >> =A0 Software can disable fast-string operation by clearing the
> >> =A0 fast-string-enable bit (bit 0) of IA32_MISC_ENABLE MSR.
> >> =A0 However, Intel recomments that system software always enable
> >> =A0 fast-string operation.
> >>
> >> The Intel DQ67SW board (with latest BIOS) disables fast string
> >> operations if TXT is enabled. =A0A Lenovo X220 disables it regardl=
ess
> >> of TXT setting. =A0I doubt I'm the only person with a dumb BIOS li=
ke
> >> this.
> >>
> >> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> >> ---
> >> =A0arch/x86/kernel/cpu/intel.c | =A0 25 ++++++++++++++++++++++---
> >> =A01 files changed, 22 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/intel.c
> b/arch/x86/kernel/cpu/intel.c
> >> index ed6086e..c80ab41 100644
> >> --- a/arch/x86/kernel/cpu/intel.c
> >> +++ b/arch/x86/kernel/cpu/intel.c
> >> @@ -30,6 +30,7 @@
> >> =A0static void __cpuinit early_init_intel(struct cpuinfo_x86 *c)
> >> =A0{
> >> =A0 =A0 =A0 u64 misc_enable;
> >> + =A0 =A0 bool allow_fast_string =3D true;
> >>
> >> =A0 =A0 =A0 /* Unmask CPUID levels if masked: */
> >> =A0 =A0 =A0 if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model >=3D=
 0xd)) {
> >> @@ -118,8 +119,9 @@ static void __cpuinit early_init_intel(struct
> >> cpuinfo_x86 *c)
> >> =A0 =A0 =A0 =A0* (model 2) with the same problem.
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 if (c->x86 =3D=3D 15) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable=
);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 allow_fast_string =3D false;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable=
);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (misc_enable & MSR_IA32_MISC_ENABLE=
_FAST_STRING) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "kmem=
check: Disabling fast
> string
> >> operations\n");
> >>
> >> @@ -130,11 +132,28 @@ static void __cpuinit early_init_intel(struc=
t
> >> cpuinfo_x86 *c)
> >> =A0#endif
> >>
> >> =A0 =A0 =A0 /*
> >> - =A0 =A0 =A0* If fast string is not enabled in IA32_MISC_ENABLE f=
or any
> >> reason,
> >> - =A0 =A0 =A0* clear the fast string and enhanced fast string CPU
> >> capabilities.
> >> + =A0 =A0 =A0* If BIOS didn't enable fast string operation, try to=
 enable
> >> + =A0 =A0 =A0* it ourselves. =A0If that fails, then clear the fast=
 string
> >> + =A0 =A0 =A0* and enhanced fast string CPU capabilities.
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model >=3D=
 0xd)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_enab=
le);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (allow_fast_string &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(misc_enable & MSR_IA32_MISC_EN=
ABLE_FAST_STRING))
> {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 misc_enable |=3D
> MSR_IA32_MISC_ENABLE_FAST_STRING;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrmsr_safe(MSR_IA32_MISC=
_ENABLE,
> (u32)misc_enable,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
u32)(misc_enable >> 32));
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-read to make sure =
it stuck. */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENA=
BLE, misc_enable);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (misc_enable &
> MSR_IA32_MISC_ENABLE_FAST_STRING)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(K=
ERN_WARNING FW_WARN "CPU #%d:
> "
> >> +
> =A0"IA32_MISC_ENABLE.FAST_STRING_ENABLE "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"was not set", c->cpu_index);
> > This printk is redundant because the same info is dumped in the bel=
ow
> printk. Plus it's not firmware's issue if we can not set fast string
> bit 0 in MISC_ENABLE register. So I don't think FW_WARN is right.
>=20
> Huh?  This is the success path -- the patch prints the warning if
> flipping the bit worked...

Ok. I see.

Still I would suggest to remove this printk. This info will be printed =
on every single CPU if BIOS doesn't enable fast string. This could floo=
d the log buffer on big machines or many threads machines. And the info=
 doesn't really provide useful message because we enable fast string in=
 OS anyway. Reporting BIOS issue by this info probably will be viewed a=
s low priority or ignored.=20

The following info is more important because it reports an abnormal beh=
avior.

Thanks.

-Fenghua
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
