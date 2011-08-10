From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v3 1/2] x86: Enable fast strings on Intel if BIOS hasn't
 already
Date: Wed, 10 Aug 2011 08:05:38 -0700
Message-ID: <493994B35A117E4F832F97C4719C4C040132CE88A0@orsmsx505.amr.corp.intel.com>
References: <cover.1312893572.git.luto@mit.edu>
 <d9f3056c77b6cd44a2f4c90278ce483a011dda12.1312893572.git.luto@mit.edu>
 <493994B35A117E4F832F97C4719C4C040132CE80CE@orsmsx505.amr.corp.intel.com>
 <CAObL_7EozFSbcqJiwV=PNH-3sN0M1QfaTu3i4A_OKsZ0Ue5g7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAObL_7EozFSbcqJiwV=PNH-3sN0M1QfaTu3i4A_OKsZ0Ue5g7A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, "Anvin, H Peter" <h.peter.anvin@intel.com>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: amluto@gmail.com [mailto:amluto@gmail.com] On Behalf Of Andrew
> Lutomirski
> Sent: Wednesday, August 10, 2011 7:50 AM
> To: Yu, Fenghua
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; Matthew Garrett; Le=
n
> Brown; linux-acpi@vger.kernel.org; Ingo Molnar; Anvin, H Peter
> Subject: Re: [PATCH v3 1/2] x86: Enable fast strings on Intel if BIOS
> hasn't already
>=20
> On Tue, Aug 9, 2011 at 11:40 AM, Yu, Fenghua <fenghua.yu@intel.com>
> wrote:
> >> -----Original Message-----
> >> From: Andy Lutomirski [mailto:luto@MIT.EDU]
> >> Sent: Tuesday, August 09, 2011 5:41 AM
> >> To: x86@kernel.org; linux-kernel@vger.kernel.org
> >> Cc: Yu, Fenghua; Matthew Garrett; Len Brown; linux-
> >> acpi@vger.kernel.org; Ingo Molnar; Andy Lutomirski
> >> Subject: [PATCH v3 1/2] x86: Enable fast strings on Intel if BIOS
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
> >> =A0arch/x86/kernel/cpu/intel.c | =A0 28 +++++++++++++++++++++++---=
--
> >> =A01 files changed, 23 insertions(+), 5 deletions(-)
> >
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> >
> >
>=20
> Please don't apply.  This patch breaks !CONFIG_SMP.  I'll send a fixe=
d
> patch later on.

+				printk_once(KERN_INFO FW_WARN "CPU #%d: IA32_MISC_ENABLE.FAST_STRI=
NG_ENABLE was not set",
There is no need to print CPU id. Then there is no SMP issue.

Thanks.

-Fenghua
