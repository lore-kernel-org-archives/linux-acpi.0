From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3 1/3] acpi: Call acpi_os_prepare_sleep hook in reduced
 hardware sleep path
Date: Thu, 25 Jul 2013 08:04:14 -0400
Message-ID: <20130725120414.GA22964@konrad-lan.dumpdata.com>
References: <1AE640813FDE7649BE1B193DEA596E88024352D2@SHSMSX101.ccr.corp.intel.com>
 <51EFC1FE.5000609@citrix.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEA87FF@ORSMSX103.amr.corp.intel.com>
 <51EFD536.8070209@citrix.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEA884D@ORSMSX103.amr.corp.intel.com>
 <51EFEF3E.8020001@citrix.com>
 <20130724163214.GB6308@phenom.dumpdata.com>
 <1AE640813FDE7649BE1B193DEA596E88024356ED@SHSMSX101.ccr.corp.intel.com>
 <CAOvdn6WZFu7TssoML3J9SPpqH_AKSi4cjvZ7Tb0zdBtq46QO0Q@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E8802435734@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21384 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab3GYMEi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2013 08:04:38 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802435734@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Ben Guthro <benjamin.guthro@citrix.com>, "Moore, Robert" <robert.moore@intel.com>, Jan Beulich <jbeulich@suse.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

CC-ing some of the tboot maintainers.
> As what I've said, it's up to the others to determine if the patch is=
 OK.
> I just need to make my concerns visible in the community. :-)

If I understand your concerns you don't want the hook to depend on any
of the bit manipulations the existing code does for the pm1 values. The
hook should do it itself case it needs to tweak them or what not.

And it also frees you from altering the ACPICA code without having to
worry about being dependent on what the input values the hook requires?

Is this what you had in mind? (not compile tested nor tested).

I am not even sure if outside the drivers/acpi you can call
acpi_hw_get_bit_register_info ..

And since the Xen bits would do the same exact bit manipulation it
probably could use a library to do pm1* stuff so both tboot and Xen
can use it.

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f84fe00..59570b1 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -273,20 +273,75 @@ static void tboot_copy_fadt(const struct acpi_tab=
le_fadt *fadt)
 		offsetof(struct acpi_table_facs, firmware_waking_vector);
 }
=20
-static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_cont=
rol)
+static int tboot_get_pm_control(bool legacy)
+{
+	u32 pm1a_control;
+	u32 pm1b_control;
+	u32 in_value;
+	acpi_status status;
+	struct acpi_bit_register_info *sleep_type_reg_info;
+	struct acpi_bit_register_info *sleep_enable_reg_info;
+
+	if (!legacy)
+		return -ENOSPC;
+
+	status =3D acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
+				       &pm1a_control);
+	if (ACPI_FAILURE(status)) {
+		return -EXXX /* something */;
+	}
+	sleep_type_reg_info =3D acpi_hw_get_bit_register_info(ACPI_BITREG_SLE=
EP_TYPE);
+	sleep_enable_reg_info =3D acpi_hw_get_bit_register_info(ACPI_BITREG_S=
LEEP_ENABLE);
+	/* Clear the SLP_EN and SLP_TYP fields */
+
+	pm1a_control &=3D ~(sleep_type_reg_info->access_bit_mask |
+			  sleep_enable_reg_info->access_bit_mask);
+	pm1b_control =3D pm1a_control;
+
+	/* Insert the SLP_TYP bits */
+
+	pm1a_control |=3D
+	    (acpi_gbl_sleep_type_a << sleep_type_reg_info->bit_position);
+	pm1b_control |=3D
+	    (acpi_gbl_sleep_type_b << sleep_type_reg_info->bit_position);
+
+	/*
+	 * We split the writes of SLP_TYP and SLP_EN to workaround
+	 * poorly implemented hardware.
+	 */
+
+	/* Write #1: write the SLP_TYP data to the PM1 Control registers */
+
+	status =3D acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
+	if (ACPI_FAILURE(status)) {
+		return -EXXX /* something */;
+	}
+
+	/* Insert the sleep enable (SLP_EN) bit */
+
+	pm1a_control |=3D sleep_enable_reg_info->access_bit_mask;
+	pm1b_control |=3D sleep_enable_reg_info->access_bit_mask;
+	tboot->acpi_sinfo.pm1a_cnt_val =3D pm1a_control;
+	tboot->acpi_sinfo.pm1b_cnt_val =3D pm1b_control;
+	return 0;
+}
+static int tboot_sleep(u8 sleep_state);
 {
 	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] =3D {
 		/* S0,1,2: */ -1, -1, -1,
 		/* S3: */ TB_SHUTDOWN_S3,
 		/* S4: */ TB_SHUTDOWN_S4,
 		/* S5: */ TB_SHUTDOWN_S5 };
+	int rc;
=20
 	if (!tboot_enabled())
 		return 0;
=20
 	tboot_copy_fadt(&acpi_gbl_FADT);
-	tboot->acpi_sinfo.pm1a_cnt_val =3D pm1a_control;
-	tboot->acpi_sinfo.pm1b_cnt_val =3D pm1b_control;
+
+	rc =3D tboot_get_pm_control();
+	if (rc < 0)
+		return -1;
 	/* we always use the 32b wakeup vector */
 	tboot->acpi_sinfo.vector_width =3D 32;
=20
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesl=
eep.c
index 5e5f762..a8e98f9 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -113,6 +113,15 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 	    !acpi_gbl_FADT.sleep_status.address) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
+       /*
+        * If using tboot or other platforms that need tweaks then
+        * do them here, and also bail out if neccessary.
+        */
+       status =3D acpi_os_prepare_sleep(sleep_state);
+       if (ACPI_SKIP(status))
+               return_ACPI_STATUS(AE_OK);
+       if (ACPI_FAILURE(status))
+               return_ACPI_STATUS(status);
=20
 	/* Clear wake status (WAK_STS) */
=20
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwslee=
p.c
index e3828cc..909b23b 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -108,6 +108,16 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
=20
+	/*
+	 * If using tboot or other platforms that need tweaks then
+	 * do them here, and also bail out if neccessary.
+	 */
+	status =3D acpi_os_prepare_sleep(sleep_state);
+	if (ACPI_SKIP(status))
+		return_ACPI_STATUS(AE_OK);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
 	/* Get current value of PM1A control */
=20
 	status =3D acpi_hw_register_read(ACPI_REGISTER_PM1_CONTROL,
@@ -152,12 +162,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
=20
 	ACPI_FLUSH_CPU_CACHE();
=20
-	status =3D acpi_os_prepare_sleep(sleep_state, pm1a_control,
-				       pm1b_control);
-	if (ACPI_SKIP(status))
-		return_ACPI_STATUS(AE_OK);
-	if (ACPI_FAILURE(status))
-		return_ACPI_STATUS(status);
 	/* Write #2: Write both SLP_TYP + SLP_EN */
=20
 	status =3D acpi_hw_write_pm1_control(pm1a_control, pm1b_control);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e721863..ffcc364 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,8 +77,7 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
=20
-static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctrl,
-				      u32 pm1b_ctrl);
+static int (*__acpi_os_prepare_sleep)(u8 sleep_state);
=20
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -1757,13 +1756,11 @@ acpi_status acpi_os_terminate(void)
 	return AE_OK;
 }
=20
-acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
-				  u32 pm1b_control)
+acpi_status acpi_os_prepare_sleep(u8 sleep_state)
 {
 	int rc =3D 0;
 	if (__acpi_os_prepare_sleep)
-		rc =3D __acpi_os_prepare_sleep(sleep_state,
-					     pm1a_control, pm1b_control);
+		rc =3D __acpi_os_prepare_sleep(sleep_state);
 	if (rc < 0)
 		return AE_ERROR;
 	else if (rc > 0)
@@ -1772,8 +1769,7 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state,=
 u32 pm1a_control,
 	return AE_OK;
 }
=20
-void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
-			       u32 pm1a_ctrl, u32 pm1b_ctrl))
+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state))
 {
 	__acpi_os_prepare_sleep =3D func;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 17b5b59..8de1043 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -480,8 +480,7 @@ static inline bool acpi_driver_match_device(struct =
device *dev,
 void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
=20
-acpi_status acpi_os_prepare_sleep(u8 sleep_state,
-				  u32 pm1a_control, u32 pm1b_control);
+acpi_status acpi_os_prepare_sleep(u8 sleep_state);
 #ifdef CONFIG_X86
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else

=2E. massive snip..
> > > On 07/24/2013 10:38 AM, Moore, Robert wrote:
> > > > I haven't found a high-level description of "acpi_os_prepare_sl=
eep",
> > perhaps I missed it.
> > > >
> > > > Can someone point me to the overall description of this change =
and why it is
> > being considered?
> > >
> > > Hi Bob,
> > >
> > > For this series, the v6 of this series does a decent job of what =
it is
> > > trying to accomplish:
> > > https://lkml.org/lkml/2013/7/1/205
> > >
> > > However, I recognize that this does not really describe *why*
> > > acpi_os_prepare_sleep is necessary to begin with. For that, we ne=
ed to
> > > go back a little more.
> > >
> > > The summary for the series that introduced it is a good descripti=
on,
> > > of the reasons it is necessary:
> > > http://lkml.indiana.edu/hypermail/linux/kernel/1112.2/00450.html
> > >
> > > In summary though - in the case of Xen (and I believe this is als=
o
> > > true in tboot) a value inappropriate for a VM (which dom0 is a sp=
ecial
> > > case
> > > of) was being written to cr3, and the physical machine would neve=
r
> > > come out of S3.
> > >
> > > This mechanism gives an os specific hook to do something else dow=
n at
> > > the lower levels, while still being able to take advantage of the
> > > large amount of OS independent code in ACPICA.
> >
> > It might be also prudent to look at original 'hook' that was added =
by Intel in the
> > Linux code to support TXT:
> >
> >
> > commit 86886e55b273f565935491816c7c96b82469d4f8
> > Author: Joseph Cihula <joseph.cihula@intel.com>
> > Date: =A0 Tue Jun 30 19:31:07 2009 -0700
> >
> > =A0 =A0 x86, intel_txt: Intel TXT Sx shutdown support
> >
> > =A0 =A0 Support for graceful handling of sleep states (S3/S4/S5) af=
ter an Intel(R)
> > TXT launch.
> >
> > =A0 =A0 Without this patch, attempting to place the system in one o=
f the ACPI
> > sleep
> > =A0 =A0 states (S3/S4/S5) will cause the TXT hardware to treat this=
 as an attack
> > and
> > =A0 =A0 will cause a system reset, with memory locked. =A0Not only =
may the
> > subsequent
> > =A0 =A0 memory scrub take some time, but the platform will be unabl=
e to enter
> > the
> > =A0 =A0 requested power state.
> >
> > =A0 =A0 This patch calls back into the tboot so that it may properl=
y and securely
> > clean
> > =A0 =A0 up system state and clear the secrets-in-memory flag, after=
 which it will
> > place
> > =A0 =A0 the system into the requested sleep state using ACPI inform=
ation passed
> > by the kernel.
> >
> > =A0 =A0 =A0arch/x86/kernel/smpboot.c =A0 =A0 | =A0 =A02 ++
> > =A0 =A0 =A0drivers/acpi/acpica/hwsleep.c | =A0 =A03 +++
> > =A0 =A0 =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
7 ++++++-
> > =A0 =A0 =A03 files changed, 11 insertions(+), 1 deletion(-)
> >
> > =A0 =A0 Signed-off-by: Joseph Cihula <joseph.cihula@intel.com>
> > =A0 =A0 Signed-off-by: Shane Wang <shane.wang@intel.com>
> > =A0 =A0 Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> >
> > I suspect that if tboot was used with a different OS (Solaris?) it =
would hit the
> > same case and a similar hook would be needed.
> >
> > Said 'hook' (which was a call to tboot_sleep) was converted to be a=
 more
> > neutral 'acpi_os_prepare_sleep' which tboot can use (and incidently=
 Xen too).
> >
> > I think what Bob is saying that if said hook is neccessary (and I b=
elieve it is - and
> > Intel TXT maintainer thinks so too since he added it in the first p=
lace), then the
> > right way of adding it is via the ACPICA tree.
> >
> > Should the discussion for this be moved there ? (https://acpica.org=
/community)
> > and an generic 'os_prepare_sleep' patch added in
> > git://github.com/acpica/acpica.git?
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in the body
> > of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
