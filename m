From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suggestion for improving the handling of GPE enabling.
Date: Thu, 10 Mar 2005 11:11:36 +0100
Message-ID: <20050310101133.GD13444@elf.ucw.cz>
References: <1110318037.3663.19.camel@desktop.cunningham.myip.net.au> <1110331896.12642.16.camel@sli10-desk.sh.intel.com> <20050309222122.GA32516@elf.ucw.cz> <1110431446.9336.60.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
In-Reply-To: <1110431446.9336.60.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On =C4=8Ct 10-03-05 00:10:47, Len Brown wrote:
> On Wed, 2005-03-09 at 17:21, Pavel Machek wrote:
>=20
> > > 4. ACPI devices are in many different physical buses. If we just de=
fine
> > > an ACPI bus, we possibly can't show the bus hierarchy.
> >=20
> > Maybe ACPI device should be "under" real hardware one?
>=20
> I suspect that the current sysfs device tree hierarchy is largely
> fiction and that Linux would be better served by taking advantage of th=
e
> hierarchy embodied in the DSDT.

Funny, I'd say that DSDT hierarchy is fiction and ... :-).

> The "ACPI devices" such as power, sleep, lid as well as the battery are
> represented at the root level in the DSDT.

It probably does not matter where power/sleep/lid are represented, but
things like ide-disk below ide-controller below pci bus make sense to
me (and we need that hierarchy for suspend/resume anyway). For devices
like lid... yeh, there's not much hierarchy there, just select some
place.
								Pavel
--=20
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
