From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [patch 013/100] ACPI: cap off P-state transition latency from buggy BIOSes
Date: Sat, 25 Apr 2009 17:59:02 +0200
Message-ID: <200904251759.11600.Martin@lichtvoll.de>
References: <20090423072020.428683652@sous-sol.org> <20090423072218.102318325@sous-sol.org> (sfid-20090423_104745_885400_65A6F0E7)
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4124018.QTTYZMyo0t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754062AbZDYP6a@vger.kernel.org>
In-Reply-To: <20090423072218.102318325@sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Jake Edge <jake@lwn.net>, Eugene Teo <eteo@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

--nextPart4124018.QTTYZMyo0t
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 23 April 2009 schrieb Chris Wright:
> -stable review patch.  If anyone has any objections, please let us
> know. ---------------------
>
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>
> upstream commit: a59d1637eb0e0a37ee0e5c92800c60abe3624e24
>
> Some BIOSes report very high frequency transition latency which are
> plainly wrong on CPus that can change frequency using native MSR
> interface.
>
> One such system is IBM T42 (2327-8ZU) as reported by Owen Taylor and
> Rik van Riel.
>
> cpufreq_ondemand driver uses this transition latency to come up with a
> reasonable sampling interval to sample CPU usage and with such high
> latency value, ondemand sampling interval ends up being very high
> (0.5 sec, in this particular case), resulting in performance impact due
> to slow response to increasing frequency.
>
> Fix it by capping-off the transition latency to 20uS for native MSR
> based frequency transitions.
>
> mjg: We've confirmed that this also helps on the X31
>
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Acked-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>
>  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -680,6 +680,18 @@ static int acpi_cpufreq_cpu_init(struct
>  			    perf->states[i].transition_latency * 1000;
>  	}
>
> +	/* Check for high latency (>20uS) from buggy BIOSes, like on T42 */
> +	if (perf->control_register.space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE
> && +	    policy->cpuinfo.transition_latency > 20 * 1000) {
> +		static int print_once;
> +		policy->cpuinfo.transition_latency =3D 20 * 1000;
> +		if (!print_once) {
> +			print_once =3D 1;
> +			printk(KERN_INFO "Capping off P-state tranision latency"

typo: tranision =3D> transition

> +				" at 20 uS\n");
> +		}
> +	}
> +
>  	data->max_freq =3D perf->states[0].core_frequency * 1000;
>  	/* table init */
>  	for (i=3D0; i<perf->state_count; i++) {
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart4124018.QTTYZMyo0t
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknzM0kACgkQmRvqrKWZhMd8tQCfW46wySxqSShaHy98HPnTt0wj
VH0AnilyDhXpg4q0gs23p44eGsbS3oDj
=b1rB
-----END PGP SIGNATURE-----

--nextPart4124018.QTTYZMyo0t--
