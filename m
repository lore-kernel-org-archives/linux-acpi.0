From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 3/3] dell-wmi: Improve unknown hotkey handling
Date: Tue, 8 Dec 2015 16:33:59 -0800
Message-ID: <20151209003359.GC11972@malice.jf.intel.com>
References: <cover.1448931589.git.luto@kernel.org>
 <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
 <20151203233856.GC1800@malice.jf.intel.com>
 <20151204083923.GL10982@pali>
 <CALCETrW51LBvqiho+rs63ng3Jihvssm_Ky=+e+acM4Vq7R-WiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48616 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbLIAeC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 19:34:02 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrW51LBvqiho+rs63ng3Jihvssm_Ky=+e+acM4Vq7R-WiQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>

On Fri, Dec 04, 2015 at 08:15:04AM -0800, Andy Lutomirski wrote:
> On Fri, Dec 4, 2015 at 12:39 AM, Pali Roh=E1r <pali.rohar@gmail.com> =
wrote:
> > On Thursday 03 December 2015 15:38:56 Darren Hart wrote:
> >> Pali, this appears to have the one change you asked for (0x%x inst=
ead of %d).
> >> I've added the Reviewed-by: Pali Roh=E1r <pali.rohar@gmail.com> yo=
u provided
> >> previously pending this change.
> >
> > Ok.
> >
> >> > +           /* Uninitialized entries are 0 aka KEY_RESERVED. */
> >> > +           u16 keycode =3D (bios_entry->keycode <
> >> > +                          ARRAY_SIZE(bios_to_linux_keycode)) ?
> >> > +                   bios_to_linux_keycode[bios_entry->keycode] :
> >> > +                   KEY_RESERVED;
> >> > +           BUILD_BUG_ON(KEY_RESERVED !=3D 0);
> >
> > Anyway, Darren what do you think is that BUILD_BUG_ON check needed?
> >
>=20
> Sorry, my bad.  IIRC Darren made that change, I made the other change=
,
> and then I resent and we lost this one.
>=20
> Darren, want to fix it in your tree?  If not, I'll include the
> BUILD_BUG_ON deletion in v3.

Thanks for the catch Pali. I've removed this in my tree. No need to res=
end.

--=20
Darren Hart
Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
