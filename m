From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Date: Wed, 6 Apr 2005 14:39:47 +0200
Message-ID: <20050406123947.GA31958@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at> <20050405211340.GF1380@elf.ucw.cz> <20050405221903.GA21196@gamma.logic.tuwien.ac.at> <20050405183144.50ed3a9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050405183144.50ed3a9c.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: pavel-+ZI9xUNit7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Die, 05 Apr 2005, Andrew Morton wrote:
> > 2.6.12-rc2 suspends and resumes with the very same config file (well,
> > after running make oldconfig) without any problem.
> >=20
> > So there is a change in -mm1 which triggers this. Should I start with
> > backing out bk-acpi? or anything else?
>=20
> bk-acpi would be a good choice.  It might be easier to start with
> 2.6.12-rc2 and add stuff, see when it breaks.

Ok,=20
	2.6.12-rc2		suspend and resumes works
	   + bk-acpi.patch	immediate reboot at resume.

> bk-acpi and bk-driver-core would be prime suspects.

I didn't try bk-driver-core.

Best wishes

Norbert

-------------------------------------------------------------------------=
------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-=
690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
SCREEB (n.)
To make the noise of a nylon anorak rubbing against a pair of corduroy
trousers.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
