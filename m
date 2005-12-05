From: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks v051205
Date: Mon, 5 Dec 2005 15:27:32 +1100
Message-ID: <200512051527.37791.kernel@kolivas.org>
References: <200512051154.45500.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34879787940060658=="
Return-path: <ck-bounces@vds.kolivas.org>
In-Reply-To: <200512051154.45500.kernel@kolivas.org>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: ck@vds.kolivas.org
Cc: vatsa@in.ibm.com, Tony Lindgren <tony@atomide.com>, Daniel Petrini <d.pensator@gmail.com>, linux list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

--===============34879787940060658==
Content-Type: multipart/signed; boundary="nextPart1869705.3TAPEQ9OTY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1869705.3TAPEQ9OTY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 05 December 2005 11:54, Con Kolivas wrote:
> Here is an updated rollup patch for current dynticks on i386.
>
> The main change to this version is the inclusion of Dominik's patches to
> cpufreq ondemand, acpi c-states and bus mastering which should start maki=
ng
> the potential power saving features of dyntick a reality (thanks!).
> One buildfix for !CONFIG_NO_IDLE_HZ as well.
>
> If you get strange stalls with this patch then almost certainly it is a
> problem with dynticks and your apic so booting with the "noapic" option
> should fix it.
>
> Split out patches, timertop and pmstats utilities and latest patch
> available here:
> http://ck.kolivas.org/patches/dyn-ticks/
>
> FAQ:
> What Hz should I use with dynticks in the config?
> 1000 to realise the benefits of the power saving features and low latency.
>
> Should I enable timer statistics?
> Only if you're planning on using the timertop utility to help you recogni=
se
> the biggest sources of timers currently in use to help you improve power
> savings.

Looks like this fix is needed if you are using cpufreq as modules.

Cheers,
Con

=2D--
 kernel/dyn-tick.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15-rc5-dt/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/kernel/dyn-tick.c
+++ linux-2.6.15-rc5-dt/kernel/dyn-tick.c
@@ -122,6 +122,8 @@ void dyn_early_reprogram(unsigned int de
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
=20
+EXPORT_SYMBOL(dyn_early_reprogram);
+
 void set_dyn_tick_limits(unsigned int max_skip, unsigned int min_skip)
 {
 	if (max_skip > DYN_TICK_MAX_SKIP)


--nextPart1869705.3TAPEQ9OTY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDk8G5ZUg7+tp6mRURAtY0AJ4xPf3J8t4F75l3VTkbU3IdwaKeRwCePm2C
mGIL4alGdalrQy3gQVqe1MI=
=LXGp
-----END PGP SIGNATURE-----

--nextPart1869705.3TAPEQ9OTY--

--===============34879787940060658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============34879787940060658==--
