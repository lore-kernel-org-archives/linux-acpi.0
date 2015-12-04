From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 2/3] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Fri, 4 Dec 2015 08:05:26 -0800
Message-ID: <CALCETrUNCJLeqcBakvCBF2rdwYUfLu0t5qN0gJOoTXOEPD8Jfg@mail.gmail.com>
References: <cover.1448931589.git.luto@kernel.org> <d9ff5adc7e496b7714202785f8279af313bbcc59.1448931589.git.luto@kernel.org>
 <20151204090346.GO10982@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20151204090346.GO10982@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Mario Limonciello <mario_limonciello@dell.com>, platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Dec 4, 2015 1:03 AM, "Pali Roh=C3=A1r" <pali.rohar@gmail.com> wrote:
>
> On Monday 30 November 2015 17:02:00 Andy Lutomirski wrote:
> > +             /*
> > +              * Check if we've already found this scancode.  This =
takes
> > +              * quadratic time, but it doesn't matter unless the l=
ist
> > +              * of extra keys gets very long.
> > +              */
> > +             for (j =3D 0; j < num_bios_keys; j++)
> > +                     if (keymap[j].code =3D=3D dell_wmi_extra_keym=
ap[i].code)
> > +                             goto skip;
> > +
>
> Still, my comment about moving this loop into function is valid...
>

Whoops!  Queued for v3.

--Andy
