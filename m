From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep
 hook in reduced hardware sleep path
Date: Wed, 24 Jul 2013 21:37:51 -0400
Message-ID: <CAOvdn6WZFu7TssoML3J9SPpqH_AKSi4cjvZ7Tb0zdBtq46QO0Q@mail.gmail.com>
References: <1372255575-29567-1-git-send-email-benjamin.guthro@citrix.com>
	<1372255575-29567-2-git-send-email-benjamin.guthro@citrix.com>
	<1AE640813FDE7649BE1B193DEA596E880241B363@SHSMSX101.ccr.corp.intel.com>
	<51D2BCB7.5040105@citrix.com>
	<1AE640813FDE7649BE1B193DEA596E88024352D2@SHSMSX101.ccr.corp.intel.com>
	<51EFC1FE.5000609@citrix.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E36FEA87FF@ORSMSX103.amr.corp.intel.com>
	<51EFD536.8070209@citrix.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E36FEA884D@ORSMSX103.amr.corp.intel.com>
	<51EFEF3E.8020001@citrix.com>
	<20130724163214.GB6308@phenom.dumpdata.com>
	<1AE640813FDE7649BE1B193DEA596E88024356ED@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3292476641010323111=="
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88024356ED@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Ben Guthro <Benjamin.Guthro@citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jan Beulich <jbeulich@suse.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>
List-Id: linux-acpi@vger.kernel.org

--===============3292476641010323111==
Content-Type: multipart/alternative; boundary=047d7b5d48a6107ab104e24c1326

--047d7b5d48a6107ab104e24c1326
Content-Type: text/plain; charset=ISO-8859-1

I'm afraid this is well outside of the scope of the bug I was trying to fix.
Given the interactions with the acpi code I have had so far - I am somewhat
disinclined to make such sweeping changes.

I guess any distro supporting Xen, or tboot will have to carry a patch to
avoid such a bug.


On Wed, Jul 24, 2013 at 9:28 PM, Zheng, Lv <lv.zheng@intel.com> wrote:

> Let me just give an example to let you know the difficulties for ACPICA
> developers to merge Xen's acpi_os_prepare_sleep.
>
> The original logic in the acpi_hw_legacy_sleep is:
> 111         /* Get current value of PM1A control */
> 112
> 113         status = acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
> 114                                        &pm1a_control);
> 115         if (ACPI_FAILURE(status)) {
> 116                 return_ACPI_STATUS(status);
> 117         }
> 118         ACPI_DEBUG_PRINT((ACPI_DB_INIT,
> 119                           "Entering sleep state [S%u]\n",
> sleep_state));
> 120
> 121         /* Clear the SLP_EN and SLP_TYP fields */
> 122
> 123         pm1a_control &= ~(sleep_type_reg_info->access_bit_mask |
> 124                           sleep_enable_reg_info->access_bit_mask);
> 125         pm1b_control = pm1a_control;
> 126
> 127         /* Insert the SLP_TYP bits */
> 128
> 129         pm1a_control |=
> 130             (acpi_gbl_sleep_type_a <<
> sleep_type_reg_info->bit_position);
> 131         pm1b_control |=
> 132             (acpi_gbl_sleep_type_b <<
> sleep_type_reg_info->bit_position);
> 133
> 134         /*
> 135          * We split the writes of SLP_TYP and SLP_EN to workaround
> 136          * poorly implemented hardware.
> 137          */
> 138
> 139         /* Write #1: write the SLP_TYP data to the PM1 Control
> registers */
> 140
> 141         status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
> 142         if (ACPI_FAILURE(status)) {
> 143                 return_ACPI_STATUS(status);
> 144         }
> 145
> 146         /* Insert the sleep enable (SLP_EN) bit */
> 147
> 148         pm1a_control |= sleep_enable_reg_info->access_bit_mask;
> 149         pm1b_control |= sleep_enable_reg_info->access_bit_mask;
> 150
> 151         /* Flush caches, as per ACPI specification */
> 152
> 153         ACPI_FLUSH_CPU_CACHE();
> 154
> =======
> [Now Xen's hook appears here)
> =======
> 161         /* Write #2: Write both SLP_TYP + SLP_EN */
> 162
> 163         status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
> 164         if (ACPI_FAILURE(status)) {
> 165                 return_ACPI_STATUS(status);
> 166         }
>
> If the whole block is re-implemented by ACPICA in the future:
>
> Acpi_hw_write_field_register(ACPI_SLEEP_REGISTER, ACPI_SLP_TYPE |
> ACPI_SLP_EN, slp_type | slp_en);
>
> Then where should ACPICA put this hook under the new design?
> Can it go inside acpi_hw_write_field_register?
> If the hook is in the current position, then future ACPICA development
> work on the suspend/resume codes are likely broken.
>
> IMO,
> 1. acpi_os_preapre_sleep() should be put before Line 111
> 2. acpi_os_preapre_sleep()'s parameters should be re-designed
> 3. Xen only register hacking logic should be put inside
> acpi_os_prepare_sleep().
>
> Hope the above example can make my concern clearer now. :-)
>
> Thanks
> -Lv
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org
> > [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Konrad Rzeszutek
> Wilk
> > Sent: Thursday, July 25, 2013 12:32 AM
> > To: Ben Guthro
> > Cc: Moore, Robert; Zheng, Lv; Jan Beulich; Rafael J . Wysocki;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> > xen-devel@lists.xen.org
> > Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in
> reduced
> > hardware sleep path
> >
> > On Wed, Jul 24, 2013 at 11:14:06AM -0400, Ben Guthro wrote:
> > >
> > >
> > > On 07/24/2013 10:38 AM, Moore, Robert wrote:
> > > > I haven't found a high-level description of "acpi_os_prepare_sleep",
> > perhaps I missed it.
> > > >
> > > > Can someone point me to the overall description of this change and
> why it is
> > being considered?
> > >
> > > Hi Bob,
> > >
> > > For this series, the v6 of this series does a decent job of what it is
> > > trying to accomplish:
> > > https://lkml.org/lkml/2013/7/1/205
> > >
> > > However, I recognize that this does not really describe *why*
> > > acpi_os_prepare_sleep is necessary to begin with. For that, we need to
> > > go back a little more.
> > >
> > > The summary for the series that introduced it is a good description,
> > > of the reasons it is necessary:
> > > http://lkml.indiana.edu/hypermail/linux/kernel/1112.2/00450.html
> > >
> > > In summary though - in the case of Xen (and I believe this is also
> > > true in tboot) a value inappropriate for a VM (which dom0 is a special
> > > case
> > > of) was being written to cr3, and the physical machine would never
> > > come out of S3.
> > >
> > > This mechanism gives an os specific hook to do something else down at
> > > the lower levels, while still being able to take advantage of the
> > > large amount of OS independent code in ACPICA.
> >
> > It might be also prudent to look at original 'hook' that was added by
> Intel in the
> > Linux code to support TXT:
> >
> >
> > commit 86886e55b273f565935491816c7c96b82469d4f8
> > Author: Joseph Cihula <joseph.cihula@intel.com>
> > Date:   Tue Jun 30 19:31:07 2009 -0700
> >
> >     x86, intel_txt: Intel TXT Sx shutdown support
> >
> >     Support for graceful handling of sleep states (S3/S4/S5) after an
> Intel(R)
> > TXT launch.
> >
> >     Without this patch, attempting to place the system in one of the ACPI
> > sleep
> >     states (S3/S4/S5) will cause the TXT hardware to treat this as an
> attack
> > and
> >     will cause a system reset, with memory locked.  Not only may the
> > subsequent
> >     memory scrub take some time, but the platform will be unable to enter
> > the
> >     requested power state.
> >
> >     This patch calls back into the tboot so that it may properly and
> securely
> > clean
> >     up system state and clear the secrets-in-memory flag, after which it
> will
> > place
> >     the system into the requested sleep state using ACPI information
> passed
> > by the kernel.
> >
> >      arch/x86/kernel/smpboot.c     |    2 ++
> >      drivers/acpi/acpica/hwsleep.c |    3 +++
> >      kernel/cpu.c                  |    7 ++++++-
> >      3 files changed, 11 insertions(+), 1 deletion(-)
> >
> >     Signed-off-by: Joseph Cihula <joseph.cihula@intel.com>
> >     Signed-off-by: Shane Wang <shane.wang@intel.com>
> >     Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> >
> > I suspect that if tboot was used with a different OS (Solaris?) it would
> hit the
> > same case and a similar hook would be needed.
> >
> > Said 'hook' (which was a call to tboot_sleep) was converted to be a more
> > neutral 'acpi_os_prepare_sleep' which tboot can use (and incidently Xen
> too).
> >
> > I think what Bob is saying that if said hook is neccessary (and I
> believe it is - and
> > Intel TXT maintainer thinks so too since he added it in the first
> place), then the
> > right way of adding it is via the ACPICA tree.
> >
> > Should the discussion for this be moved there ? (
> https://acpica.org/community)
> > and an generic 'os_prepare_sleep' patch added in
> > git://github.com/acpica/acpica.git?
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body
> > of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--047d7b5d48a6107ab104e24c1326
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m afraid this is well outside of the scope of the bug I was trying to=
 fix.<div>Given the interactions with the acpi code I have had so far - I a=
m somewhat disinclined to make such sweeping changes.</div><div><br></div>
<div>I guess any distro supporting Xen, or tboot will have to carry a patch=
 to avoid such a bug.</div><div><br></div><div><br><div class=3D"gmail_quot=
e">On Wed, Jul 24, 2013 at 9:28 PM, Zheng, Lv <span dir=3D"ltr">&lt;<a href=
=3D"mailto:lv.zheng@intel.com" target=3D"_blank">lv.zheng@intel.com</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Let me just give an example to let you know =
the difficulties for ACPICA developers to merge Xen&#39;s acpi_os_prepare_s=
leep.<br>

<br>
The original logic in the acpi_hw_legacy_sleep is:<br>
111 =A0 =A0 =A0 =A0 /* Get current value of PM1A control */<br>
112<br>
113 =A0 =A0 =A0 =A0 status =3D acpi_hw_register_read(ACPI_REGISTER_PM1_CONT=
ROL,<br>
114 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&amp;pm1a_control);<br>
115 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {<br>
116 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);<br>
117 =A0 =A0 =A0 =A0 }<br>
118 =A0 =A0 =A0 =A0 ACPI_DEBUG_PRINT((ACPI_DB_INIT,<br>
119 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Entering slee=
p state [S%u]\n&quot;, sleep_state));<br>
120<br>
121 =A0 =A0 =A0 =A0 /* Clear the SLP_EN and SLP_TYP fields */<br>
122<br>
123 =A0 =A0 =A0 =A0 pm1a_control &amp;=3D ~(sleep_type_reg_info-&gt;access_=
bit_mask |<br>
124 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_enable_reg_in=
fo-&gt;access_bit_mask);<br>
125 =A0 =A0 =A0 =A0 pm1b_control =3D pm1a_control;<br>
126<br>
127 =A0 =A0 =A0 =A0 /* Insert the SLP_TYP bits */<br>
128<br>
129 =A0 =A0 =A0 =A0 pm1a_control |=3D<br>
130 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_gbl_sleep_type_a &lt;&lt; sleep_type_reg_=
info-&gt;bit_position);<br>
131 =A0 =A0 =A0 =A0 pm1b_control |=3D<br>
132 =A0 =A0 =A0 =A0 =A0 =A0 (acpi_gbl_sleep_type_b &lt;&lt; sleep_type_reg_=
info-&gt;bit_position);<br>
133<br>
134 =A0 =A0 =A0 =A0 /*<br>
135 =A0 =A0 =A0 =A0 =A0* We split the writes of SLP_TYP and SLP_EN to worka=
round<br>
136 =A0 =A0 =A0 =A0 =A0* poorly implemented hardware.<br>
137 =A0 =A0 =A0 =A0 =A0*/<br>
138<br>
139 =A0 =A0 =A0 =A0 /* Write #1: write the SLP_TYP data to the PM1 Control =
registers */<br>
140<br>
141 =A0 =A0 =A0 =A0 status =3D acpi_hw_write_pm1_control(pm1a_control, pm1b=
_control);<br>
142 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {<br>
143 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);<br>
144 =A0 =A0 =A0 =A0 }<br>
145<br>
146 =A0 =A0 =A0 =A0 /* Insert the sleep enable (SLP_EN) bit */<br>
147<br>
148 =A0 =A0 =A0 =A0 pm1a_control |=3D sleep_enable_reg_info-&gt;access_bit_=
mask;<br>
149 =A0 =A0 =A0 =A0 pm1b_control |=3D sleep_enable_reg_info-&gt;access_bit_=
mask;<br>
150<br>
151 =A0 =A0 =A0 =A0 /* Flush caches, as per ACPI specification */<br>
152<br>
153 =A0 =A0 =A0 =A0 ACPI_FLUSH_CPU_CACHE();<br>
154<br>
=3D=3D=3D=3D=3D=3D=3D<br>
[Now Xen&#39;s hook appears here)<br>
=3D=3D=3D=3D=3D=3D=3D<br>
161 =A0 =A0 =A0 =A0 /* Write #2: Write both SLP_TYP + SLP_EN */<br>
162<br>
163 =A0 =A0 =A0 =A0 status =3D acpi_hw_write_pm1_control(pm1a_control, pm1b=
_control);<br>
164 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {<br>
165 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return_ACPI_STATUS(status);<br>
166 =A0 =A0 =A0 =A0 }<br>
<br>
If the whole block is re-implemented by ACPICA in the future:<br>
<br>
Acpi_hw_write_field_register(ACPI_SLEEP_REGISTER, ACPI_SLP_TYPE | ACPI_SLP_=
EN, slp_type | slp_en);<br>
<br>
Then where should ACPICA put this hook under the new design?<br>
Can it go inside acpi_hw_write_field_register?<br>
If the hook is in the current position, then future ACPICA development work=
 on the suspend/resume codes are likely broken.<br>
<br>
IMO,<br>
1. acpi_os_preapre_sleep() should be put before Line 111<br>
2. acpi_os_preapre_sleep()&#39;s parameters should be re-designed<br>
3. Xen only register hacking logic should be put inside acpi_os_prepare_sle=
ep().<br>
<br>
Hope the above example can make my concern clearer now. :-)<br>
<br>
Thanks<br>
<div class=3D"im">-Lv<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:linux-acpi-owner@vger.kernel.org">linux-acpi-o=
wner@vger.kernel.org</a><br>
</div><div class=3D"im">&gt; [mailto:<a href=3D"mailto:linux-acpi-owner@vge=
r.kernel.org">linux-acpi-owner@vger.kernel.org</a>] On Behalf Of Konrad Rze=
szutek Wilk<br>
&gt; Sent: Thursday, July 25, 2013 12:32 AM<br>
&gt; To: Ben Guthro<br>
&gt; Cc: Moore, Robert; Zheng, Lv; Jan Beulich; Rafael J . Wysocki;<br>
&gt; <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kern=
el.org</a>; <a href=3D"mailto:linux-acpi@vger.kernel.org">linux-acpi@vger.k=
ernel.org</a>;<br>
&gt; <a href=3D"mailto:xen-devel@lists.xen.org">xen-devel@lists.xen.org</a>=
<br>
&gt; Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in r=
educed<br>
&gt; hardware sleep path<br>
&gt;<br>
</div><div><div class=3D"h5">&gt; On Wed, Jul 24, 2013 at 11:14:06AM -0400,=
 Ben Guthro wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 07/24/2013 10:38 AM, Moore, Robert wrote:<br>
&gt; &gt; &gt; I haven&#39;t found a high-level description of &quot;acpi_o=
s_prepare_sleep&quot;,<br>
&gt; perhaps I missed it.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can someone point me to the overall description of this chan=
ge and why it is<br>
&gt; being considered?<br>
&gt; &gt;<br>
&gt; &gt; Hi Bob,<br>
&gt; &gt;<br>
&gt; &gt; For this series, the v6 of this series does a decent job of what =
it is<br>
&gt; &gt; trying to accomplish:<br>
&gt; &gt; <a href=3D"https://lkml.org/lkml/2013/7/1/205" target=3D"_blank">=
https://lkml.org/lkml/2013/7/1/205</a><br>
&gt; &gt;<br>
&gt; &gt; However, I recognize that this does not really describe *why*<br>
&gt; &gt; acpi_os_prepare_sleep is necessary to begin with. For that, we ne=
ed to<br>
&gt; &gt; go back a little more.<br>
&gt; &gt;<br>
&gt; &gt; The summary for the series that introduced it is a good descripti=
on,<br>
&gt; &gt; of the reasons it is necessary:<br>
&gt; &gt; <a href=3D"http://lkml.indiana.edu/hypermail/linux/kernel/1112.2/=
00450.html" target=3D"_blank">http://lkml.indiana.edu/hypermail/linux/kerne=
l/1112.2/00450.html</a><br>
&gt; &gt;<br>
&gt; &gt; In summary though - in the case of Xen (and I believe this is als=
o<br>
&gt; &gt; true in tboot) a value inappropriate for a VM (which dom0 is a sp=
ecial<br>
&gt; &gt; case<br>
&gt; &gt; of) was being written to cr3, and the physical machine would neve=
r<br>
&gt; &gt; come out of S3.<br>
&gt; &gt;<br>
&gt; &gt; This mechanism gives an os specific hook to do something else dow=
n at<br>
&gt; &gt; the lower levels, while still being able to take advantage of the=
<br>
&gt; &gt; large amount of OS independent code in ACPICA.<br>
&gt;<br>
&gt; It might be also prudent to look at original &#39;hook&#39; that was a=
dded by Intel in the<br>
&gt; Linux code to support TXT:<br>
&gt;<br>
&gt;<br>
&gt; commit 86886e55b273f565935491816c7c96b82469d4f8<br>
&gt; Author: Joseph Cihula &lt;<a href=3D"mailto:joseph.cihula@intel.com">j=
oseph.cihula@intel.com</a>&gt;<br>
&gt; Date: =A0 Tue Jun 30 19:31:07 2009 -0700<br>
&gt;<br>
&gt; =A0 =A0 x86, intel_txt: Intel TXT Sx shutdown support<br>
&gt;<br>
&gt; =A0 =A0 Support for graceful handling of sleep states (S3/S4/S5) after=
 an Intel(R)<br>
&gt; TXT launch.<br>
&gt;<br>
&gt; =A0 =A0 Without this patch, attempting to place the system in one of t=
he ACPI<br>
&gt; sleep<br>
&gt; =A0 =A0 states (S3/S4/S5) will cause the TXT hardware to treat this as=
 an attack<br>
&gt; and<br>
&gt; =A0 =A0 will cause a system reset, with memory locked. =A0Not only may=
 the<br>
&gt; subsequent<br>
&gt; =A0 =A0 memory scrub take some time, but the platform will be unable t=
o enter<br>
&gt; the<br>
&gt; =A0 =A0 requested power state.<br>
&gt;<br>
&gt; =A0 =A0 This patch calls back into the tboot so that it may properly a=
nd securely<br>
&gt; clean<br>
&gt; =A0 =A0 up system state and clear the secrets-in-memory flag, after wh=
ich it will<br>
&gt; place<br>
&gt; =A0 =A0 the system into the requested sleep state using ACPI informati=
on passed<br>
&gt; by the kernel.<br>
&gt;<br>
&gt; =A0 =A0 =A0arch/x86/kernel/smpboot.c =A0 =A0 | =A0 =A02 ++<br>
&gt; =A0 =A0 =A0drivers/acpi/acpica/hwsleep.c | =A0 =A03 +++<br>
&gt; =A0 =A0 =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 =
++++++-<br>
&gt; =A0 =A0 =A03 files changed, 11 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; =A0 =A0 Signed-off-by: Joseph Cihula &lt;<a href=3D"mailto:joseph.cihu=
la@intel.com">joseph.cihula@intel.com</a>&gt;<br>
&gt; =A0 =A0 Signed-off-by: Shane Wang &lt;<a href=3D"mailto:shane.wang@int=
el.com">shane.wang@intel.com</a>&gt;<br>
&gt; =A0 =A0 Signed-off-by: H. Peter Anvin &lt;<a href=3D"mailto:hpa@zytor.=
com">hpa@zytor.com</a>&gt;<br>
&gt;<br>
&gt; I suspect that if tboot was used with a different OS (Solaris?) it wou=
ld hit the<br>
&gt; same case and a similar hook would be needed.<br>
&gt;<br>
&gt; Said &#39;hook&#39; (which was a call to tboot_sleep) was converted to=
 be a more<br>
&gt; neutral &#39;acpi_os_prepare_sleep&#39; which tboot can use (and incid=
ently Xen too).<br>
&gt;<br>
&gt; I think what Bob is saying that if said hook is neccessary (and I beli=
eve it is - and<br>
&gt; Intel TXT maintainer thinks so too since he added it in the first plac=
e), then the<br>
&gt; right way of adding it is via the ACPICA tree.<br>
&gt;<br>
&gt; Should the discussion for this be moved there ? (<a href=3D"https://ac=
pica.org/community" target=3D"_blank">https://acpica.org/community</a>)<br>
&gt; and an generic &#39;os_prepare_sleep&#39; patch added in<br>
&gt; git://<a href=3D"http://github.com/acpica/acpica.git" target=3D"_blank=
">github.com/acpica/acpica.git</a>?<br>
&gt;<br>
&gt; --<br>
</div></div>&gt; To unsubscribe from this list: send the line &quot;unsubsc=
ribe linux-acpi&quot; in the body<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; of a message to <a href=3D"mai=
lto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a> More majordomo=
 info at<br>
&gt; <a href=3D"http://vger.kernel.org/majordomo-info.html" target=3D"_blan=
k">http://vger.kernel.org/majordomo-info.html</a><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br></div>

--047d7b5d48a6107ab104e24c1326--


--===============3292476641010323111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xen.org
http://lists.xen.org/xen-devel

--===============3292476641010323111==--
