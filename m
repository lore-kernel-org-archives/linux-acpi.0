From: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: [ACPI] [RFC][PATCH] notify BIOS of cpufreq support (pstate_cnt)
Date: Tue, 15 Jun 2004 07:07:48 +0200
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040615050748.GA5118@dominikbrodowski.de>
References: <B44D37711ED29844BEA67908EAF36F0315E5FF@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868320230=="
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F0315E5FF@pdsmsx401.ccr.corp.intel.com>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org


--===============0868320230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2004 at 11:40:14AM +0800, Li, Shaohua wrote:
> If AC adapter is disconnected in boot time, loops_per_jiffy, cpu_khz
> will be calculated according to current cpu speed (maybe is not full
> speed). Can this patch handle this situation?

Yes, it will -- cpufreq already tries to do that

> After disable BIOS P-state
> control, should loops_per_jiffy be recalculated? (How about look at if
> cpu_khz match any P-state, and adjust according to the difference
> between P-state and P0).

guess_freq/( in acpi.c already compares cpu_khz to the closest P-State...

About re-calculation... yes, in some corner cases it'd be necessary, but
only if the frequency changed in between the loops_per_jiffy calculation and
the notification to the BIOS _and_ if the acpi cpufreq driver is used, and
not a "special" driver like speedstep-centrino... but it's non-trivial to=
=20
do, and might cause severe side-effects [e.g. system _completely_ unavailab=
le=20
for 1s when modprob'ing such a module], so I'd prefer to ignore this corner
case.

As an example:

> >--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
> >	2004-06-14 23:26:56.074710200 +0200
> >+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
> 2004-06-14
> >23:11:52.340098744 +0200
> >@@ -371,6 +371,9 @@
> >                 goto err_kfree;
> >         }
> >
> >+	/* notify BIOS that we exist */
> >+	acpi_processor_notify_smm();
> >+
> > 	cur_freq =3D get_cur_freq(0);

Speedstep-centrino _first_ notifies the BIOS, then detects the current state
-- if the latter is different to the one booted at, it will even update the
timing core accordingly.

	Dominik

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzoQkZ8MDCHJbN8YRAhgKAJ9PiZjxV3O3d8dKNpsurFbte8SG6ACgh0NH
8cxmE50E9Mewn5De0DnZnRg=
=gtkL
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


--===============0868320230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

--===============0868320230==--
