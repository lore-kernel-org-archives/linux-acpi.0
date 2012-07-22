From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] acpi: fix pwr_btn_event_pending build error
Date: Sat, 21 Jul 2012 21:10:38 -0700
Message-ID: <20120722041038.GN2435@linux.vnet.ibm.com>
References: <20120721214156.GA2515@linux.vnet.ibm.com>
 <20120721215243.GA15362@shutemov.name>
 <20120721233714.GL2435@linux.vnet.ibm.com>
 <20120722000838.GA15798@shutemov.name>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36371 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab2GVEL0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2012 00:11:26 -0400
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 22 Jul 2012 00:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20120722000838.GA15798@shutemov.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jul 22, 2012 at 03:08:40AM +0300, Kirill A. Shutemov wrote:
> On Sat, Jul 21, 2012 at 04:37:14PM -0700, Paul E. McKenney wrote:
> > On Sun, Jul 22, 2012 at 12:52:43AM +0300, Kirill A. Shutemov wrote:
> > > On Sat, Jul 21, 2012 at 02:41:56PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > >=20
> > > > A recent build for KVM on x86 resulted in the following build e=
rror:
> > > >=20
> > > > drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event_pen=
ding=E2=80=99 defined but not
> > > > +used [-Wunused-variable]
> > > >=20
> > > > This patch silences this error.
> > > >=20
> > > > Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
> > > >=20
> > > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > > index 8856102..18347aa 100644
> > > > --- a/drivers/acpi/sleep.c
> > > > +++ b/drivers/acpi/sleep.c
> > > > @@ -57,7 +57,9 @@ MODULE_PARM_DESC(gts, "Enable evaluation of _=
GTS on suspend.");
> > > >  MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
> > > > =20
> > > >  static u8 sleep_states[ACPI_S_STATE_COUNT];
> > > > +#ifdef CONFIG_ACPI_SLEEP
> > > >  static bool pwr_btn_event_pending;
> > > > +#endif /* #ifdef CONFIG_ACPI_SLEEP */
> > >=20
> > > __maybe_unused ?
> >=20
> > Are the compiler and linker smart enough to get rid of the storage =
in
> > case it really isn't used?  (Not that the storage for a bool is wor=
th
> > worrying about, but...)
>=20
> GCC with optimization enabled will get rid of the storage even withou=
t
> __maybe_unused.

OK, that should allow me to get rid of a few ifdefs, then!  For this on=
e,
please see below.

							Thanx, Paul

-----------------------------------------------------------------------=
-

acpi: fix pwr_btn_event_pending build error

A recent build for KVM on x86 resulted in the following build error:

drivers/acpi/sleep.c:60:13: warning: =E2=80=98pwr_btn_event_pending=E2=80=
=99 defined but not
+used [-Wunused-variable]

This patch silences this error.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8856102..18347aa 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -57,7 +57,9 @@ MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on s=
uspend.");
 MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
=20
 static u8 sleep_states[ACPI_S_STATE_COUNT];
+#ifdef CONFIG_ACPI_SLEEP
 static bool pwr_btn_event_pending;
+#endif /* #ifdef CONFIG_ACPI_SLEEP */
=20
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
