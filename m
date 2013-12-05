From: Borislav Petkov <bp@alien8.de>
Subject: Re: [BUG] Re: [PATCH v10 1/3] aerdrv: Trace Event for AER
Date: Thu, 5 Dec 2013 22:12:55 +0100
Message-ID: <20131205211255.GG14407@pd.tnic>
References: <20130116235102.16015.77379.stgit@grignak.americas.hpqcorp.net>
 <CANVTcTabw2pxUP0iinepviavSLHT7AAyaQvA7e-mv2simbX7ow@mail.gmail.com>
 <CABawtvP3m_dAKaOLxNqHXQobsgk92ysh6H881i3eDASLi+-WAg@mail.gmail.com>
 <1386267670.18256.8.camel@ejdallLaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54358 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab3LEVM6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Dec 2013 16:12:58 -0500
Content-Disposition: inline
In-Reply-To: <1386267670.18256.8.camel@ejdallLaptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Betty Dall <betty.dall@hp.com>
Cc: Ethan Zhao <ethan.kernel@gmail.com>, rui wang <ruiv.wang@gmail.com>, Lance Ortiz <lance.ortiz@hp.com>, Bjorn Helgaas <bhelgaas@google.com>, lance_ortiz@hotmail.com, jiang.liu@intel.com, tony.luck@intel.com, rostedt@goodmis.org, m.chehab@samsung.com, linux-acpi@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, gong.chen@linux.intel.com

On Thu, Dec 05, 2013 at 11:21:10AM -0700, Betty Dall wrote:
> The definition of the GHES_SEV* matches up with the error severity
> definition of the CPER records as defined in the UEFI spec section
> N.2.1:
> "Indicates the severity of the error condition. The severity of
> the error record corresponds to the most severe error
> section.
> 0 - Recoverable (also called non-fatal uncorrected)
> 1 - Fatal
> 2 - Corrected
> 3 - Informational
> All other values are reserved.
> Note that severity of "Informational" indicates that the record
> could be safely ignored by error handling software."

Actually, we can go even one radical step further and drop
ghes_severity() completely because GHES severity in the ACPI spec 5.0 i=
s
defined almost exactly the same:

"18.3.2.6.1 Generic Error Data

=2E..

Identifies the error severity of the reported error:
0 =E2=80=93 Recoverable=EF=80=A0
1 =E2=80=93 Fatal=EF=80=A0
2 =E2=80=93 Corrected=EF=80=A0
3 =E2=80=93 None
Note: This is the error severity of the entire event. Each Generic
Error Data Entry also includes its own Error Severity field."

I don't know which version of the spec dictated

enum {
        GHES_SEV_NO =3D 0x0,
        GHES_SEV_CORRECTED =3D 0x1,
        GHES_SEV_RECOVERABLE =3D 0x2,
        GHES_SEV_PANIC =3D 0x3,
};

though and whether we're going to have to differentiate between the old
and GHES numerical severity levels. Which, if we have to, would be very
nasty...

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
