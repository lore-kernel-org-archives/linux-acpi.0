From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 resume and other ACPI questions
Date: Sat, 19 Mar 2005 11:48:33 +0100
Message-ID: <20050319104833.GA1345@elf.ucw.cz>
References: <7f800d9f05022815286a10ddf6@mail.gmail.com> <20050308095722.GA16798@elf.ucw.cz> <7f800d9f050318193340df70a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <7f800d9f050318193340df70a9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <int2str-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On P=E1 18-03-05 19:33:48, Andre Eisenbach wrote:
> On Tue, 8 Mar 2005 10:57:22 +0100, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> > Read Doc*/power/video.txt. Send me a patch when you get it working.
>=20
> Hello Pavel, all,
>=20
> I've read video.txt and it got me further actually. Thanks for that.
>=20
> I've recompiled the kernel without any fbcon etc. and use the "radeon"
> display driver within X windows (Gentoo patched version). This way I
> can actually resume from S3 now, and get right back into X. Really
> quickly, too.
>=20
> However, the hard drive does not seem to fair so well. The hdd
> activity LED remains on and the drive does not seem responsive (but
> spinning). The laptop slows to a crawl and any executable that causes
> disc access (i.e. it's not cached or reads config files etc). Won't
> execute.
>=20
> dmesg seems to work, but doesn't really show anything. After the
> "stopping tasks" I get a weird "Back from C!" message, but that's
> about it.
>=20
> What could I try from here?

I'd do it from text console, and insert printks just about everywhere
to see what is going on. See if disk is getting interrupts, for
example.

								Pavel
--=20
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
