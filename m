From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 6 Aug 2002 07:38:51 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33L2.0208060734290.10089-100000@dragon.pdx.osdl.net>
References: <3D4FDE0B.4020600@symplon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D4FDE0B.4020600-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?ISO-8859-1?Q?Robert_W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, =?ISO-8859-1?Q?J=F6rg_Sonnenberger?= <joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 6 Aug 2002, Robert W=F6rle wrote:

| Ducrot Bruno schrieb:
|
| >On Tue, Aug 06, 2002 at 03:28:27PM +0200, J=F6rg Sonnenberger wrote:
| >
| >
| >>Am Dienstag, 6. August 2002 14:04 schrieb Robert W=F6rle:
| >>
| >>
| >>>So what is this pci1 and pic2 thing ??? and why is it residing at my
| >>>wanted IO ???
| >>>
| >>>
| >>Let me guess: PIC =3D Programmable Interrupt Controller,
| >>so I think you don't wanna mess with it! The interesting question is, w=
hy is
| >>your device in this range? This ports are reserved since the days of IB=
M's
| >>good old AT.
| >>
| >>
| >>
| >
| >Well, not all those ports are used by the original 8259A.  And the PIC 2=
, is
| >'only' at range A0-AF, according to Ralf Brown list.  Linux extend it a =
little,
| >but I don't know why.
| >
| >
| >
| Tell me guys , what driver is this pic2 .. where can i found the
| according **.c to have some try`S and modify it
| so if it doesnt need these ports then i can use them for my purposes ...

The IO space for PIC1 and PIC2 is reserved in
linux/arch/i386/kernel/setup.c, around line 330 in 2.4.18/2.4.19,
in the array standard_io_resources[].
You might be able to make the granularity of that definition
finer so that some of the IO addresses aren't reserved.

Regarding someone else's email about Linux using only addresses
0xa0 and 0xa1 for PIC2:
That's probably correct.  The PIC internal registers are addressed
by ICWn and OCWn, which are dependent on the data values written.
The other IO addresses that are reserved (like 0xa4-5, 0xa8-9,
0xac-d, 0xb0-1, 0xb4-5, 0xb8-9, 0xbc-d) are ghosts (duplicates)
of the base IO addresses (0xa0-0xa1), due to incomplete IO address
line decoding.

--=20
~Randy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
