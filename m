From: "Manpreet Singh" <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Subject: RE: Fix wake GPE enabling
Date: Wed, 7 Apr 2004 15:20:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EB6B0A91B0F6AC44842492A8F6852CDE0C4534@fcexmb01.efi.internal>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Robert,

How about a /proc or /sys interface that calls AcpiEnableGpe and/or =
alters
the WakeEnable vector? Would that be consistent?

In what other ways do you suggest exporting this to the user space?

Thanks,
Manpreet.


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Moore,
Robert
Sent: Wednesday, April 07, 2004 2:35 PM
To: Dominik Brodowski; Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Grover, Andrew
Subject: RE: [ACPI] Fix wake GPE enabling



No, this does not fit the model correctly.

It is the responsibility of the upper software to selectively enable the
devices which are to be used for wakeup.  This is one of the functions
of the AcpiGpeEnable interface.  The ACPI CA core cannot just blindly
enable all "wake" GPEs.

The ACPI CA core simply identifies the "wake" GPEs in order to leave
them disabled during runtime.

Therefore, in (1) and (2) below, this is the correct behavior.  No
"wake" GPEs are enabled.

Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Dominik
Brodowski
Sent: Wednesday, April 07, 2004 1:54 PM
To: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Fix wake GPE enabling

While trying to get ACPI sleep states to run on my three test systems, I
found these bugs in ACPI's handling of the GPE blocks:

1.) gpe_block->wake_enable is zero, as even for ACPI_GPE_TYPE_WAKE
    discovered during boot no call to acpi_hw_enable_gpe_for_wakeup() is
    done.

2.) The if-wrapping by acpi_gbl_leave_wake_gpes_disabled around the
    acpi_ev_get_gpe_type walk caused that there is done no distinction
    between TYPE_WAKE and TYPE_RUNTIME --> gpe_block->wake_enable would
    _stay_ zero.

So, the attached patch does the following things:

- enable TYPE_WAKE GPEs for wakeup
- unconditionally differenciate between TYPE_WAKE and TYPE_RUNTIME GPEs
- if acpi_gbl_leave_wake_gpes_disabled is set, skip the runtime enabling
  of TYPE_WAKE GPEs
- else enable all (TYPE_WAKE and TYPE_RUNTIME) GPEs.

With this patch, my Centrino notebook resumes from S3, network et al.
works
fine, but the screen stays dark... without this patch, I can press the
power
button for minutes, and nothing happens.

BTW, Intel may incorporate this diff into their OS-independent ACPI
distribution... all stuff below drivers/acpi/* is in there, isn't it?

diff -ruN linux-original/drivers/acpi/events/evgpeblk.c
linux/drivers/acpi/events/evgpeblk.c
--- linux-original/drivers/acpi/events/evgpeblk.c	2004-04-06
21:04:18.000000000 +0200
+++ linux/drivers/acpi/events/evgpeblk.c	2004-04-07
22:09:31.129961936 +0200
@@ -374,6 +374,7 @@
=20
 		gpe_event_info =3D &gpe_block->event_info[gpe_number -
gpe_block->block_base_number];
 		gpe_event_info->flags |=3D ACPI_GPE_TYPE_WAKE;
+		acpi_hw_enable_gpe_for_wakeup(gpe_event_info);
 	}
=20
 cleanup:
@@ -813,6 +814,7 @@
 	acpi_native_uint                i;
 	acpi_native_uint                j;
 	u32                             wake_gpe_count;
+	u32                             runtime_gpe_count;
 	u32                             gpe_enabled_count;
 	acpi_status                     status;
 	struct acpi_gpe_walk_info       gpe_info;
@@ -874,28 +876,21 @@
=20
 	/*
 	 * Runtime option: Should Wake GPEs be enabled at runtime?  The
default is
-	 * No,they should only be enabled just as the machine goes to
sleep.
+	 * Yes, by Linus' opinion.
+	 *
+	 * Differentiate RUNTIME vs WAKE GPEs, via the _PRW control
methods. (Each
+	 * GPE that has one or more _PRWs that reference it is by
definition a
+	 * WAKE GPE and will not be enabled while the machine is
running.)
 	 */
-	if (acpi_gbl_leave_wake_gpes_disabled) {
-		/*
-		 * Differentiate RUNTIME vs WAKE GPEs, via the _PRW
control methods. (Each
-		 * GPE that has one or more _PRWs that reference it is
by definition a
-		 * WAKE GPE and will not be enabled while the machine is
running.)
-		 */
-		gpe_info.gpe_block =3D gpe_block;
-		gpe_info.gpe_device =3D gpe_device;
+	gpe_info.gpe_block =3D gpe_block;
+	gpe_info.gpe_device =3D gpe_device;
=20
-		status =3D acpi_ns_walk_namespace (ACPI_TYPE_DEVICE,
ACPI_ROOT_OBJECT,
-				  ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
acpi_ev_get_gpe_type,
-				  &gpe_info, NULL);
-	}
+	status =3D acpi_ns_walk_namespace (ACPI_TYPE_DEVICE,
ACPI_ROOT_OBJECT,
+					 ACPI_UINT32_MAX,
ACPI_NS_WALK_UNLOCK, acpi_ev_get_gpe_type,
+					 &gpe_info, NULL);
=20
-	/*
-	 * Enable all GPEs in this block that are 1) "runtime" GPEs, and
2) have
-	 * a corresponding _Lxx or _Exx method.  All other GPEs must be
enabled via
-	 * the acpi_enable_gpe() external interface.
-	 */
 	wake_gpe_count =3D 0;
+	runtime_gpe_count =3D 0;
 	gpe_enabled_count =3D 0;
=20
 	for (i =3D 0; i < gpe_block->register_count; i++) {
@@ -903,9 +898,14 @@
 			/* Get the info block for this particular GPE */
=20
 			gpe_event_info =3D &gpe_block->event_info[(i *
ACPI_GPE_REGISTER_WIDTH) + j];
-			if ((gpe_event_info->method_node) &&
-			   ((gpe_event_info->flags & ACPI_GPE_TYPE_MASK)
=3D=3D ACPI_GPE_TYPE_RUNTIME)) {
-				/* Enable this GPE, it is 1) RUNTIME and
2) has an _Lxx or _Exx method */
+			if (gpe_event_info->method_node) {
+				if ((gpe_event_info->flags &
ACPI_GPE_TYPE_MASK) =3D=3D ACPI_GPE_TYPE_WAKE) {
+					wake_gpe_count++;
+					if
(acpi_gbl_leave_wake_gpes_disabled)
+						continue;
+				} else if ((gpe_event_info->flags &
ACPI_GPE_TYPE_MASK) =3D=3D ACPI_GPE_TYPE_RUNTIME) {
+					runtime_gpe_count++;
+				}
=20
 				status =3D acpi_hw_enable_gpe
(gpe_event_info);
 				if (ACPI_FAILURE (status)) {
@@ -913,16 +913,12 @@
 				}
 				gpe_enabled_count++;
 			}
-
-			if ((gpe_event_info->flags & ACPI_GPE_TYPE_MASK)
=3D=3D ACPI_GPE_TYPE_WAKE) {
-				wake_gpe_count++;
-			}
 		}
 	}
=20
 	ACPI_DEBUG_PRINT ((ACPI_DB_INIT,
-			"Found %u Wake, Enabled %u Runtime GPEs in this
block\n",
-			wake_gpe_count, gpe_enabled_count));
+			"Found %u Wake, %u Runtime GPEs in this block,
and enabled %u of them\n",
+			wake_gpe_count, runtime_gpe_count,
gpe_enabled_count));
=20
 	/* Return the new block */
=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
