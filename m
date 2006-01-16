From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] fix pnpacpi regression resulting from ACPICA 20051117
Date: Mon, 16 Jan 2006 16:58:58 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005B83B16@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C61AE8.0F94A2C9"
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C61AE8.0F94A2C9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
>On Monday 09 January 2006 11:53, Moore, Robert wrote:
>> The callback should be able to handle resource descriptors that it
>> doesn't know about, new ones can be added at any time.
>
>I agree; pnpacpi should just ignore tags it doesn't understand.

(dropped akpm, added Shaohua)

Okay, how about something like this (after previous patch reverted):

[ACPI] make pnpacpi not choke on end tags

fill out each resource type switch statement with
all known resource types (in order).

Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/pnp/pnpacpi/rsparser.c =
b/drivers/pnp/pnpacpi/rsparser.c
index c6db14d..407b4ea 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -177,29 +177,34 @@ static acpi_status pnpacpi_allocated_res
 		}
 		break;
=20
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-		for (i =3D 0; i < res->data.extended_irq.interrupt_count; i++) {
-			pnpacpi_parse_allocated_irqresource(res_table,
-				res->data.extended_irq.interrupts[i],
-				res->data.extended_irq.triggering,
-				res->data.extended_irq.polarity);
-		}
-		break;
 	case ACPI_RESOURCE_TYPE_DMA:
 		if (res->data.dma.channel_count > 0)
 			pnpacpi_parse_allocated_dmaresource(res_table,
 					res->data.dma.channels[0]);
 		break;
+
 	case ACPI_RESOURCE_TYPE_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
 				res->data.io.minimum,
 				res->data.io.address_length);
 		break;
+
+	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
+		break;
+
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
 		pnpacpi_parse_allocated_ioresource(res_table,
 				res->data.fixed_io.address,
 				res->data.fixed_io.address_length);
 		break;
+
+	case ACPI_RESOURCE_TYPE_VENDOR:
+		break;
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		break;
+
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		pnpacpi_parse_allocated_memresource(res_table,
 				res->data.memory24.minimum,
@@ -230,8 +235,22 @@ static acpi_status pnpacpi_allocated_res
 		res->data.address64.minimum,
 		res->data.address64.address_length);
 		break;
-	case ACPI_RESOURCE_TYPE_VENDOR:
+
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		break;
+
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		for (i =3D 0; i < res->data.extended_irq.interrupt_count; i++) {
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.extended_irq.interrupts[i],
+				res->data.extended_irq.triggering,
+				res->data.extended_irq.polarity);
+		}
+		break;
+
+	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 		break;
+
 	default:
 		pnp_warn("PnPACPI: unknown resource type %d", res->type);
 		return AE_ERROR;
@@ -510,35 +529,11 @@ static acpi_status pnpacpi_option_resour
 		case ACPI_RESOURCE_TYPE_IRQ:
 			pnpacpi_parse_irq_option(option, &res->data.irq);
 			break;
-		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-			pnpacpi_parse_ext_irq_option(option,
-				&res->data.extended_irq);
-			break;
+
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnpacpi_parse_dma_option(option, &res->data.dma);=09
 			break;
-		case ACPI_RESOURCE_TYPE_IO:
-			pnpacpi_parse_port_option(option, &res->data.io);
-			break;
-		case ACPI_RESOURCE_TYPE_FIXED_IO:
-			pnpacpi_parse_fixed_port_option(option,
-				&res->data.fixed_io);
-			break;
-		case ACPI_RESOURCE_TYPE_MEMORY24:
-			pnpacpi_parse_mem24_option(option, &res->data.memory24);
-			break;
-		case ACPI_RESOURCE_TYPE_MEMORY32:
-			pnpacpi_parse_mem32_option(option, &res->data.memory32);
-			break;
-		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
-			pnpacpi_parse_fixed_mem32_option(option,
-				&res->data.fixed_memory32);
-			break;
-		case ACPI_RESOURCE_TYPE_ADDRESS16:
-		case ACPI_RESOURCE_TYPE_ADDRESS32:
-		case ACPI_RESOURCE_TYPE_ADDRESS64:
-			pnpacpi_parse_address_option(option, res);
-			break;
+
 		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
 			switch (res->data.start_dpf.compatibility_priority) {
 				case ACPI_GOOD_CONFIGURATION:
@@ -562,6 +557,7 @@ static acpi_status pnpacpi_option_resour
 				return AE_ERROR;
 			parse_data->option =3D option;=09
 			break;
+
 		case ACPI_RESOURCE_TYPE_END_DEPENDENT:
 			/*only one EndDependentFn is allowed*/
 			if (!parse_data->option_independent) {
@@ -571,6 +567,50 @@ static acpi_status pnpacpi_option_resour
 			parse_data->option =3D parse_data->option_independent;
 			parse_data->option_independent =3D NULL;
 			break;
+
+		case ACPI_RESOURCE_TYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+
+		case ACPI_RESOURCE_TYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option,
+				&res->data.fixed_io);
+			break;
+
+		case ACPI_RESOURCE_TYPE_VENDOR:
+		case ACPI_RESOURCE_TYPE_END_TAG:
+			break;
+
+		case ACPI_RESOURCE_TYPE_MEMORY24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+
+		case ACPI_RESOURCE_TYPE_MEMORY32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+
+		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+			pnpacpi_parse_fixed_mem32_option(option,
+				&res->data.fixed_memory32);
+			break;
+
+		case ACPI_RESOURCE_TYPE_ADDRESS16:
+		case ACPI_RESOURCE_TYPE_ADDRESS32:
+		case ACPI_RESOURCE_TYPE_ADDRESS64:
+			pnpacpi_parse_address_option(option, res);
+			break;
+
+		case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+			break;
+
+		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+			pnpacpi_parse_ext_irq_option(option,
+				&res->data.extended_irq);
+			break;
+
+		case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
+			break;
+
 		default:
 			pnp_warn("PnPACPI: unknown resource type %d", res->type);
 			return AE_ERROR;
@@ -605,7 +645,6 @@ static acpi_status pnpacpi_count_resourc
 	int *res_cnt =3D (int *)data;
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 	case ACPI_RESOURCE_TYPE_DMA:
 	case ACPI_RESOURCE_TYPE_IO:
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
@@ -615,7 +654,13 @@ static acpi_status pnpacpi_count_resourc
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		(*res_cnt) ++;
+	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_VENDOR:
+	case ACPI_RESOURCE_TYPE_END_TAG:
+	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 	default:
 		return AE_OK;
 	}
@@ -628,7 +673,6 @@ static acpi_status pnpacpi_type_resource
 	struct acpi_resource **resource =3D (struct acpi_resource **)data;=09
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 	case ACPI_RESOURCE_TYPE_DMA:
 	case ACPI_RESOURCE_TYPE_IO:
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
@@ -638,8 +682,14 @@ static acpi_status pnpacpi_type_resource
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		(*resource)->type =3D res->type;
 		(*resource)++;
+	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_VENDOR:
+	case ACPI_RESOURCE_TYPE_END_TAG:
+	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 	default:
 		return AE_OK;
 	}
@@ -828,12 +878,6 @@ int pnpacpi_encode_resources(struct pnp_
 			irq++;
 			break;
=20
-		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-			pnp_dbg("Encode ext irq");
-			pnpacpi_encode_ext_irq(resource,
-				&res_table->irq_resource[irq]);
-			irq++;
-			break;
 		case ACPI_RESOURCE_TYPE_DMA:
 			pnp_dbg("Encode dma");
 			pnpacpi_encode_dma(resource,
@@ -870,6 +914,21 @@ int pnpacpi_encode_resources(struct pnp_
 				&res_table->mem_resource[mem]);
 			mem ++;
 			break;
+		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+			pnp_dbg("Encode ext irq");
+			pnpacpi_encode_ext_irq(resource,
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+		case ACPI_RESOURCE_TYPE_END_DEPENDENT:
+		case ACPI_RESOURCE_TYPE_VENDOR:
+		case ACPI_RESOURCE_TYPE_END_TAG:
+		case ACPI_RESOURCE_TYPE_ADDRESS16:
+		case ACPI_RESOURCE_TYPE_ADDRESS32:
+		case ACPI_RESOURCE_TYPE_ADDRESS64:
+		case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
 		default: /* other type */
 			pnp_warn("unknown resource type %d", resource->type);
 			return -EINVAL;

------_=_NextPart_001_01C61AE8.0F94A2C9
Content-Type: application/octet-stream;
	name="pnpacpi.diff"
Content-Transfer-Encoding: base64
Content-Description: pnpacpi.diff
Content-Disposition: attachment;
	filename="pnpacpi.diff"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG5wL3BucGFjcGkvcnNwYXJzZXIuYyBiL2RyaXZlcnMvcG5w
L3BucGFjcGkvcnNwYXJzZXIuYwppbmRleCBjNmRiMTRkLi40MDdiNGVhIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3BucC9wbnBhY3BpL3JzcGFyc2VyLmMKKysrIGIvZHJpdmVycy9wbnAvcG5wYWNwaS9y
c3BhcnNlci5jCkBAIC0xNzcsMjkgKzE3NywzNCBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgcG5wYWNw
aV9hbGxvY2F0ZWRfcmVzCiAJCX0KIAkJYnJlYWs7CiAKLQljYXNlIEFDUElfUkVTT1VSQ0VfVFlQ
RV9FWFRFTkRFRF9JUlE6Ci0JCWZvciAoaSA9IDA7IGkgPCByZXMtPmRhdGEuZXh0ZW5kZWRfaXJx
LmludGVycnVwdF9jb3VudDsgaSsrKSB7Ci0JCQlwbnBhY3BpX3BhcnNlX2FsbG9jYXRlZF9pcnFy
ZXNvdXJjZShyZXNfdGFibGUsCi0JCQkJcmVzLT5kYXRhLmV4dGVuZGVkX2lycS5pbnRlcnJ1cHRz
W2ldLAotCQkJCXJlcy0+ZGF0YS5leHRlbmRlZF9pcnEudHJpZ2dlcmluZywKLQkJCQlyZXMtPmRh
dGEuZXh0ZW5kZWRfaXJxLnBvbGFyaXR5KTsKLQkJfQotCQlicmVhazsKIAljYXNlIEFDUElfUkVT
T1VSQ0VfVFlQRV9ETUE6CiAJCWlmIChyZXMtPmRhdGEuZG1hLmNoYW5uZWxfY291bnQgPiAwKQog
CQkJcG5wYWNwaV9wYXJzZV9hbGxvY2F0ZWRfZG1hcmVzb3VyY2UocmVzX3RhYmxlLAogCQkJCQly
ZXMtPmRhdGEuZG1hLmNoYW5uZWxzWzBdKTsKIAkJYnJlYWs7CisKIAljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9JTzoKIAkJcG5wYWNwaV9wYXJzZV9hbGxvY2F0ZWRfaW9yZXNvdXJjZShyZXNfdGFi
bGUsCiAJCQkJcmVzLT5kYXRhLmlvLm1pbmltdW0sCiAJCQkJcmVzLT5kYXRhLmlvLmFkZHJlc3Nf
bGVuZ3RoKTsKIAkJYnJlYWs7CisKKwljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9TVEFSVF9ERVBF
TkRFTlQ6CisJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRU5EX0RFUEVOREVOVDoKKwkJYnJlYWs7
CisKIAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9GSVhFRF9JTzoKIAkJcG5wYWNwaV9wYXJzZV9h
bGxvY2F0ZWRfaW9yZXNvdXJjZShyZXNfdGFibGUsCiAJCQkJcmVzLT5kYXRhLmZpeGVkX2lvLmFk
ZHJlc3MsCiAJCQkJcmVzLT5kYXRhLmZpeGVkX2lvLmFkZHJlc3NfbGVuZ3RoKTsKIAkJYnJlYWs7
CisKKwljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9WRU5ET1I6CisJCWJyZWFrOworCisJY2FzZSBB
Q1BJX1JFU09VUkNFX1RZUEVfRU5EX1RBRzoKKwkJYnJlYWs7CisKIAljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9NRU1PUlkyNDoKIAkJcG5wYWNwaV9wYXJzZV9hbGxvY2F0ZWRfbWVtcmVzb3VyY2Uo
cmVzX3RhYmxlLAogCQkJCXJlcy0+ZGF0YS5tZW1vcnkyNC5taW5pbXVtLApAQCAtMjMwLDggKzIz
NSwyMiBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgcG5wYWNwaV9hbGxvY2F0ZWRfcmVzCiAJCXJlcy0+
ZGF0YS5hZGRyZXNzNjQubWluaW11bSwKIAkJcmVzLT5kYXRhLmFkZHJlc3M2NC5hZGRyZXNzX2xl
bmd0aCk7CiAJCWJyZWFrOwotCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX1ZFTkRPUjoKKworCWNh
c2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VYVEVOREVEX0FERFJFU1M2NDoKKwkJYnJlYWs7CisKKwlj
YXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9FWFRFTkRFRF9JUlE6CisJCWZvciAoaSA9IDA7IGkgPCBy
ZXMtPmRhdGEuZXh0ZW5kZWRfaXJxLmludGVycnVwdF9jb3VudDsgaSsrKSB7CisJCQlwbnBhY3Bp
X3BhcnNlX2FsbG9jYXRlZF9pcnFyZXNvdXJjZShyZXNfdGFibGUsCisJCQkJcmVzLT5kYXRhLmV4
dGVuZGVkX2lycS5pbnRlcnJ1cHRzW2ldLAorCQkJCXJlcy0+ZGF0YS5leHRlbmRlZF9pcnEudHJp
Z2dlcmluZywKKwkJCQlyZXMtPmRhdGEuZXh0ZW5kZWRfaXJxLnBvbGFyaXR5KTsKKwkJfQorCQli
cmVhazsKKworCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0dFTkVSSUNfUkVHSVNURVI6CiAJCWJy
ZWFrOworCiAJZGVmYXVsdDoKIAkJcG5wX3dhcm4oIlBuUEFDUEk6IHVua25vd24gcmVzb3VyY2Ug
dHlwZSAlZCIsIHJlcy0+dHlwZSk7CiAJCXJldHVybiBBRV9FUlJPUjsKQEAgLTUxMCwzNSArNTI5
LDExIEBAIHN0YXRpYyBhY3BpX3N0YXR1cyBwbnBhY3BpX29wdGlvbl9yZXNvdXIKIAkJY2FzZSBB
Q1BJX1JFU09VUkNFX1RZUEVfSVJROgogCQkJcG5wYWNwaV9wYXJzZV9pcnFfb3B0aW9uKG9wdGlv
biwgJnJlcy0+ZGF0YS5pcnEpOwogCQkJYnJlYWs7Ci0JCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBF
X0VYVEVOREVEX0lSUToKLQkJCXBucGFjcGlfcGFyc2VfZXh0X2lycV9vcHRpb24ob3B0aW9uLAot
CQkJCSZyZXMtPmRhdGEuZXh0ZW5kZWRfaXJxKTsKLQkJCWJyZWFrOworCiAJCWNhc2UgQUNQSV9S
RVNPVVJDRV9UWVBFX0RNQToKIAkJCXBucGFjcGlfcGFyc2VfZG1hX29wdGlvbihvcHRpb24sICZy
ZXMtPmRhdGEuZG1hKTsJCiAJCQlicmVhazsKLQkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfSU86
Ci0JCQlwbnBhY3BpX3BhcnNlX3BvcnRfb3B0aW9uKG9wdGlvbiwgJnJlcy0+ZGF0YS5pbyk7Ci0J
CQlicmVhazsKLQkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRklYRURfSU86Ci0JCQlwbnBhY3Bp
X3BhcnNlX2ZpeGVkX3BvcnRfb3B0aW9uKG9wdGlvbiwKLQkJCQkmcmVzLT5kYXRhLmZpeGVkX2lv
KTsKLQkJCWJyZWFrOwotCQljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9NRU1PUlkyNDoKLQkJCXBu
cGFjcGlfcGFyc2VfbWVtMjRfb3B0aW9uKG9wdGlvbiwgJnJlcy0+ZGF0YS5tZW1vcnkyNCk7Ci0J
CQlicmVhazsKLQkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfTUVNT1JZMzI6Ci0JCQlwbnBhY3Bp
X3BhcnNlX21lbTMyX29wdGlvbihvcHRpb24sICZyZXMtPmRhdGEubWVtb3J5MzIpOwotCQkJYnJl
YWs7Ci0JCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0ZJWEVEX01FTU9SWTMyOgotCQkJcG5wYWNw
aV9wYXJzZV9maXhlZF9tZW0zMl9vcHRpb24ob3B0aW9uLAotCQkJCSZyZXMtPmRhdGEuZml4ZWRf
bWVtb3J5MzIpOwotCQkJYnJlYWs7Ci0JCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0FERFJFU1Mx
NjoKLQkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfQUREUkVTUzMyOgotCQljYXNlIEFDUElfUkVT
T1VSQ0VfVFlQRV9BRERSRVNTNjQ6Ci0JCQlwbnBhY3BpX3BhcnNlX2FkZHJlc3Nfb3B0aW9uKG9w
dGlvbiwgcmVzKTsKLQkJCWJyZWFrOworCiAJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX1NUQVJU
X0RFUEVOREVOVDoKIAkJCXN3aXRjaCAocmVzLT5kYXRhLnN0YXJ0X2RwZi5jb21wYXRpYmlsaXR5
X3ByaW9yaXR5KSB7CiAJCQkJY2FzZSBBQ1BJX0dPT0RfQ09ORklHVVJBVElPTjoKQEAgLTU2Miw2
ICs1NTcsNyBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgcG5wYWNwaV9vcHRpb25fcmVzb3VyCiAJCQkJ
cmV0dXJuIEFFX0VSUk9SOwogCQkJcGFyc2VfZGF0YS0+b3B0aW9uID0gb3B0aW9uOwkKIAkJCWJy
ZWFrOworCiAJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VORF9ERVBFTkRFTlQ6CiAJCQkvKm9u
bHkgb25lIEVuZERlcGVuZGVudEZuIGlzIGFsbG93ZWQqLwogCQkJaWYgKCFwYXJzZV9kYXRhLT5v
cHRpb25faW5kZXBlbmRlbnQpIHsKQEAgLTU3MSw2ICs1NjcsNTAgQEAgc3RhdGljIGFjcGlfc3Rh
dHVzIHBucGFjcGlfb3B0aW9uX3Jlc291cgogCQkJcGFyc2VfZGF0YS0+b3B0aW9uID0gcGFyc2Vf
ZGF0YS0+b3B0aW9uX2luZGVwZW5kZW50OwogCQkJcGFyc2VfZGF0YS0+b3B0aW9uX2luZGVwZW5k
ZW50ID0gTlVMTDsKIAkJCWJyZWFrOworCisJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0lPOgor
CQkJcG5wYWNwaV9wYXJzZV9wb3J0X29wdGlvbihvcHRpb24sICZyZXMtPmRhdGEuaW8pOworCQkJ
YnJlYWs7CisKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRklYRURfSU86CisJCQlwbnBhY3Bp
X3BhcnNlX2ZpeGVkX3BvcnRfb3B0aW9uKG9wdGlvbiwKKwkJCQkmcmVzLT5kYXRhLmZpeGVkX2lv
KTsKKwkJCWJyZWFrOworCisJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX1ZFTkRPUjoKKwkJY2Fz
ZSBBQ1BJX1JFU09VUkNFX1RZUEVfRU5EX1RBRzoKKwkJCWJyZWFrOworCisJCWNhc2UgQUNQSV9S
RVNPVVJDRV9UWVBFX01FTU9SWTI0OgorCQkJcG5wYWNwaV9wYXJzZV9tZW0yNF9vcHRpb24ob3B0
aW9uLCAmcmVzLT5kYXRhLm1lbW9yeTI0KTsKKwkJCWJyZWFrOworCisJCWNhc2UgQUNQSV9SRVNP
VVJDRV9UWVBFX01FTU9SWTMyOgorCQkJcG5wYWNwaV9wYXJzZV9tZW0zMl9vcHRpb24ob3B0aW9u
LCAmcmVzLT5kYXRhLm1lbW9yeTMyKTsKKwkJCWJyZWFrOworCisJCWNhc2UgQUNQSV9SRVNPVVJD
RV9UWVBFX0ZJWEVEX01FTU9SWTMyOgorCQkJcG5wYWNwaV9wYXJzZV9maXhlZF9tZW0zMl9vcHRp
b24ob3B0aW9uLAorCQkJCSZyZXMtPmRhdGEuZml4ZWRfbWVtb3J5MzIpOworCQkJYnJlYWs7CisK
KwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfQUREUkVTUzE2OgorCQljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9BRERSRVNTMzI6CisJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0FERFJFU1M2NDoK
KwkJCXBucGFjcGlfcGFyc2VfYWRkcmVzc19vcHRpb24ob3B0aW9uLCByZXMpOworCQkJYnJlYWs7
CisKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRVhURU5ERURfQUREUkVTUzY0OgorCQkJYnJl
YWs7CisKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRVhURU5ERURfSVJROgorCQkJcG5wYWNw
aV9wYXJzZV9leHRfaXJxX29wdGlvbihvcHRpb24sCisJCQkJJnJlcy0+ZGF0YS5leHRlbmRlZF9p
cnEpOworCQkJYnJlYWs7CisKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfR0VORVJJQ19SRUdJ
U1RFUjoKKwkJCWJyZWFrOworCiAJCWRlZmF1bHQ6CiAJCQlwbnBfd2FybigiUG5QQUNQSTogdW5r
bm93biByZXNvdXJjZSB0eXBlICVkIiwgcmVzLT50eXBlKTsKIAkJCXJldHVybiBBRV9FUlJPUjsK
QEAgLTYwNSw3ICs2NDUsNiBAQCBzdGF0aWMgYWNwaV9zdGF0dXMgcG5wYWNwaV9jb3VudF9yZXNv
dXJjCiAJaW50ICpyZXNfY250ID0gKGludCAqKWRhdGE7CiAJc3dpdGNoIChyZXMtPnR5cGUpIHsK
IAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9JUlE6Ci0JY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVf
RVhURU5ERURfSVJROgogCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0RNQToKIAljYXNlIEFDUElf
UkVTT1VSQ0VfVFlQRV9JTzoKIAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9GSVhFRF9JTzoKQEAg
LTYxNSw3ICs2NTQsMTMgQEAgc3RhdGljIGFjcGlfc3RhdHVzIHBucGFjcGlfY291bnRfcmVzb3Vy
YwogCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0FERFJFU1MxNjoKIAljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9BRERSRVNTMzI6CiAJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfQUREUkVTUzY0Ogor
CWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VYVEVOREVEX0lSUToKIAkJKCpyZXNfY250KSArKzsK
KwljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9TVEFSVF9ERVBFTkRFTlQ6CisJY2FzZSBBQ1BJX1JF
U09VUkNFX1RZUEVfRU5EX0RFUEVOREVOVDoKKwljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9WRU5E
T1I6CisJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRU5EX1RBRzoKKwljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9HRU5FUklDX1JFR0lTVEVSOgogCWRlZmF1bHQ6CiAJCXJldHVybiBBRV9PSzsKIAl9
CkBAIC02MjgsNyArNjczLDYgQEAgc3RhdGljIGFjcGlfc3RhdHVzIHBucGFjcGlfdHlwZV9yZXNv
dXJjZQogCXN0cnVjdCBhY3BpX3Jlc291cmNlICoqcmVzb3VyY2UgPSAoc3RydWN0IGFjcGlfcmVz
b3VyY2UgKiopZGF0YTsJCiAJc3dpdGNoIChyZXMtPnR5cGUpIHsKIAljYXNlIEFDUElfUkVTT1VS
Q0VfVFlQRV9JUlE6Ci0JY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRVhURU5ERURfSVJROgogCWNh
c2UgQUNQSV9SRVNPVVJDRV9UWVBFX0RNQToKIAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9JTzoK
IAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9GSVhFRF9JTzoKQEAgLTYzOCw4ICs2ODIsMTQgQEAg
c3RhdGljIGFjcGlfc3RhdHVzIHBucGFjcGlfdHlwZV9yZXNvdXJjZQogCWNhc2UgQUNQSV9SRVNP
VVJDRV9UWVBFX0FERFJFU1MxNjoKIAljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9BRERSRVNTMzI6
CiAJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfQUREUkVTUzY0OgorCWNhc2UgQUNQSV9SRVNPVVJD
RV9UWVBFX0VYVEVOREVEX0lSUToKIAkJKCpyZXNvdXJjZSktPnR5cGUgPSByZXMtPnR5cGU7CiAJ
CSgqcmVzb3VyY2UpKys7CisJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfU1RBUlRfREVQRU5ERU5U
OgorCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VORF9ERVBFTkRFTlQ6CisJY2FzZSBBQ1BJX1JF
U09VUkNFX1RZUEVfVkVORE9SOgorCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VORF9UQUc6CisJ
Y2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfR0VORVJJQ19SRUdJU1RFUjoKIAlkZWZhdWx0OgogCQly
ZXR1cm4gQUVfT0s7CiAJfQpAQCAtODI4LDEyICs4NzgsNiBAQCBpbnQgcG5wYWNwaV9lbmNvZGVf
cmVzb3VyY2VzKHN0cnVjdCBwbnBfCiAJCQlpcnErKzsKIAkJCWJyZWFrOwogCi0JCWNhc2UgQUNQ
SV9SRVNPVVJDRV9UWVBFX0VYVEVOREVEX0lSUToKLQkJCXBucF9kYmcoIkVuY29kZSBleHQgaXJx
Iik7Ci0JCQlwbnBhY3BpX2VuY29kZV9leHRfaXJxKHJlc291cmNlLAotCQkJCSZyZXNfdGFibGUt
PmlycV9yZXNvdXJjZVtpcnFdKTsKLQkJCWlycSsrOwotCQkJYnJlYWs7CiAJCWNhc2UgQUNQSV9S
RVNPVVJDRV9UWVBFX0RNQToKIAkJCXBucF9kYmcoIkVuY29kZSBkbWEiKTsKIAkJCXBucGFjcGlf
ZW5jb2RlX2RtYShyZXNvdXJjZSwKQEAgLTg3MCw2ICs5MTQsMjEgQEAgaW50IHBucGFjcGlfZW5j
b2RlX3Jlc291cmNlcyhzdHJ1Y3QgcG5wXwogCQkJCSZyZXNfdGFibGUtPm1lbV9yZXNvdXJjZVtt
ZW1dKTsKIAkJCW1lbSArKzsKIAkJCWJyZWFrOworCQljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9F
WFRFTkRFRF9JUlE6CisJCQlwbnBfZGJnKCJFbmNvZGUgZXh0IGlycSIpOworCQkJcG5wYWNwaV9l
bmNvZGVfZXh0X2lycShyZXNvdXJjZSwKKwkJCQkmcmVzX3RhYmxlLT5pcnFfcmVzb3VyY2VbaXJx
XSk7CisJCQlpcnErKzsKKwkJCWJyZWFrOworCQljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9TVEFS
VF9ERVBFTkRFTlQ6CisJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX0VORF9ERVBFTkRFTlQ6CisJ
CWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBFX1ZFTkRPUjoKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZ
UEVfRU5EX1RBRzoKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfQUREUkVTUzE2OgorCQljYXNl
IEFDUElfUkVTT1VSQ0VfVFlQRV9BRERSRVNTMzI6CisJCWNhc2UgQUNQSV9SRVNPVVJDRV9UWVBF
X0FERFJFU1M2NDoKKwkJY2FzZSBBQ1BJX1JFU09VUkNFX1RZUEVfRVhURU5ERURfQUREUkVTUzY0
OgorCQljYXNlIEFDUElfUkVTT1VSQ0VfVFlQRV9HRU5FUklDX1JFR0lTVEVSOgogCQlkZWZhdWx0
OiAvKiBvdGhlciB0eXBlICovCiAJCQlwbnBfd2FybigidW5rbm93biByZXNvdXJjZSB0eXBlICVk
IiwgcmVzb3VyY2UtPnR5cGUpOwogCQkJcmV0dXJuIC1FSU5WQUw7Cg==

------_=_NextPart_001_01C61AE8.0F94A2C9--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
