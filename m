From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Stable inclusion request - ACPI GPE regression fixes
Date: Tue, 29 Jun 2010 12:48:42 +0200
Message-ID: <201006291248.42552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_K+cKMZymVWluQEH"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59957 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257Ab0F2KuZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jun 2010 06:50:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, stable@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

--Boundary-00=_K+cKMZymVWluQEH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Greg,

Please include the following commits

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e4e9a735991c80fb0fc1bd4a13a93681c3c17ce0
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd247447c1d94a79d5cfc647430784306b3a8323
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c9a8bbb7704cbf515c0fc68970abbe4e91d68521
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ce43ace02320a3fb9614ddb27edc3a8700d68b26
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9d3c752de65dbfa6e522f1d666deb0ac152ef367

(in this order) into the next 2.6.34.y release.  They are not necessary for
older -stable kernels.

The first one should apply to 2.6.34.  The second one
(fd247447c1d94a79d5cfc647430784306b3a8323) unfortunately doesn't, so attached
is a backport of it to the 2.6.34 code base.  The remaining 3 patches should
apply on top of it.

Thanks,
Rafael

--Boundary-00=_K+cKMZymVWluQEH
Content-Type: text/x-patch;
  charset="UTF-8";
  name="ACPI-ACPICA-Fix-low-level-GPE-manipulation-code.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ACPI-ACPICA-Fix-low-level-GPE-manipulation-code.patch"

=46rom fd247447c1d94a79d5cfc647430784306b3a8323 Mon Sep 17 00:00:00 2001
=46rom: Rafael J. Wysocki <rjw@sisk.pl>
Date: Tue, 8 Jun 2010 10:49:08 +0200
Subject: [PATCH] ACPI / ACPICA: Fix low-level GPE manipulation code

ACPICA uses acpi_ev_enable_gpe() for enabling GPEs at the low level,
which is incorrect, because this function only enables the GPE if the
corresponding bit in its enable register's enable_for_run mask is set.
This causes acpi_set_gpe() to work incorrectly if used for enabling
GPEs that were not previously enabled with acpi_enable_gpe().  As a
result, among other things, wakeup-only GPEs are never enabled by
acpi_enable_wakeup_device(), so the devices that use them are unable
to wake up the system.

To fix this issue remove acpi_ev_enable_gpe() and its counterpart
acpi_ev_disable_gpe() and replace acpi_hw_low_disable_gpe() with
acpi_hw_low_set_gpe() that will be used instead to manipulate GPE
enable bits at the low level.  Make the users of acpi_ev_enable_gpe()
and acpi_ev_disable_gpe() call acpi_hw_low_set_gpe() instead and
make sure that GPE enable masks are only updated by acpi_enable_gpe()
and acpi_disable_gpe() when GPE reference counters change from 0
to 1 and from 1 to 0, respectively.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
=2D--
 drivers/acpi/acpica/acevents.h |    4 --
 drivers/acpi/acpica/achware.h  |    3 +
 drivers/acpi/acpica/evgpe.c    |   78 +-----------------------------------=
=2D----
 drivers/acpi/acpica/evxfevnt.c |   66 ++++++++++++++++++++++++++++++----
 drivers/acpi/acpica/hwgpe.c    |   26 +++++++++++--
 include/acpi/acexcep.h         |    2 -
 6 files changed, 84 insertions(+), 95 deletions(-)

Index: linux-2.6-stable/drivers/acpi/acpica/acevents.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6-stable/drivers/acpi/acpica/acevents.h
@@ -78,10 +78,6 @@ acpi_ev_queue_notify_request(struct acpi
 acpi_status
 acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info=
);
=20
=2Dacpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_inf=
o);
=2D
=2Dacpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_in=
fo);
=2D
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_dev=
ice,
 						       u32 gpe_number);
=20
Index: linux-2.6-stable/drivers/acpi/acpica/achware.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/drivers/acpi/acpica/achware.h
+++ linux-2.6-stable/drivers/acpi/acpica/achware.h
@@ -93,7 +93,8 @@ acpi_status acpi_hw_write_port(acpi_io_a
 u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
 			     struct acpi_gpe_register_info *gpe_register_info);
=20
=2Dacpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_even=
t_info);
+acpi_status
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action);
=20
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
Index: linux-2.6-stable/drivers/acpi/acpica/evgpe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6-stable/drivers/acpi/acpica/evgpe.c
@@ -94,76 +94,6 @@ acpi_ev_update_gpe_enable_masks(struct a
=20
 /*************************************************************************=
******
  *
=2D * FUNCTION:    acpi_ev_enable_gpe
=2D *
=2D * PARAMETERS:  gpe_event_info          - GPE to enable
=2D *
=2D * RETURN:      Status
=2D *
=2D * DESCRIPTION: Enable a GPE based on the GPE type
=2D *
=2D ***********************************************************************=
*******/
=2D
=2Dacpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_inf=
o)
=2D{
=2D	acpi_status status;
=2D
=2D	ACPI_FUNCTION_TRACE(ev_enable_gpe);
=2D
=2D	/* Make sure HW enable masks are updated */
=2D
=2D	status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
=2D	if (ACPI_FAILURE(status))
=2D		return_ACPI_STATUS(status);
=2D
=2D	/* Clear the GPE (of stale events), then enable it */
=2D	status =3D acpi_hw_clear_gpe(gpe_event_info);
=2D	if (ACPI_FAILURE(status))
=2D		return_ACPI_STATUS(status);
=2D
=2D	/* Enable the requested GPE */
=2D	status =3D acpi_hw_write_gpe_enable_reg(gpe_event_info);
=2D	return_ACPI_STATUS(status);
=2D}
=2D
=2D/***********************************************************************=
********
=2D *
=2D * FUNCTION:    acpi_ev_disable_gpe
=2D *
=2D * PARAMETERS:  gpe_event_info          - GPE to disable
=2D *
=2D * RETURN:      Status
=2D *
=2D * DESCRIPTION: Disable a GPE based on the GPE type
=2D *
=2D ***********************************************************************=
*******/
=2D
=2Dacpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_in=
fo)
=2D{
=2D	acpi_status status;
=2D
=2D	ACPI_FUNCTION_TRACE(ev_disable_gpe);
=2D
=2D	/* Make sure HW enable masks are updated */
=2D
=2D	status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
=2D	if (ACPI_FAILURE(status))
=2D		return_ACPI_STATUS(status);
=2D
=2D	/*
=2D	 * Even if we don't know the GPE type, make sure that we always
=2D	 * disable it. low_disable_gpe will just clear the enable bit for this
=2D	 * GPE and write it. It will not write out the current GPE enable mask,
=2D	 * since this may inadvertently enable GPEs too early, if a rogue GPE h=
as
=2D	 * come in during ACPICA initialization - possibly as a result of AML or
=2D	 * other code that has enabled the GPE.
=2D	 */
=2D	status =3D acpi_hw_low_disable_gpe(gpe_event_info);
=2D	return_ACPI_STATUS(status);
=2D}
=2D
=2D/***********************************************************************=
********
=2D *
  * FUNCTION:    acpi_ev_get_gpe_event_info
  *
  * PARAMETERS:  gpe_device          - Device node. NULL for GPE0/GPE1
@@ -388,10 +318,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		return_VOID;
 	}
=20
=2D	/* Set the GPE flags for return to enabled state */
=2D
=2D	(void)acpi_ev_update_gpe_enable_masks(gpe_event_info);
=2D
 	/*
 	 * Take a snapshot of the GPE info for this level - we copy the info to
 	 * prevent a race condition with remove_handler/remove_block.
@@ -544,7 +470,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE, so it doesn't keep firing before the method has a
 		 * chance to run (it runs asynchronously with interrupts enabled).
 		 */
=2D		status =3D acpi_ev_disable_gpe(gpe_event_info);
+		status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",
@@ -578,7 +504,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		 * Disable the GPE. The GPE will remain disabled until the ACPICA
 		 * Core Subsystem is restarted, or a handler is installed.
 		 */
=2D		status =3D acpi_ev_disable_gpe(gpe_event_info);
+		status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to disable GPE[%2X]",
Index: linux-2.6-stable/drivers/acpi/acpica/evxfevnt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6-stable/drivers/acpi/acpica/evxfevnt.c
@@ -201,6 +201,44 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
=20
 /*************************************************************************=
******
  *
+ * FUNCTION:    acpi_clear_and_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear the given GPE from stale events and enable it.
+ *
+ *************************************************************************=
*****/
+static acpi_status
+acpi_clear_and_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status;
+
+	/*
+	 * We will only allow a GPE to be enabled if it has either an
+	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
+	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
+	 * first time it fires.
+	 */
+	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+		return_ACPI_STATUS(AE_NO_HANDLER);
+	}
+
+	/* Clear the GPE (of stale events) */
+	status =3D acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Enable the requested GPE */
+	status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+
+	return_ACPI_STATUS(status);
+}
+
+/*************************************************************************=
******
+ *
  * FUNCTION:    acpi_set_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device
@@ -235,11 +273,11 @@ acpi_status acpi_set_gpe(acpi_handle gpe
=20
 	switch (action) {
 	case ACPI_GPE_ENABLE:
=2D		status =3D acpi_ev_enable_gpe(gpe_event_info);
+		status =3D acpi_clear_and_enable_gpe(gpe_event_info);
 		break;
=20
 	case ACPI_GPE_DISABLE:
=2D		status =3D acpi_ev_disable_gpe(gpe_event_info);
+		status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
 		break;
=20
 	default:
@@ -291,9 +329,13 @@ acpi_status acpi_enable_gpe(acpi_handle=20
=20
 	if (type & ACPI_GPE_TYPE_RUNTIME) {
 		if (++gpe_event_info->runtime_count =3D=3D 1) {
=2D			status =3D acpi_ev_enable_gpe(gpe_event_info);
=2D			if (ACPI_FAILURE(status))
+			status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status)) {
+				status =3D acpi_clear_and_enable_gpe(gpe_event_info);
+			}
+			if (ACPI_FAILURE(status)) {
 				gpe_event_info->runtime_count--;
+			}
 		}
 	}
=20
@@ -308,7 +350,7 @@ acpi_status acpi_enable_gpe(acpi_handle=20
 		 * system into a sleep state.
 		 */
 		if (++gpe_event_info->wakeup_count =3D=3D 1)
=2D			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
 	}
=20
 unlock_and_exit:
@@ -351,8 +393,16 @@ acpi_status acpi_disable_gpe(acpi_handle
 	}
=20
 	if ((type & ACPI_GPE_TYPE_RUNTIME) && gpe_event_info->runtime_count) {
=2D		if (--gpe_event_info->runtime_count =3D=3D 0)
=2D			status =3D acpi_ev_disable_gpe(gpe_event_info);
+		if (--gpe_event_info->runtime_count =3D=3D 0) {
+			status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			if (ACPI_SUCCESS(status)) {
+				status =3D acpi_hw_low_set_gpe(gpe_event_info,
+							     ACPI_GPE_DISABLE);
+			}
+			if (ACPI_FAILURE(status)) {
+				gpe_event_info->runtime_count++;
+			}
+		}
 	}
=20
 	if ((type & ACPI_GPE_TYPE_WAKE) && gpe_event_info->wakeup_count) {
@@ -361,7 +411,7 @@ acpi_status acpi_disable_gpe(acpi_handle
 		 * states, so we don't need to disable them here.
 		 */
 		if (--gpe_event_info->wakeup_count =3D=3D 0)
=2D			acpi_ev_update_gpe_enable_masks(gpe_event_info);
+			status =3D acpi_ev_update_gpe_enable_masks(gpe_event_info);
 	}
=20
 unlock_and_exit:
Index: linux-2.6-stable/drivers/acpi/acpica/hwgpe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-2.6-stable/drivers/acpi/acpica/hwgpe.c
@@ -78,23 +78,27 @@ u32 acpi_hw_gpe_register_bit(struct acpi
=20
 /*************************************************************************=
*****
  *
=2D * FUNCTION:	acpi_hw_low_disable_gpe
+ * FUNCTION:	acpi_hw_low_set_gpe
  *
  * PARAMETERS:	gpe_event_info	    - Info block for the GPE to be disabled
+ *		action		    - Enable or disable
  *
  * RETURN:	Status
  *
=2D * DESCRIPTION: Disable a single GPE in the enable register.
+ * DESCRIPTION: Enable or disable a single GPE in its enable register.
  *
  *************************************************************************=
*****/
=20
=2Dacpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_even=
t_info)
+acpi_status
+acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
 	u32 enable_mask;
 	u32 register_bit;
=20
+	ACPI_FUNCTION_ENTRY();
+
 	/* Get the info block for the entire GPE register */
=20
 	gpe_register_info =3D gpe_event_info->register_info;
@@ -109,11 +113,23 @@ acpi_status acpi_hw_low_disable_gpe(stru
 		return (status);
 	}
=20
=2D	/* Clear just the bit that corresponds to this GPE */
+	/* Set or clear just the bit that corresponds to this GPE */
=20
 	register_bit =3D acpi_hw_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
=2D	ACPI_CLEAR_BIT(enable_mask, register_bit);
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+		ACPI_SET_BIT(enable_mask, register_bit);
+		break;
+
+	case ACPI_GPE_DISABLE:
+		ACPI_CLEAR_BIT(enable_mask, register_bit);
+		break;
+
+	default:
+		ACPI_ERROR((AE_INFO, "Invalid action\n"));
+		return (AE_BAD_PARAMETER);
+	}
=20
 	/* Write the updated enable mask */
=20
Index: linux-2.6-stable/include/acpi/acexcep.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6-stable.orig/include/acpi/acexcep.h
+++ linux-2.6-stable/include/acpi/acexcep.h
@@ -87,7 +87,7 @@
 #define AE_NO_GLOBAL_LOCK               (acpi_status) (0x0017 | AE_CODE_EN=
VIRONMENTAL)
 #define AE_ABORT_METHOD                 (acpi_status) (0x0018 | AE_CODE_EN=
VIRONMENTAL)
 #define AE_SAME_HANDLER                 (acpi_status) (0x0019 | AE_CODE_EN=
VIRONMENTAL)
=2D#define AE_WAKE_ONLY_GPE                (acpi_status) (0x001A | AE_CODE_=
ENVIRONMENTAL)
+#define AE_NO_HANDLER                   (acpi_status) (0x001A | AE_CODE_EN=
VIRONMENTAL)
 #define AE_OWNER_ID_LIMIT               (acpi_status) (0x001B | AE_CODE_EN=
VIRONMENTAL)
=20
 #define AE_CODE_ENV_MAX                 0x001B

--Boundary-00=_K+cKMZymVWluQEH--
