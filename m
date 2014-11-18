From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 1/6] ACPI/EC: Introduce STARTED/STOPPED flags to replace
 BLOCKED flag.
Date: Tue, 18 Nov 2014 15:23:28 +0200
Message-ID: <20141118132328.GA27428@node.dhcp.inet.fi>
References: <cover.1414988981.git.lv.zheng@intel.com>
 <e1228a3433fbbd8448d5522bef4e080763b1c18f.1414988981.git.lv.zheng@intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802689778@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802689778@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 05, 2014 at 02:52:36AM +0000, Zheng, Lv wrote:
> Hi, Rafael
>=20
> There is one thing I should let you know.
>=20
> Originally this patchset is dependent on the GPE "dead lock" fix.
> Because this patch will invoke acpi_enable_gpe()/acpi_disable_gpe() w=
ith EC lock held.
>=20
> I saw system hang during suspending using only this patchset, so we h=
ave to find a solution.
>=20
> > From: Zheng, Lv
> > Sent: Monday, November 03, 2014 1:16 PM
> >=20
> > By using the 2 flags, we can indicate an inter-mediate state where =
the
> > current transactions should be completed while the new transactions=
 should
> > be dropped.
> >=20
> > The comparison of the old flag and the new flags:
> >   Old			New
> >   about to set BLOCKED	STOPPED set / STARTED set
> >   BLOCKED set		STOPPED clear / STARTED clear
> >   BLOCKED clear		STOPPED clear / STARTED set
> > The new period is between the point where we are about to set BLOCK=
ED and
> > the point when the BLOCKED is set. The GPE is disabled during this =
period.
> > The new flags allow us to add acpi_ec_stopped() check to only check=
 with
> > STOPPED flag to implement transaction flushing. This is not done in=
 this
> > patch.
> >=20
> > No functional changes except that after applying this patch, the GP=
E
> > enabling/disabling is protected by the EC specific lock. We can do =
this
> > because of recent ACPICA GPE API enhancement. This is reasonable as=
 the GPE
> > disabling/enabling state should only be determined by the EC driver=
's state
> > machine which is protected by the EC spinlock.
>=20
> This paragraph is talking about the dependency.
>=20
> >=20
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Tested-by: Ortwin Gl=FCck <odi@odi.ch>
> > ---
> >  drivers/acpi/ec.c |   56 +++++++++++++++++++++++++++++++++++++++++=
++++--------
> >  1 file changed, 48 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index 5f9b74b..192cd11 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -79,7 +79,8 @@ enum {
> >  	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
> >  	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
> >  					 * OpReg are installed */
> > -	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
> > +	EC_FLAGS_STARTED,		/* Driver is started */
> > +	EC_FLAGS_STOPPED,		/* Driver is stopped */
> >  };
> >=20
> >  #define ACPI_EC_COMMAND_POLL		0x01 /* Available for command byte *=
/
> > @@ -129,6 +130,16 @@ static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs =
acpi_ec_clear() on boot/resume */
> >  static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SC=
I_EVT set */
> >=20
> >  /* ---------------------------------------------------------------=
-----------
> > + *                           Device Flags
> > + * ---------------------------------------------------------------=
----------- */
> > +
> > +static bool acpi_ec_started(struct acpi_ec *ec)
> > +{
> > +	return test_bit(EC_FLAGS_STARTED, &ec->flags) &&
> > +	       !test_bit(EC_FLAGS_STOPPED, &ec->flags);
> > +}
> > +
> > +/* ---------------------------------------------------------------=
-----------
> >   *                           Transaction Management
> >   * ---------------------------------------------------------------=
----------- */
> >=20
> > @@ -354,7 +365,7 @@ static int acpi_ec_transaction(struct acpi_ec *=
ec, struct transaction *t)
> >  	if (t->rdata)
> >  		memset(t->rdata, 0, t->rlen);
> >  	mutex_lock(&ec->mutex);
> > -	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
> > +	if (!acpi_ec_started(ec)) {
> >  		status =3D -EINVAL;
> >  		goto unlock;
> >  	}
> > @@ -511,6 +522,35 @@ static void acpi_ec_clear(struct acpi_ec *ec)
> >  		pr_info("%d stale EC events cleared\n", i);
> >  }
> >=20
> > +static void acpi_ec_start(struct acpi_ec *ec)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ec->lock, flags);
> > +	if (!test_and_set_bit(EC_FLAGS_STARTED, &ec->flags)) {
> > +		pr_debug("+++++ Starting EC +++++\n");
> > +		acpi_enable_gpe(NULL, ec->gpe);
>=20
> This can work without "GPE dead lock" fix applied because:
> 1. During boot, this API is called when the EC GPE is disabled.
> 2. During resume, this API is called when the EC GPE is disabled (bec=
ause EC GPE is always not wake capable).
>=20
> > +		pr_info("+++++ EC started +++++\n");
> > +	}
> > +	spin_unlock_irqrestore(&ec->lock, flags);
> > +}
> > +
> > +static void acpi_ec_stop(struct acpi_ec *ec)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ec->lock, flags);
> > +	if (acpi_ec_started(ec)) {
> > +		pr_debug("+++++ Stopping EC +++++\n");
> > +		set_bit(EC_FLAGS_STOPPED, &ec->flags);
> > +		acpi_disable_gpe(NULL, ec->gpe);
>=20
> But this cannot work without "GPE dead lock" fix applied because:
>=20
> In acpi_pm_freeze(), the call graph would be:
> 	acpi_pm_freeze()
> 		acpi_disable_all_gpes()
> 		acpi_os_wait_events_complete()
> 		acpi_ec_block_transactions()
> 			acpi_ec_stop()
> 				hold EC lock
> 				acpi_disable_gpe()
> 				hold GPE lock
>=20
> And in the GPE handler acpi_irq(), the call graph would be:
> 	acpi_irq()
> 		acpi_ev_sci_xrupt_handler()
> 			acpi_ev_gpe_detect()
> 				hold GPE lock
> 					acpi_ev_gpe_dispatch()
> 						acpi_ec_gpe_handler()
> 							hold EC lock
>=20
> Since acpi_os_wait_events_complete() cannot flush GPE but can only fl=
ush _Lxx/_Exx evaluation work queue currently.
> The reversed ordered dead lock can happen.
> We need to fix the acpi_os_wait_events_complete() prior than this ser=
ies.
> I have a fix to invoke synchronize_irq() in acpi_os_wait_events_compl=
ete().
> Let me send it to you.
> This cleanup should be applied after that fix.
>=20

Here's lockdep warning I see on -next:

[    0.510159] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.510171] [ INFO: possible circular locking dependency detected ]
[    0.510185] 3.18.0-rc4-next-20141117-07404-g9dad2ab6df8b #66 Not tai=
nted
[    0.510197] -------------------------------------------------------
[    0.510209] swapper/3/0 is trying to acquire lock:
[    0.510219]  (&(&ec->lock)->rlock){-.....}, at: [<ffffffff814d533e>]=
 acpi_ec_gpe_handler+0x21/0xfc
[    0.510254]=20
[    0.510254] but task is already holding lock:
[    0.510266]  (&(*(&acpi_gbl_gpe_lock))->rlock){-.....}, at: [<ffffff=
ff814cd67e>] acpi_os_acquire_lock+0xe/0x10
[    0.510296]=20
[    0.510296] which lock already depends on the new lock.
[    0.510296]=20
[    0.510312]=20
[    0.510312] the existing dependency chain (in reverse order) is:
[    0.510327]=20
[    0.510327] -> #1 (&(*(&acpi_gbl_gpe_lock))->rlock){-.....}:
[    0.510344]        [<ffffffff81158f4f>] lock_acquire+0xdf/0x2d0
[    0.510364]        [<ffffffff81b08010>] _raw_spin_lock_irqsave+0x50/=
0x70
[    0.510381]        [<ffffffff814cd67e>] acpi_os_acquire_lock+0xe/0x1=
0
[    0.510398]        [<ffffffff814e31e8>] acpi_enable_gpe+0x22/0x68
[    0.510416]        [<ffffffff814d5b24>] acpi_ec_start+0x66/0x87
[    0.510432]        [<ffffffff81afc771>] ec_install_handlers+0x41/0xa=
4
[    0.510449]        [<ffffffff823e72b9>] acpi_ec_ecdt_probe+0x1a9/0x1=
ea
[    0.510466]        [<ffffffff823e6ae3>] acpi_init+0x8b/0x26e
[    0.510480]        [<ffffffff81002148>] do_one_initcall+0xd8/0x210
[    0.510496]        [<ffffffff8239f1dc>] kernel_init_freeable+0x1f5/0=
x282
[    0.510513]        [<ffffffff81af1a1e>] kernel_init+0xe/0xf0
[    0.510527]        [<ffffffff81b08cfc>] ret_from_fork+0x7c/0xb0
[    0.510542]=20
[    0.510542] -> #0 (&(&ec->lock)->rlock){-.....}:
[    0.510558]        [<ffffffff811585ef>] __lock_acquire+0x210f/0x2220
[    0.510574]        [<ffffffff81158f4f>] lock_acquire+0xdf/0x2d0
[    0.510589]        [<ffffffff81b08010>] _raw_spin_lock_irqsave+0x50/=
0x70
[    0.510604]        [<ffffffff814d533e>] acpi_ec_gpe_handler+0x21/0xf=
c
[    0.510620]        [<ffffffff814e02c2>] acpi_ev_gpe_dispatch+0xd2/0x=
143
[    0.510636]        [<ffffffff814e03fb>] acpi_ev_gpe_detect+0xc8/0x10=
f
[    0.510652]        [<ffffffff814e23b6>] acpi_ev_sci_xrupt_handler+0x=
22/0x38
[    0.510669]        [<ffffffff814cc8ee>] acpi_irq+0x16/0x31
[    0.510684]        [<ffffffff8116eccf>] handle_irq_event_percpu+0x6f=
/0x540
[    0.510702]        [<ffffffff8116f1e1>] handle_irq_event+0x41/0x70
[    0.510718]        [<ffffffff81171ef6>] handle_fasteoi_irq+0x86/0x14=
0
[    0.510733]        [<ffffffff81075a22>] handle_irq+0x22/0x40
[    0.510748]        [<ffffffff81b0beaf>] do_IRQ+0x4f/0xf0
[    0.510762]        [<ffffffff81b09bb2>] ret_from_intr+0x0/0x1a
[    0.510777]        [<ffffffff8107e783>] default_idle+0x23/0x260
[    0.510792]        [<ffffffff8107f35f>] arch_cpu_idle+0xf/0x20
[    0.510806]        [<ffffffff8114a99b>] cpu_startup_entry+0x36b/0x5b=
0
[    0.510821]        [<ffffffff810a8d04>] start_secondary+0x1a4/0x1d0
[    0.510840]=20
[    0.510840] other info that might help us debug this:
[    0.510840]=20
[    0.510856]  Possible unsafe locking scenario:
[    0.510856]=20
[    0.510868]        CPU0                    CPU1
[    0.510877]        ----                    ----
[    0.510886]   lock(&(*(&acpi_gbl_gpe_lock))->rlock);
[    0.510898]                                lock(&(&ec->lock)->rlock)=
;
[    0.510912]                                lock(&(*(&acpi_gbl_gpe_lo=
ck))->rlock);
[    0.510927]   lock(&(&ec->lock)->rlock);
[    0.510938]=20
[    0.510938]  *** DEADLOCK ***
[    0.510938]=20
[    0.510953] 1 lock held by swapper/3/0:
[    0.510961]  #0:  (&(*(&acpi_gbl_gpe_lock))->rlock){-.....}, at: [<f=
fffffff814cd67e>] acpi_os_acquire_lock+0xe/0x10
[    0.510990]=20
[    0.510990] stack backtrace:
[    0.511004] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.18.0-rc4-nex=
t-20141117-07404-g9dad2ab6df8b #66
[    0.511021] Hardware name: LENOVO 3460CC6/3460CC6, BIOS G6ET93WW (2.=
53 ) 02/04/2013
[    0.511035]  ffffffff82cb2f70 ffff88011e2c3bb8 ffffffff81afc316 0000=
000000000011
[    0.511055]  ffffffff82cb2f70 ffff88011e2c3c08 ffffffff81afae11 0000=
000000000001
[    0.511074]  ffff88011e2c3c68 ffff88011e2c3c08 ffff8801193f92d0 ffff=
8801193f9b20
[    0.511094] Call Trace:
[    0.511101]  <IRQ>  [<ffffffff81afc316>] dump_stack+0x4c/0x6e
[    0.511125]  [<ffffffff81afae11>] print_circular_bug+0x2b2/0x2c3
[    0.511142]  [<ffffffff811585ef>] __lock_acquire+0x210f/0x2220
[    0.511159]  [<ffffffff81158f4f>] lock_acquire+0xdf/0x2d0
[    0.511176]  [<ffffffff814d533e>] ? acpi_ec_gpe_handler+0x21/0xfc
[    0.511192]  [<ffffffff81b08010>] _raw_spin_lock_irqsave+0x50/0x70
[    0.511209]  [<ffffffff814d533e>] ? acpi_ec_gpe_handler+0x21/0xfc
[    0.511225]  [<ffffffff814ea192>] ? acpi_hw_write+0x4b/0x52
[    0.511241]  [<ffffffff814d533e>] acpi_ec_gpe_handler+0x21/0xfc
[    0.511258]  [<ffffffff814e02c2>] acpi_ev_gpe_dispatch+0xd2/0x143
[    0.511274]  [<ffffffff814e03fb>] acpi_ev_gpe_detect+0xc8/0x10f
[    0.511292]  [<ffffffff814e23b6>] acpi_ev_sci_xrupt_handler+0x22/0x3=
8
[    0.511309]  [<ffffffff814cc8ee>] acpi_irq+0x16/0x31
[    0.511325]  [<ffffffff8116eccf>] handle_irq_event_percpu+0x6f/0x540
[    0.511342]  [<ffffffff8116f1e1>] handle_irq_event+0x41/0x70
[    0.511357]  [<ffffffff81171e98>] ? handle_fasteoi_irq+0x28/0x140
[    0.511372]  [<ffffffff81171ef6>] handle_fasteoi_irq+0x86/0x140
[    0.511388]  [<ffffffff81075a22>] handle_irq+0x22/0x40
[    0.511402]  [<ffffffff81b0beaf>] do_IRQ+0x4f/0xf0
[    0.511417]  [<ffffffff81b09bb2>] common_interrupt+0x72/0x72
[    0.511428]  <EOI>  [<ffffffff810b8986>] ? native_safe_halt+0x6/0x10
[    0.511454]  [<ffffffff81154f3d>] ? trace_hardirqs_on+0xd/0x10
[    0.511468]  [<ffffffff8107e783>] default_idle+0x23/0x260
[    0.511482]  [<ffffffff8107f35f>] arch_cpu_idle+0xf/0x20
[    0.511496]  [<ffffffff8114a99b>] cpu_startup_entry+0x36b/0x5b0
[    0.511512]  [<ffffffff810a8d04>] start_secondary+0x1a4/0x1d0


--=20
 Kirill A. Shutemov
