From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: what is throttling?
Date: Wed, 6 Oct 2004 16:21:48 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041006132148.GA20857@sci.fi>
References: <20041006090408.GA17104@rap.rap.dk> <20041006114935.GF17247@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041006114935.GF17247-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2004 at 01:49:35PM +0200, Andi Kleen wrote:
> On Wed, Oct 06, 2004 at 11:04:08AM +0200, Keld J?rn Simonsen wrote:
> > Hi!
> >=20
> > I have googled around for a couple of hours to find out precisely wha=
t
> > throttling means. I did it before and found some useful information, =
but
> > this time I did not find the relevant data.
> >=20
> > I would like to find out, which state precisely that the CPU enters w=
hen
> > throttling. Maybe it is different from CPU to CPU. Specifically I wou=
ld
> > like to know if the CPU is completely powered off, my recollection of
> > some information I have seen earlier is that this may be the case.
>=20
> On Intel CPUs Throttling means that the CPU skips each other
> (or more) clock. This is quite slow, but only done to get=20
> the temperature down.
>=20
> AMD CPUs don't have it afaik.

My AMD system (Duron 1300 + Abit KT7) can be throttled by 50%. In reality=
=20
it feels more like 90% since even a temperature/fan monitor applet eats=20
15% of my CPU when throttled. I haven't seen any benefits from throttling=
=20
though.

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
