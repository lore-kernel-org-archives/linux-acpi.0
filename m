From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH v2] Xen/ACPI: support sleep state entering on hardware
 reduced systems
Date: Mon, 11 Mar 2013 14:06:51 +0000
Message-ID: <513DF30B02000078000C49EB@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311132127.GH23018@phenom.dumpdata.com>
 <513DEAF102000078000C496E@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part0B3B6AEB.5__="
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:33871 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab3CKOG5 (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Mon, 11 Mar 2013 10:06:57 -0400
In-Reply-To: <20130311135322.GA25036@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Gang Wei <gang.wei@intel.com>, richard.l.maliszewski@intel.com, Shane Wang <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, linux-acpi@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part0B3B6AEB.5__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
reduced hardware sleep support, and the two changes didn't get
synchronized: The new code doesn't call the hook function (if so
requested). Fix this, requiring a boolean parameter to be added to the
hook function to distinguish "extended" from "legacy" sleep.

This requires adjusting TXT, but the adjustments only go as far as
failing the extended mode call (since, looking at the TXT interface,
there doesn't even appear to be precautions to deal with that
alternative interface).

The hypervisor change underlying this is commit 62d1a69 ("ACPI: support
v5 (reduced HW) sleep interface") on the master branch of
git://xenbits.xen.org/xen.git.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
Cc: Gang Wei <gang.wei@intel.com>
Cc: Shane Wang <shane.wang@intel.com>
---
v2: Extend description to include reference to hypervisor side change.

---
 arch/x86/kernel/tboot.c          |    6 +++++-
 drivers/acpi/acpica/hwesleep.c   |    8 ++++++++
 drivers/acpi/acpica/hwsleep.c    |    2 +-
 drivers/acpi/osl.c               |   16 ++++++++--------
 drivers/xen/acpi.c               |   26 +++++++++++++-------------
 include/linux/acpi.h             |   10 +++++-----
 include/xen/acpi.h               |    4 ++--
 include/xen/interface/platform.h |    7 ++++---
 8 files changed, 46 insertions(+), 33 deletions(-)

--- 3.9-rc2/arch/x86/kernel/tboot.c
+++ 3.9-rc2-xen-ACPI-v5-sleep/arch/x86/kernel/tboot.c
@@ -273,7 +273,8 @@ static void tboot_copy_fadt(const struct
 		offsetof(struct acpi_table_facs, firmware_waking_vector);
 }
=20
-static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)=

+static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,=

+		       bool extended)
 {
 	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] =3D {
 		/* S0,1,2: */ -1, -1, -1,
@@ -284,6 +285,9 @@ static int tboot_sleep(u8 sleep_state, u
 	if (!tboot_enabled())
 		return 0;
=20
+	if (extended)
+		return -1;
+
 	tboot_copy_fadt(&acpi_gbl_FADT);
 	tboot->acpi_sinfo.pm1a_cnt_val =3D pm1a_control;
 	tboot->acpi_sinfo.pm1b_cnt_val =3D pm1b_control;
--- 3.9-rc2/drivers/acpi/acpica/hwesleep.c
+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/acpica/hwesleep.c
@@ -43,6 +43,7 @@
  */
=20
 #include <acpi/acpi.h>
+#include <linux/acpi.h>
 #include "accommon.h"
=20
 #define _COMPONENT          ACPI_HARDWARE
@@ -128,6 +129,13 @@ acpi_status acpi_hw_extended_sleep(u8 sl
=20
 	ACPI_FLUSH_CPU_CACHE();
=20
+	status =3D acpi_os_prepare_sleep(sleep_state, acpi_gbl_sleep_type_a=
,
+				       acpi_gbl_sleep_type_b, true);
+	if (ACPI_SKIP(status))
+		return_ACPI_STATUS(AE_OK);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
 	/*
 	 * Set the SLP_TYP and SLP_EN bits.
 	 *
--- 3.9-rc2/drivers/acpi/acpica/hwsleep.c
+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/acpica/hwsleep.c
@@ -153,7 +153,7 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 	ACPI_FLUSH_CPU_CACHE();
=20
 	status =3D acpi_os_prepare_sleep(sleep_state, pm1a_control,
-				       pm1b_control);
+				       pm1b_control, false);
 	if (ACPI_SKIP(status))
 		return_ACPI_STATUS(AE_OK);
 	if (ACPI_FAILURE(status))
--- 3.9-rc2/drivers/acpi/osl.c
+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/osl.c
@@ -77,8 +77,8 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
=20
-static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctrl,
-				      u32 pm1b_ctrl);
+static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 val_a, u32 =
val_b,
+				      bool extended);
=20
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -1757,13 +1757,13 @@ acpi_status acpi_os_terminate(void)
 	return AE_OK;
 }
=20
-acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
-				  u32 pm1b_control)
+acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
+				  bool extended)
 {
 	int rc =3D 0;
 	if (__acpi_os_prepare_sleep)
-		rc =3D __acpi_os_prepare_sleep(sleep_state,
-					     pm1a_control, pm1b_control);
+		rc =3D __acpi_os_prepare_sleep(sleep_state, val_a, val_b,
+					     extended);
 	if (rc < 0)
 		return AE_ERROR;
 	else if (rc > 0)
@@ -1772,8 +1772,8 @@ acpi_status acpi_os_prepare_sleep(u8 sle
 	return AE_OK;
 }
=20
-void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
-			       u32 pm1a_ctrl, u32 pm1b_ctrl))
+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
+					   u32 val_b, bool extended))
 {
 	__acpi_os_prepare_sleep =3D func;
 }
--- 3.9-rc2/drivers/xen/acpi.c
+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/xen/acpi.c
@@ -35,27 +35,27 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
=20
-int xen_acpi_notify_hypervisor_state(u8 sleep_state,
-				     u32 pm1a_cnt, u32 pm1b_cnt)
+int xen_acpi_notify_hypervisor_state(u8 sleep_state, u32 val_a, u32 =
val_b,
+				     bool extended)
 {
+	unsigned int bits =3D extended ? 8 : 16;
+
 	struct xen_platform_op op =3D {
 		.cmd =3D XENPF_enter_acpi_sleep,
 		.interface_version =3D XENPF_INTERFACE_VERSION,
-		.u =3D {
-			.enter_acpi_sleep =3D {
-				.pm1a_cnt_val =3D (u16)pm1a_cnt,
-				.pm1b_cnt_val =3D (u16)pm1b_cnt,
-				.sleep_state =3D sleep_state,
-			},
+		.u.enter_acpi_sleep =3D {
+			.val_a =3D (u16)val_a,
+			.val_b =3D (u16)val_b,
+			.sleep_state =3D sleep_state,
+			.flags =3D extended ? XENPF_ACPI_SLEEP_EXTENDED : =
0,
 		},
 	};
=20
-	if ((pm1a_cnt & 0xffff0000) || (pm1b_cnt & 0xffff0000)) {
-		WARN(1, "Using more than 16bits of PM1A/B 0x%x/0x%x!"
-		     "Email xen-devel@lists.xensource.com  Thank you.\n", =
\
-		     pm1a_cnt, pm1b_cnt);
+	if (WARN((val_a & (~0 << bits)) || (val_b & (~0 << bits)),
+		 "Using more than %u bits of sleep control values =
%#x/%#x!"
+		 "Email xen-devel@lists.xen.org - Thank you.\n", \
+		 bits, val_a, val_b))
 		return -1;
-	}
=20
 	HYPERVISOR_dom0_op(&op);
 	return 1;
--- 3.9-rc2/include/linux/acpi.h
+++ 3.9-rc2-xen-ACPI-v5-sleep/include/linux/acpi.h
@@ -486,11 +486,11 @@ static inline bool acpi_driver_match_dev
 #endif	/* !CONFIG_ACPI */
=20
 #ifdef CONFIG_ACPI
-void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
-			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
+					   u32 val_b, bool extended));
=20
-acpi_status acpi_os_prepare_sleep(u8 sleep_state,
-				  u32 pm1a_control, u32 pm1b_control);
+acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
+				  bool extended);
 #ifdef CONFIG_X86
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
@@ -500,7 +500,7 @@ static inline void arch_reserve_mem_area
 }
 #endif /* CONFIG_X86 */
 #else
-#define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } =
while (0)
+#define acpi_os_set_prepare_sleep(func, val_a, val_b, ext) do { } while =
(0)
 #endif
=20
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_RUNTIME)
--- 3.9-rc2/include/xen/acpi.h
+++ 3.9-rc2-xen-ACPI-v5-sleep/include/xen/acpi.h
@@ -75,8 +75,8 @@ static inline int xen_acpi_get_pxm(acpi_
 	return -ENXIO;
 }
=20
-int xen_acpi_notify_hypervisor_state(u8 sleep_state,
-				     u32 pm1a_cnt, u32 pm1b_cnd);
+int xen_acpi_notify_hypervisor_state(u8 sleep_state, u32 val_a, u32 =
val_b,
+				     bool extended);
=20
 static inline void xen_acpi_sleep_register(void)
 {
--- 3.9-rc2/include/xen/interface/platform.h
+++ 3.9-rc2-xen-ACPI-v5-sleep/include/xen/interface/platform.h
@@ -152,10 +152,11 @@ DEFINE_GUEST_HANDLE_STRUCT(xenpf_firmwar
 #define XENPF_enter_acpi_sleep    51
 struct xenpf_enter_acpi_sleep {
 	/* IN variables */
-	uint16_t pm1a_cnt_val;      /* PM1a control value. */
-	uint16_t pm1b_cnt_val;      /* PM1b control value. */
+	uint16_t val_a;             /* PM1a control / sleep type A. */
+	uint16_t val_b;             /* PM1b control / sleep type B. */
 	uint32_t sleep_state;       /* Which state to enter (Sn). */
-	uint32_t flags;             /* Must be zero. */
+#define XENPF_ACPI_SLEEP_EXTENDED 0x00000001
+	uint32_t flags;             /* XENPF_ACPI_SLEEP_*. */
 };
 DEFINE_GUEST_HANDLE_STRUCT(xenpf_enter_acpi_sleep_t);
=20



--=__Part0B3B6AEB.5__=
Content-Type: text/plain; name="linux-3.9-rc2-xen-ACPI-v5-sleep.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-3.9-rc2-xen-ACPI-v5-sleep.patch"

Xen/ACPI: support sleep state entering on hardware reduced systems=0A=0AIn =
version 3.4 acpi_os_prepare_sleep() got introduced in parallel with=0Areduc=
ed hardware sleep support, and the two changes didn't get=0Asynchronized: =
The new code doesn't call the hook function (if so=0Arequested). Fix this, =
requiring a boolean parameter to be added to the=0Ahook function to =
distinguish "extended" from "legacy" sleep.=0A=0AThis requires adjusting =
TXT, but the adjustments only go as far as=0Afailing the extended mode =
call (since, looking at the TXT interface,=0Athere doesn't even appear to =
be precautions to deal with that=0Aalternative interface).=0A=0AThe =
hypervisor change underlying this is commit 62d1a69 ("ACPI: support=0Av5 =
(reduced HW) sleep interface") on the master branch of=0Agit://xenbits.xen.=
org/xen.git.=0A=0ASigned-off-by: Jan Beulich <jbeulich@suse.com>=0ACc: =
Richard L Maliszewski <richard.l.maliszewski@intel.com>=0ACc: Gang Wei =
<gang.wei@intel.com>=0ACc: Shane Wang <shane.wang@intel.com>=0A---=0Av2: =
Extend description to include reference to hypervisor side change.=0A=0A---=
=0A arch/x86/kernel/tboot.c          |    6 +++++-=0A drivers/acpi/acpica/h=
wesleep.c   |    8 ++++++++=0A drivers/acpi/acpica/hwsleep.c    |    2 =
+-=0A drivers/acpi/osl.c               |   16 ++++++++--------=0A =
drivers/xen/acpi.c               |   26 +++++++++++++-------------=0A =
include/linux/acpi.h             |   10 +++++-----=0A include/xen/acpi.h   =
            |    4 ++--=0A include/xen/interface/platform.h |    7 =
++++---=0A 8 files changed, 46 insertions(+), 33 deletions(-)=0A=0A--- =
3.9-rc2/arch/x86/kernel/tboot.c=0A+++ 3.9-rc2-xen-ACPI-v5-sleep/arch/x86/ke=
rnel/tboot.c=0A@@ -273,7 +273,8 @@ static void tboot_copy_fadt(const =
struct=0A 		offsetof(struct acpi_table_facs, firmware_waking_ve=
ctor);=0A }=0A =0A-static int tboot_sleep(u8 sleep_state, u32 pm1a_control,=
 u32 pm1b_control)=0A+static int tboot_sleep(u8 sleep_state, u32 pm1a_contr=
ol, u32 pm1b_control,=0A+		       bool extended)=0A {=0A 	=
static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] =3D {=0A 		/* =
S0,1,2: */ -1, -1, -1,=0A@@ -284,6 +285,9 @@ static int tboot_sleep(u8 =
sleep_state, u=0A 	if (!tboot_enabled())=0A 		return =
0;=0A =0A+	if (extended)=0A+		return -1;=0A+=0A 	=
tboot_copy_fadt(&acpi_gbl_FADT);=0A 	tboot->acpi_sinfo.pm1a_cnt_val =3D =
pm1a_control;=0A 	tboot->acpi_sinfo.pm1b_cnt_val =3D pm1b_control;=0A=
--- 3.9-rc2/drivers/acpi/acpica/hwesleep.c=0A+++ 3.9-rc2-xen-ACPI-v5-sleep/=
drivers/acpi/acpica/hwesleep.c=0A@@ -43,6 +43,7 @@=0A  */=0A =0A #include =
<acpi/acpi.h>=0A+#include <linux/acpi.h>=0A #include "accommon.h"=0A =0A =
#define _COMPONENT          ACPI_HARDWARE=0A@@ -128,6 +129,13 @@ acpi_statu=
s acpi_hw_extended_sleep(u8 sl=0A =0A 	ACPI_FLUSH_CPU_CACHE();=0A =0A+	=
status =3D acpi_os_prepare_sleep(sleep_state, acpi_gbl_sleep_type_a,=0A+	=
			       acpi_gbl_sleep_type_b, true);=0A+	if =
(ACPI_SKIP(status))=0A+		return_ACPI_STATUS(AE_OK);=0A+	if =
(ACPI_FAILURE(status))=0A+		return_ACPI_STATUS(status);=0A+=0A =
	/*=0A 	 * Set the SLP_TYP and SLP_EN bits.=0A 	 *=0A--- 3.9-rc2/dr=
ivers/acpi/acpica/hwsleep.c=0A+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/ac=
pica/hwsleep.c=0A@@ -153,7 +153,7 @@ acpi_status acpi_hw_legacy_sleep(u8 =
slee=0A 	ACPI_FLUSH_CPU_CACHE();=0A =0A 	status =3D acpi_os_prepare_=
sleep(sleep_state, pm1a_control,=0A-				       =
pm1b_control);=0A+				       pm1b_control, =
false);=0A 	if (ACPI_SKIP(status))=0A 		return_ACPI_STATUS(=
AE_OK);=0A 	if (ACPI_FAILURE(status))=0A--- 3.9-rc2/drivers/acpi/osl.c=
=0A+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/acpi/osl.c=0A@@ -77,8 +77,8 @@ =
EXPORT_SYMBOL(acpi_in_debugger);=0A extern char line_buf[80];=0A #endif		=
		/*ENABLE_DEBUGGER */=0A =0A-static int (*__acpi_os_prepare_=
sleep)(u8 sleep_state, u32 pm1a_ctrl,=0A-				   =
   u32 pm1b_ctrl);=0A+static int (*__acpi_os_prepare_sleep)(u8 sleep_state,=
 u32 val_a, u32 val_b,=0A+				      bool =
extended);=0A =0A static acpi_osd_handler acpi_irq_handler;=0A static void =
*acpi_irq_context;=0A@@ -1757,13 +1757,13 @@ acpi_status acpi_os_terminate(=
void)=0A 	return AE_OK;=0A }=0A =0A-acpi_status acpi_os_prepare_sleep=
(u8 sleep_state, u32 pm1a_control,=0A-				  u32 =
pm1b_control)=0A+acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 =
val_a, u32 val_b,=0A+				  bool extended)=0A {=0A 	=
int rc =3D 0;=0A 	if (__acpi_os_prepare_sleep)=0A-		rc =
=3D __acpi_os_prepare_sleep(sleep_state,=0A-					=
     pm1a_control, pm1b_control);=0A+		rc =3D __acpi_os_prepare_sl=
eep(sleep_state, val_a, val_b,=0A+					   =
  extended);=0A 	if (rc < 0)=0A 		return AE_ERROR;=0A 	=
else if (rc > 0)=0A@@ -1772,8 +1772,8 @@ acpi_status acpi_os_prepare_sleep(=
u8 sle=0A 	return AE_OK;=0A }=0A =0A-void acpi_os_set_prepare_sleep(in=
t (*func)(u8 sleep_state,=0A-			       u32 pm1a_ctrl, u32 =
pm1b_ctrl))=0A+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, =
u32 val_a,=0A+					   u32 val_b, bool =
extended))=0A {=0A 	__acpi_os_prepare_sleep =3D func;=0A }=0A--- =
3.9-rc2/drivers/xen/acpi.c=0A+++ 3.9-rc2-xen-ACPI-v5-sleep/drivers/xen/acpi=
.c=0A@@ -35,27 +35,27 @@=0A #include <asm/xen/hypercall.h>=0A #include =
<asm/xen/hypervisor.h>=0A =0A-int xen_acpi_notify_hypervisor_state(u8 =
sleep_state,=0A-				     u32 pm1a_cnt, u32 =
pm1b_cnt)=0A+int xen_acpi_notify_hypervisor_state(u8 sleep_state, u32 =
val_a, u32 val_b,=0A+				     bool extended)=0A =
{=0A+	unsigned int bits =3D extended ? 8 : 16;=0A+=0A 	struct =
xen_platform_op op =3D {=0A 		.cmd =3D XENPF_enter_acpi_sleep,=0A=
 		.interface_version =3D XENPF_INTERFACE_VERSION,=0A-		=
.u =3D {=0A-			.enter_acpi_sleep =3D {=0A-			=
	.pm1a_cnt_val =3D (u16)pm1a_cnt,=0A-				=
.pm1b_cnt_val =3D (u16)pm1b_cnt,=0A-				.sleep_stat=
e =3D sleep_state,=0A-			},=0A+		.u.enter_acpi_sleep=
 =3D {=0A+			.val_a =3D (u16)val_a,=0A+			=
.val_b =3D (u16)val_b,=0A+			.sleep_state =3D sleep_stat=
e,=0A+			.flags =3D extended ? XENPF_ACPI_SLEEP_EXTENDED : =
0,=0A 		},=0A 	};=0A =0A-	if ((pm1a_cnt & 0xffff0000) || =
(pm1b_cnt & 0xffff0000)) {=0A-		WARN(1, "Using more than 16bits of =
PM1A/B 0x%x/0x%x!"=0A-		     "Email xen-devel@lists.xensource.com  =
Thank you.\n", \=0A-		     pm1a_cnt, pm1b_cnt);=0A+	if =
(WARN((val_a & (~0 << bits)) || (val_b & (~0 << bits)),=0A+		 =
"Using more than %u bits of sleep control values %#x/%#x!"=0A+		 =
"Email xen-devel@lists.xen.org - Thank you.\n", \=0A+		 bits, =
val_a, val_b))=0A 		return -1;=0A-	}=0A =0A 	HYPERVISOR_=
dom0_op(&op);=0A 	return 1;=0A--- 3.9-rc2/include/linux/acpi.h=0A+++ =
3.9-rc2-xen-ACPI-v5-sleep/include/linux/acpi.h=0A@@ -486,11 +486,11 @@ =
static inline bool acpi_driver_match_dev=0A #endif	/* !CONFIG_ACPI =
*/=0A =0A #ifdef CONFIG_ACPI=0A-void acpi_os_set_prepare_sleep(int =
(*func)(u8 sleep_state,=0A-			       u32 pm1a_ctrl,  u32 =
pm1b_ctrl));=0A+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, =
u32 val_a,=0A+					   u32 val_b, bool =
extended));=0A =0A-acpi_status acpi_os_prepare_sleep(u8 sleep_state,=0A-	=
			  u32 pm1a_control, u32 pm1b_control);=0A+acpi_stat=
us acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,=0A+		=
		  bool extended);=0A #ifdef CONFIG_X86=0A void arch_reserve=
_mem_area(acpi_physical_address addr, size_t size);=0A #else=0A@@ -500,7 =
+500,7 @@ static inline void arch_reserve_mem_area=0A }=0A #endif /* =
CONFIG_X86 */=0A #else=0A-#define acpi_os_set_prepare_sleep(func, =
pm1a_ctrl, pm1b_ctrl) do { } while (0)=0A+#define acpi_os_set_prepare_sleep=
(func, val_a, val_b, ext) do { } while (0)=0A #endif=0A =0A #if defined(CON=
FIG_ACPI) && defined(CONFIG_PM_RUNTIME)=0A--- 3.9-rc2/include/xen/acpi.h=0A=
+++ 3.9-rc2-xen-ACPI-v5-sleep/include/xen/acpi.h=0A@@ -75,8 +75,8 @@ =
static inline int xen_acpi_get_pxm(acpi_=0A 	return -ENXIO;=0A }=0A =
=0A-int xen_acpi_notify_hypervisor_state(u8 sleep_state,=0A-			=
	     u32 pm1a_cnt, u32 pm1b_cnd);=0A+int xen_acpi_notify_hypervisor=
_state(u8 sleep_state, u32 val_a, u32 val_b,=0A+				=
     bool extended);=0A =0A static inline void xen_acpi_sleep_register(void=
)=0A {=0A--- 3.9-rc2/include/xen/interface/platform.h=0A+++ 3.9-rc2-xen-ACP=
I-v5-sleep/include/xen/interface/platform.h=0A@@ -152,10 +152,11 @@ =
DEFINE_GUEST_HANDLE_STRUCT(xenpf_firmwar=0A #define XENPF_enter_acpi_sleep =
   51=0A struct xenpf_enter_acpi_sleep {=0A 	/* IN variables */=0A-	=
uint16_t pm1a_cnt_val;      /* PM1a control value. */=0A-	uint16_t =
pm1b_cnt_val;      /* PM1b control value. */=0A+	uint16_t val_a;    =
         /* PM1a control / sleep type A. */=0A+	uint16_t val_b;            =
 /* PM1b control / sleep type B. */=0A 	uint32_t sleep_state;       /* =
Which state to enter (Sn). */=0A-	uint32_t flags;             /* =
Must be zero. */=0A+#define XENPF_ACPI_SLEEP_EXTENDED 0x00000001=0A+	=
uint32_t flags;             /* XENPF_ACPI_SLEEP_*. */=0A };=0A DEFINE_GUEST=
_HANDLE_STRUCT(xenpf_enter_acpi_sleep_t);=0A =0A
--=__Part0B3B6AEB.5__=--
