From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] acpi: fix pwr_btn_event_pending build error
Date: Sun, 22 Jul 2012 13:28:44 -0700
Message-ID: <20120722202843.GQ2435@linux.vnet.ibm.com>
References: <20120721214156.GA2515@linux.vnet.ibm.com>
 <20120722000838.GA15798@shutemov.name>
 <20120722041038.GN2435@linux.vnet.ibm.com>
 <201207221940.51764.rjw@sisk.pl>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:54319 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2GVU33 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Jul 2012 16:29:29 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 22 Jul 2012 14:29:28 -0600
Content-Disposition: inline
In-Reply-To: <201207221940.51764.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jul 22, 2012 at 07:40:51PM +0200, Rafael J. Wysocki wrote:
> On Sunday, July 22, 2012, Paul E. McKenney wrote:
> > On Sun, Jul 22, 2012 at 03:08:40AM +0300, Kirill A. Shutemov wrote:
> > > On Sat, Jul 21, 2012 at 04:37:14PM -0700, Paul E. McKenney wrote:
> > > > On Sun, Jul 22, 2012 at 12:52:43AM +0300, Kirill A. Shutemov wr=
ote:
> > > > > On Sat, Jul 21, 2012 at 02:41:56PM -0700, Paul E. McKenney wr=
ote:
> > > > > > Hello!
> > > > > >=20
> > > > > > A recent build for KVM on x86 resulted in the following bui=
ld error:
> > > > > >=20
> > > > > > drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event=
_pending=E2=80=99 defined but not
> > > > > > +used [-Wunused-variable]
> > > > > >=20
> > > > > > This patch silences this error.
> > > > > >=20
> > > > > > Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
> > > > > >=20
> > > > > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > > > > index 8856102..18347aa 100644
> > > > > > --- a/drivers/acpi/sleep.c
> > > > > > +++ b/drivers/acpi/sleep.c
> > > > > > @@ -57,7 +57,9 @@ MODULE_PARM_DESC(gts, "Enable evaluation =
of _GTS on suspend.");
> > > > > >  MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume=
".);
> > > > > > =20
> > > > > >  static u8 sleep_states[ACPI_S_STATE_COUNT];
> > > > > > +#ifdef CONFIG_ACPI_SLEEP
> > > > > >  static bool pwr_btn_event_pending;
> > > > > > +#endif /* #ifdef CONFIG_ACPI_SLEEP */
> > > > >=20
> > > > > __maybe_unused ?
> > > >=20
> > > > Are the compiler and linker smart enough to get rid of the stor=
age in
> > > > case it really isn't used?  (Not that the storage for a bool is=
 worth
> > > > worrying about, but...)
> > >=20
> > > GCC with optimization enabled will get rid of the storage even wi=
thout
> > > __maybe_unused.
> >=20
> > OK, that should allow me to get rid of a few ifdefs, then!  For thi=
s one,
> > please see below.
> >=20
> > 							Thanx, Paul
> >=20
> > -------------------------------------------------------------------=
-----
> >=20
> > acpi: fix pwr_btn_event_pending build error
> >=20
> > A recent build for KVM on x86 resulted in the following build error=
:
> >=20
> > drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event_pending=
=E2=80=99 defined but not
> > +used [-Wunused-variable]
> >=20
> > This patch silences this error.
> >=20
> > Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
>=20
> Well, I prefer the one below.

Works for me!

							Thanx, Paul

> Thanks,
> Rafael
>=20
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: ACPI / PM: Fix build warning in sleep.c for CONFIG_ACPI_SLEE=
P unset
>=20
> If CONFIG_ACPI_SLEEP is unset, the compiler complains that
> pwr_btn_event_pending is defined but not used.  To silence the
> warning, move the definition of pwr_btn_event_pending under an
> apprporiate #ifdef.
>=20
> Reported-by: Paul E. McKenney <paul.mckenney@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/acpi/sleep.c
> +++ linux/drivers/acpi/sleep.c
> @@ -57,7 +57,6 @@ MODULE_PARM_DESC(gts, "Enable evaluation
>  MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
> =20
>  static u8 sleep_states[ACPI_S_STATE_COUNT];
> -static bool pwr_btn_event_pending;
> =20
>  static void acpi_sleep_tts_switch(u32 acpi_state)
>  {
> @@ -110,6 +109,7 @@ static int acpi_sleep_prepare(u32 acpi_s
> =20
>  #ifdef CONFIG_ACPI_SLEEP
>  static u32 acpi_target_sleep_state =3D ACPI_STATE_S0;
> +static bool pwr_btn_event_pending;
> =20
>  /*
>   * The ACPI specification wants us to save NVS memory regions during=
 hibernation
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
