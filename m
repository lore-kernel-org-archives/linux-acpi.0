From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Fri, 09 May 2008 09:46:44 +0800
Message-ID: <1210297604.8716.5.camel@sli10-desk.sh.intel.com>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com>
	 <4822F80C.2060704@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59995 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932781AbYEIBmu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2008 21:42:50 -0400
In-Reply-To: <4822F80C.2060704@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>

On Thu, 2008-05-08 at 21:54 +0900, Kenji Kaneshige wrote:
> Shaohua Li wrote:
> > There is an IA64 system here which have two pci root bridges with _=
OSC.
> > One _OSC disables SHPC control bit but the other not. Below patch m=
akes
> > _OSC data per-device instead of one global, otherwise linux takes b=
oth
> > root bridges don't support SHPC
> >=20
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> >=20
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 72f7476..8f17064 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -19,8 +19,29 @@
> >  #include <linux/pci-acpi.h>
> >  #include "pci.h"
> > =20
> > -static u32 ctrlset_buf[3] =3D {0, 0, 0};
> > -static u32 global_ctrlsets =3D 0;
> > +#define MAX_ACPI_OSC 30 /* Should be enough */
> > +struct acpi_osc_data {
> > +	acpi_handle handle;
> > +	u32 ctrlset_buf[3];
> > +	u32 global_ctrlsets;
> > +} acpi_osc_data_array[MAX_ACPI_OSC];
> > +
> > +struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
> > +{
>=20
> One nit pick.
> I think this should be static.
Thanks, fixed.

=EF=BB=BFThere is an IA64 system here which have two pci root bridges w=
ith _OSC.
One _OSC disables SHPC control bit but the other not. Below patch makes
_OSC data per-device instead of one global, otherwise linux takes both
root bridges don't support SHPC.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 72f7476..3fe0ccb 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -19,8 +19,29 @@
 #include <linux/pci-acpi.h>
 #include "pci.h"
=20
-static u32 ctrlset_buf[3] =3D {0, 0, 0};
-static u32 global_ctrlsets =3D 0;
+#define MAX_ACPI_OSC 30 /* Should be enough */
+static struct acpi_osc_data {
+	acpi_handle handle;
+	u32 ctrlset_buf[3];
+	u32 global_ctrlsets;
+} acpi_osc_data_array[MAX_ACPI_OSC];
+
+static struct acpi_osc_data *acpi_get_osc_data(acpi_handle handle)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_ACPI_OSC; i++) {
+		if (acpi_osc_data_array[i].handle =3D=3D handle)
+			return &acpi_osc_data_array[i];
+		if (acpi_osc_data_array[i].handle =3D=3D NULL)
+			break;
+	}
+	if (i >=3D MAX_ACPI_OSC)
+		return NULL;
+	acpi_osc_data_array[i].handle =3D handle;
+	return &acpi_osc_data_array[i];
+}
+
 static u8 OSC_UUID[16] =3D {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, =
0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
=20
 static acpi_status =20
@@ -37,8 +58,21 @@ acpi_query_osc (
 	union acpi_object 	*out_obj;
 	u32			osc_dw0;
 	acpi_status *ret_status =3D (acpi_status *)retval;
+	struct acpi_osc_data *osc_data =3D acpi_get_osc_data(handle);
+	u32 flags =3D (unsigned long)context, temp;
+
+	if (!osc_data) {
+		printk(KERN_ERR "acpi osc data array is full\n");
+		return AE_ERROR;
+	}
+
+	osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] |=3D (flags & OSC_SUPPORT_MAS=
KS);
+
+	/* do _OSC query for all possible controls */
+	temp =3D osc_data->ctrlset_buf[OSC_CONTROL_TYPE];
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] =3D OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] =3D OSC_CONTROL_MASKS;
=20
-=09
 	/* Setting up input parameters */
 	input.count =3D 4;
 	input.pointer =3D in_params;
@@ -51,13 +85,11 @@ acpi_query_osc (
 	in_params[2].integer.value	=3D 3;
 	in_params[3].type		=3D ACPI_TYPE_BUFFER;
 	in_params[3].buffer.length 	=3D 12;
-	in_params[3].buffer.pointer 	=3D (u8 *)context;
+	in_params[3].buffer.pointer 	=3D (u8 *)osc_data->ctrlset_buf;
=20
 	status =3D acpi_evaluate_object(handle, "_OSC", &input, &output);
-	if (ACPI_FAILURE (status)) {
-		*ret_status =3D status;
-		return status;
-	}
+	if (ACPI_FAILURE (status))
+		goto out_nofree;
 	out_obj =3D output.pointer;
=20
 	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
@@ -76,7 +108,7 @@ acpi_query_osc (
 			printk(KERN_DEBUG "_OSC invalid revision\n");=20
 		if (osc_dw0 & OSC_CAPABILITIES_MASK_ERROR) {
 			/* Update Global Control Set */
-			global_ctrlsets =3D *((u32 *)(out_obj->buffer.pointer+8));
+			osc_data->global_ctrlsets =3D *((u32 *)(out_obj->buffer.pointer+8))=
;
 			status =3D AE_OK;
 			goto query_osc_out;
 		}
@@ -85,12 +117,21 @@ acpi_query_osc (
 	}
=20
 	/* Update Global Control Set */
-	global_ctrlsets =3D *((u32 *)(out_obj->buffer.pointer + 8));
+	osc_data->global_ctrlsets =3D *((u32 *)(out_obj->buffer.pointer + 8))=
;
 	status =3D AE_OK;
=20
 query_osc_out:
 	kfree(output.pointer);
+out_nofree:
 	*ret_status =3D status;
+
+	osc_data->ctrlset_buf[OSC_QUERY_TYPE] =3D !OSC_QUERY_ENABLE;
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] =3D temp;
+	if (ACPI_FAILURE(status)) {
+		/* no osc support at all */
+		osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] =3D 0;
+	}
+
 	return status;
 }
=20
@@ -165,28 +206,15 @@ run_osc_out:
  **/
 acpi_status __pci_osc_support_set(u32 flags, const char *hid)
 {
-	u32 temp;
 	acpi_status retval;
=20
 	if (!(flags & OSC_SUPPORT_MASKS)) {
 		return AE_TYPE;
 	}
-	ctrlset_buf[OSC_SUPPORT_TYPE] |=3D (flags & OSC_SUPPORT_MASKS);
-
-	/* do _OSC query for all possible controls */
-	temp =3D ctrlset_buf[OSC_CONTROL_TYPE];
-	ctrlset_buf[OSC_QUERY_TYPE] =3D OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] =3D OSC_CONTROL_MASKS;
 	acpi_get_devices(hid,
 			acpi_query_osc,
-			ctrlset_buf,
+			(void *)(unsigned long)flags,
 			(void **) &retval );
-	ctrlset_buf[OSC_QUERY_TYPE] =3D !OSC_QUERY_ENABLE;
-	ctrlset_buf[OSC_CONTROL_TYPE] =3D temp;
-	if (ACPI_FAILURE(retval)) {
-		/* no osc support at all */
-		ctrlset_buf[OSC_SUPPORT_TYPE] =3D 0;
-	}
 	return AE_OK;
 }
=20
@@ -201,19 +229,25 @@ acpi_status pci_osc_control_set(acpi_handle handl=
e, u32 flags)
 {
 	acpi_status	status;
 	u32		ctrlset;
+	struct acpi_osc_data *osc_data =3D acpi_get_osc_data(handle);
+
+	if (!osc_data) {
+		printk(KERN_ERR "acpi osc data array is full\n");
+		return AE_ERROR;
+	}
=20
 	ctrlset =3D (flags & OSC_CONTROL_MASKS);
 	if (!ctrlset) {
 		return AE_TYPE;
 	}
-	if (ctrlset_buf[OSC_SUPPORT_TYPE] &&=20
-	 	((global_ctrlsets & ctrlset) !=3D ctrlset)) {
+	if (osc_data->ctrlset_buf[OSC_SUPPORT_TYPE] &&=20
+	 	((osc_data->global_ctrlsets & ctrlset) !=3D ctrlset)) {
 		return AE_SUPPORT;
 	}
-	ctrlset_buf[OSC_CONTROL_TYPE] |=3D ctrlset;
-	status =3D acpi_run_osc(handle, ctrlset_buf);
+	osc_data->ctrlset_buf[OSC_CONTROL_TYPE] |=3D ctrlset;
+	status =3D acpi_run_osc(handle, osc_data->ctrlset_buf);
 	if (ACPI_FAILURE (status)) {
-		ctrlset_buf[OSC_CONTROL_TYPE] &=3D ~ctrlset;
+		osc_data->ctrlset_buf[OSC_CONTROL_TYPE] &=3D ~ctrlset;
 	}
 =09
 	return status;



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
