From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 1/3] dell-wmi: Use a C99-style array for
 bios_to_linux_keycode
Date: Thu, 3 Dec 2015 16:07:44 -0800
Message-ID: <20151204000744.GG1800@malice.jf.intel.com>
References: <cover.1448931589.git.luto@kernel.org>
 <c30cf7923f0059d21ba3d8a63b7eb47fe7e475a4.1448931589.git.luto@kernel.org>
 <20151203233249.GB1800@malice.jf.intel.com>
 <CALCETrV5WJgzp3EewXdkN35ZQ95cVDu-XLznqD6muCwHQZS4qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrV5WJgzp3EewXdkN35ZQ95cVDu-XLznqD6muCwHQZS4qQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 03, 2015 at 03:45:36PM -0800, Andy Lutomirski wrote:
> On Thu, Dec 3, 2015 at 3:32 PM, Darren Hart <dvhart@infradead.org> wr=
ote:
> > On Mon, Nov 30, 2015 at 05:01:59PM -0800, Andy Lutomirski wrote:
> >> It's currently hard to follow what maps to what, and it's hard to =
edit
> >> the array.  Redo it as a C99-style array.
> >>
> >> I generated this using emacs regexes and a python one-liner.
> >> objdump says this didn't change the table.
> >>
> >> Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >
> > I already have this one in next and I don't see a per-patch changel=
og for this
> > one - has it changed?
> >
>=20
> No, it hasn't.  I didn't actually mean to include it in the series.
> Whoops!  Please just pretend that I only sent patch 2 onward.

:-) Done.

--=20
Darren Hart
Intel Open Source Technology Center
