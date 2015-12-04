From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 3/3] dell-wmi: Improve unknown hotkey handling
Date: Fri, 4 Dec 2015 09:39:23 +0100
Message-ID: <20151204083923.GL10982@pali>
References: <cover.1448931589.git.luto@kernel.org>
 <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
 <20151203233856.GC1800@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151203233856.GC1800@malice.jf.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 December 2015 15:38:56 Darren Hart wrote:
> Pali, this appears to have the one change you asked for (0x%x instead=
 of %d).
> I've added the Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com> yo=
u provided
> previously pending this change.

Ok.

> > +		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> > +		u16 keycode =3D (bios_entry->keycode <
> > +			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > +			bios_to_linux_keycode[bios_entry->keycode] :
> > +			KEY_RESERVED;
> > +		BUILD_BUG_ON(KEY_RESERVED !=3D 0);

Anyway, Darren what do you think is that BUILD_BUG_ON check needed?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
