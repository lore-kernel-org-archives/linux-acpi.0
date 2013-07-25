From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in reduced
 hardware sleep path
Date: Thu, 25 Jul 2013 01:54:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802435734@SHSMSX101.ccr.corp.intel.com>
References: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
	<1372255575-29567-2-git-send-email-benjamin.guthro@citrix.com>
	<1AE640813FDE7649BE1B193DEA596E880241B363@SHSMSX101.ccr.corp.intel.com>
	<51D2BCB7.5040105@citrix.com>
	<1AE640813FDE7649BE1B193DEA596E88024352D2@SHSMSX101.ccr.corp.intel.com>
	<51EFC1FE.5000609@citrix.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E36FEA87FF@ORSMSX103.amr.corp.intel.com>
	<51EFD536.8070209@citrix.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E36FEA884D@ORSMSX103.amr.corp.intel.com>
	<51EFEF3E.8020001@citrix.com>	<20130724163214.GB6308@phenom.dumpdata.com>
	<1AE640813FDE7649BE1B193DEA596E88024356ED@SHSMSX101.ccr.corp.intel.com>
 <CAOvdn6WZFu7TssoML3J9SPpqH_AKSi4cjvZ7Tb0zdBtq46QO0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35803 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab3GYByz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jul 2013 21:54:55 -0400
In-Reply-To: <CAOvdn6WZFu7TssoML3J9SPpqH_AKSi4cjvZ7Tb0zdBtq46QO0Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Moore, Robert" <robert.moore@intel.com>, Jan Beulich <jbeulich@suse.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

Yes, I agree.
As what I've said, it's up to the others to determine if the patch is O=
K.
I just need to make my concerns visible in the community. :-)

Thanks and best regards
-Lv

=46rom: ben.guthro@gmail.com [mailto:ben.guthro@gmail.com] On Behalf Of=
 Ben Guthro
Sent: Thursday, July 25, 2013 9:38 AM

I'm afraid this is well outside of the scope of the bug I was trying to=
 fix.
Given the interactions with the acpi code I have had so far - I am some=
what disinclined to make such sweeping changes.

I guess any distro supporting Xen, or tboot will have to carry a patch =
to avoid such a bug.


On Wed, Jul 24, 2013 at 9:28 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
Let me just give an example to let you know the difficulties for ACPICA=
 developers to merge Xen's acpi_os_prepare_sleep.

The original logic in the acpi_hw_legacy_sleep is:
111 =A0 =A0 =A0 =A0 /* Get current value of PM1A control */
112
113 =A0 =A0 =A0 =A0 status =3D acpi_hw_register_read(ACPI_REGISTER_PM1_=
CONTROL,
114 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&pm1a_control);
115 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
116 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);
117 =A0 =A0 =A0 =A0 }
118 =A0 =A0 =A0 =A0 ACPI_DEBUG_PRINT((ACPI_DB_INIT,
119 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Entering sleep=
 state [S%u]\n", sleep_state));
120
121 =A0 =A0 =A0 =A0 /* Clear the SLP_EN and SLP_TYP fields */
122
123 =A0 =A0 =A0 =A0 pm1a_control &=3D ~(sleep_type_reg_info->access_bit=
_mask |
124 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_enable_re=
g_info->access_bit_mask);
125 =A0 =A0 =A0 =A0 pm1b_control =3D pm1a_control;
126
127 =A0 =A0 =A0 =A0 /* Insert the SLP_TYP bits */
128
129 =A0 =A0 =A0 =A0 pm1a_control |=3D
130 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_gbl_sleep_type_a << sleep_type_reg_in=
fo->bit_position);
131 =A0 =A0 =A0 =A0 pm1b_control |=3D
132 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_gbl_sleep_type_b << sleep_type_reg_in=
fo->bit_position);
133
134 =A0 =A0 =A0 =A0 /*
135 =A0 =A0 =A0 =A0 =A0* We split the writes of SLP_TYP and SLP_EN to w=
orkaround
136 =A0 =A0 =A0 =A0 =A0* poorly implemented hardware.
137 =A0 =A0 =A0 =A0 =A0*/
138
139 =A0 =A0 =A0 =A0 /* Write #1: write the SLP_TYP data to the PM1 Cont=
rol registers */
140
141 =A0 =A0 =A0 =A0 status =3D acpi_hw_write_pm1_control(pm1a_control, =
pm1b_control);
142 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
143 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);
144 =A0 =A0 =A0 =A0 }
145
146 =A0 =A0 =A0 =A0 /* Insert the sleep enable (SLP_EN) bit */
147
148 =A0 =A0 =A0 =A0 pm1a_control |=3D sleep_enable_reg_info->access_bit=
_mask;
149 =A0 =A0 =A0 =A0 pm1b_control |=3D sleep_enable_reg_info->access_bit=
_mask;
150
151 =A0 =A0 =A0 =A0 /* Flush caches, as per ACPI specification */
152
153 =A0 =A0 =A0 =A0 ACPI_FLUSH_CPU_CACHE();
154
=3D=3D=3D=3D=3D=3D=3D
[Now Xen's hook appears here)
=3D=3D=3D=3D=3D=3D=3D
161 =A0 =A0 =A0 =A0 /* Write #2: Write both SLP_TYP + SLP_EN */
162
163 =A0 =A0 =A0 =A0 status =3D acpi_hw_write_pm1_control(pm1a_control, =
pm1b_control);
164 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
165 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);
166 =A0 =A0 =A0 =A0 }

If the whole block is re-implemented by ACPICA in the future:

Acpi_hw_write_field_register(ACPI_SLEEP_REGISTER, ACPI_SLP_TYPE | ACPI_=
SLP_EN, slp_type | slp_en);

Then where should ACPICA put this hook under the new design?
Can it go inside acpi_hw_write_field_register?
If the hook is in the current position, then future ACPICA development =
work on the suspend/resume codes are likely broken.

IMO,
1. acpi_os_preapre_sleep() should be put before Line 111
2. acpi_os_preapre_sleep()'s parameters should be re-designed
3. Xen only register hacking logic should be put inside acpi_os_prepare=
_sleep().

Hope the above example can make my concern clearer now. :-)

Thanks
-Lv

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org
> [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Konrad Rzeszut=
ek Wilk
> Sent: Thursday, July 25, 2013 12:32 AM
> To: Ben Guthro
> Cc: Moore, Robert; Zheng, Lv; Jan Beulich; Rafael J . Wysocki;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> xen-devel@lists.xen.org
> Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in =
reduced
> hardware sleep path
>
> On Wed, Jul 24, 2013 at 11:14:06AM -0400, Ben Guthro wrote:
> >
> >
> > On 07/24/2013 10:38 AM, Moore, Robert wrote:
> > > I haven't found a high-level description of "acpi_os_prepare_slee=
p",
> perhaps I missed it.
> > >
> > > Can someone point me to the overall description of this change an=
d why it is
> being considered?
> >
> > Hi Bob,
> >
> > For this series, the v6 of this series does a decent job of what it=
 is
> > trying to accomplish:
> > https://lkml.org/lkml/2013/7/1/205
> >
> > However, I recognize that this does not really describe *why*
> > acpi_os_prepare_sleep is necessary to begin with. For that, we need=
 to
> > go back a little more.
> >
> > The summary for the series that introduced it is a good description=
,
> > of the reasons it is necessary:
> > http://lkml.indiana.edu/hypermail/linux/kernel/1112.2/00450.html
> >
> > In summary though - in the case of Xen (and I believe this is also
> > true in tboot) a value inappropriate for a VM (which dom0 is a spec=
ial
> > case
> > of) was being written to cr3, and the physical machine would never
> > come out of S3.
> >
> > This mechanism gives an os specific hook to do something else down =
at
> > the lower levels, while still being able to take advantage of the
> > large amount of OS independent code in ACPICA.
>
> It might be also prudent to look at original 'hook' that was added by=
 Intel in the
> Linux code to support TXT:
>
>
> commit 86886e55b273f565935491816c7c96b82469d4f8
> Author: Joseph Cihula <joseph.cihula@intel.com>
> Date: =A0 Tue Jun 30 19:31:07 2009 -0700
>
> =A0 =A0 x86, intel_txt: Intel TXT Sx shutdown support
>
> =A0 =A0 Support for graceful handling of sleep states (S3/S4/S5) afte=
r an Intel(R)
> TXT launch.
>
> =A0 =A0 Without this patch, attempting to place the system in one of =
the ACPI
> sleep
> =A0 =A0 states (S3/S4/S5) will cause the TXT hardware to treat this a=
s an attack
> and
> =A0 =A0 will cause a system reset, with memory locked. =A0Not only ma=
y the
> subsequent
> =A0 =A0 memory scrub take some time, but the platform will be unable =
to enter
> the
> =A0 =A0 requested power state.
>
> =A0 =A0 This patch calls back into the tboot so that it may properly =
and securely
> clean
> =A0 =A0 up system state and clear the secrets-in-memory flag, after w=
hich it will
> place
> =A0 =A0 the system into the requested sleep state using ACPI informat=
ion passed
> by the kernel.
>
> =A0 =A0 =A0arch/x86/kernel/smpboot.c =A0 =A0 | =A0 =A02 ++
> =A0 =A0 =A0drivers/acpi/acpica/hwsleep.c | =A0 =A03 +++
> =A0 =A0 =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07=
 ++++++-
> =A0 =A0 =A03 files changed, 11 insertions(+), 1 deletion(-)
>
> =A0 =A0 Signed-off-by: Joseph Cihula <joseph.cihula@intel.com>
> =A0 =A0 Signed-off-by: Shane Wang <shane.wang@intel.com>
> =A0 =A0 Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>
> I suspect that if tboot was used with a different OS (Solaris?) it wo=
uld hit the
> same case and a similar hook would be needed.
>
> Said 'hook' (which was a call to tboot_sleep) was converted to be a m=
ore
> neutral 'acpi_os_prepare_sleep' which tboot can use (and incidently X=
en too).
>
> I think what Bob is saying that if said hook is neccessary (and I bel=
ieve it is - and
> Intel TXT maintainer thinks so too since he added it in the first pla=
ce), then the
> right way of adding it is via the ACPICA tree.
>
> Should the discussion for this be moved there ? (https://acpica.org/c=
ommunity)
> and an generic 'os_prepare_sleep' patch added in
> git://github.com/acpica/acpica.git?
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
Please read the FAQ at =A0http://www.tux.org/lkml/

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
