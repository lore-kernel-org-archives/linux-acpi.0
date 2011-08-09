From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH v2 1/2] x86: Enable fast strings on Intel if BIOS hasn't already
Date: Tue, 9 Aug 2011 11:12:38 -0400
Message-ID: <CAObL_7GA4BDvVfERqdK3XnTnwRdG+Zdp9EjZPtEQjWFvnSSO5Q@mail.gmail.com>
References: <cover.1312630712.git.luto@mit.edu> <9a8f28ccbe44cd323a01e9a23b531cb869185a21.1312630712.git.luto@mit.edu>
 <493994B35A117E4F832F97C4719C4C040132C5FB69@orsmsx505.amr.corp.intel.com>
 <CAObL_7F2+eXTPo7a631Lh7GD_UpDQXgW_GSDp9Km7pwhwmM6Cw@mail.gmail.com>
 <493994B35A117E4F832F97C4719C4C040132C5FBE0@orsmsx505.amr.corp.intel.com> <20110809150035.GE28228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41784 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab1HIPNB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2011 11:13:01 -0400
In-Reply-To: <20110809150035.GE28228@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Aug 9, 2011 at 11:00 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Yu, Fenghua <fenghua.yu@intel.com> wrote:
>
>> > -----Original Message-----
>> > From: amluto@gmail.com [mailto:amluto@gmail.com] On Behalf Of Andr=
ew
>> > Lutomirski
>> > Sent: Saturday, August 06, 2011 4:32 PM
>> > To: Yu, Fenghua
>> > Cc: x86@kernel.org; linux-kernel@vger.kernel.org; Matthew Garrett;=
 Len
>> > Brown; linux-acpi@vger.kernel.org; Ingo Molnar
>> > Subject: Re: [PATCH v2 1/2] x86: Enable fast strings on Intel if B=
IOS
>> > hasn't already
>> >
>> > On Sat, Aug 6, 2011 at 3:33 PM, Yu, Fenghua <fenghua.yu@intel.com>
>> > wrote:
>> > >> -----Original Message-----
>> > >> From: Andy Lutomirski [mailto:luto@MIT.EDU]
>> > >> Sent: Saturday, August 06, 2011 4:43 AM
>> > >> To: x86@kernel.org; linux-kernel@vger.kernel.org
>> > >> Cc: Yu, Fenghua; Matthew Garrett; Len Brown; linux-
>> > >> acpi@vger.kernel.org; Ingo Molnar; Andy Lutomirski
>> > >> Subject: [PATCH v2 1/2] x86: Enable fast strings on Intel if BI=
OS
>> > >> hasn't already
>> > >>
>> > >> Intel SDM volume 3A, 8.4.2 says:
>> > >>
>> > >> =A0 Software can disable fast-string operation by clearing the
>> > >> =A0 fast-string-enable bit (bit 0) of IA32_MISC_ENABLE MSR.
>> > >> =A0 However, Intel recomments that system software always enabl=
e
>> > >> =A0 fast-string operation.
>> > >>
>> > >> The Intel DQ67SW board (with latest BIOS) disables fast string
>> > >> operations if TXT is enabled. =A0A Lenovo X220 disables it rega=
rdless
>> > >> of TXT setting. =A0I doubt I'm the only person with a dumb BIOS=
 like
>> > >> this.
>> > >>
>> > >> Signed-off-by: Andy Lutomirski <luto@mit.edu>
>> > >> ---
>> > >> =A0arch/x86/kernel/cpu/intel.c | =A0 25 ++++++++++++++++++++++-=
--
>> > >> =A01 files changed, 22 insertions(+), 3 deletions(-)
>> > >>
>> > >> diff --git a/arch/x86/kernel/cpu/intel.c
>> > b/arch/x86/kernel/cpu/intel.c
>> > >> index ed6086e..c80ab41 100644
>> > >> --- a/arch/x86/kernel/cpu/intel.c
>> > >> +++ b/arch/x86/kernel/cpu/intel.c
>> > >> @@ -30,6 +30,7 @@
>> > >> =A0static void __cpuinit early_init_intel(struct cpuinfo_x86 *c=
)
>> > >> =A0{
>> > >> =A0 =A0 =A0 u64 misc_enable;
>> > >> + =A0 =A0 bool allow_fast_string =3D true;
>> > >>
>> > >> =A0 =A0 =A0 /* Unmask CPUID levels if masked: */
>> > >> =A0 =A0 =A0 if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model =
>=3D 0xd)) {
>> > >> @@ -118,8 +119,9 @@ static void __cpuinit early_init_intel(stru=
ct
>> > >> cpuinfo_x86 *c)
>> > >> =A0 =A0 =A0 =A0* (model 2) with the same problem.
>> > >> =A0 =A0 =A0 =A0*/
>> > >> =A0 =A0 =A0 if (c->x86 =3D=3D 15) {
>> > >> - =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_ena=
ble);
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 allow_fast_string =3D false;
>> > >>
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_ena=
ble);
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (misc_enable & MSR_IA32_MISC_ENA=
BLE_FAST_STRING) {
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "k=
memcheck: Disabling fast
>> > string
>> > >> operations\n");
>> > >>
>> > >> @@ -130,11 +132,28 @@ static void __cpuinit early_init_intel(st=
ruct
>> > >> cpuinfo_x86 *c)
>> > >> =A0#endif
>> > >>
>> > >> =A0 =A0 =A0 /*
>> > >> - =A0 =A0 =A0* If fast string is not enabled in IA32_MISC_ENABL=
E for any
>> > >> reason,
>> > >> - =A0 =A0 =A0* clear the fast string and enhanced fast string C=
PU
>> > >> capabilities.
>> > >> + =A0 =A0 =A0* If BIOS didn't enable fast string operation, try=
 to enable
>> > >> + =A0 =A0 =A0* it ourselves. =A0If that fails, then clear the f=
ast string
>> > >> + =A0 =A0 =A0* and enhanced fast string CPU capabilities.
>> > >> =A0 =A0 =A0 =A0*/
>> > >> =A0 =A0 =A0 if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model =
>=3D 0xd)) {
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_ENABLE, misc_e=
nable);
>> > >> +
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 if (allow_fast_string &&
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(misc_enable & MSR_IA32_MISC=
_ENABLE_FAST_STRING))
>> > {
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 misc_enable |=3D
>> > MSR_IA32_MISC_ENABLE_FAST_STRING;
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrmsr_safe(MSR_IA32_M=
ISC_ENABLE,
>> > (u32)misc_enable,
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(u32)(misc_enable >> 32));
>> > >> +
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-read to make su=
re it stuck. */
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdmsrl(MSR_IA32_MISC_=
ENABLE, misc_enable);
>> > >> +
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (misc_enable &
>> > MSR_IA32_MISC_ENABLE_FAST_STRING)
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print=
k(KERN_WARNING FW_WARN "CPU #%d:
>> > "
>> > >> +
>> > =A0"IA32_MISC_ENABLE.FAST_STRING_ENABLE "
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"was not set", c->cpu_index);
>> > > This printk is redundant because the same info is dumped in the =
below
>> > printk. Plus it's not firmware's issue if we can not set fast stri=
ng
>> > bit 0 in MISC_ENABLE register. So I don't think FW_WARN is right.
>> >
>> > Huh? =A0This is the success path -- the patch prints the warning i=
f
>> > flipping the bit worked...
>>
>> Ok. I see.
>>
>> Still I would suggest to remove this printk. This info will be
>> printed on every single CPU if BIOS doesn't enable fast string.
>
> just do printk_once(). We want to inform the user that something's
> going on.

Already there in v3.

--Andy

>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
