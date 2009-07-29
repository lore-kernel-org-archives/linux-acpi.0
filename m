From: "Yu, Ke" <ke.yu@intel.com>
Subject: FW: [Xen-devel] [PATCH][pvops_dom0][3/4] Xen implementation of the
 external control operation interface
Date: Wed, 29 Jul 2009 10:55:50 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D64CD@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CDpdsmsx502ccrcor_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30551 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbZG2C4u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2009 22:56:50 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CDpdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch implement the external control interface for xen. It is xen spec=
ific and does not touch acpi subsystem. So only for your reference.

Best Regards
Ke

-----Original Message-----
From: xen-devel-bounces@lists.xensource.com [mailto:xen-devel-bounces@lists=
.xensource.com] On Behalf Of Yu, Ke
Sent: Sunday, July 19, 2009 2:46 PM
To: Jeremy Fitzhardinge
Cc: Tian, Kevin; xen-devel@lists.xensource.com
Subject: [Xen-devel] [PATCH][pvops_dom0][3/4] Xen implementation of the ext=
ernal control operation interface

Xen implementation of the external control operation interface

From: Yu Ke <ke.yu@intel.com>

This patch implements the Xen version of the external control operation int=
erface.

Signed-off-by: Yu Ke <ke.yu@intel.com>
Signed-off-by: Tian Kevin <kevin.tian@intel.com>
---

 drivers/xen/Kconfig             |    5 +
 drivers/xen/Makefile            |    1=20
 drivers/xen/processor_extcntl.c |  246 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 252 insertions(+), 0 deletions(-)
 create mode 100644 drivers/xen/processor_extcntl.c


diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d1b2642..c0370b6 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -98,3 +98,8 @@ config XEN_GNTDEV
 config XEN_S3
        def_bool y
        depends on XEN_DOM0 && ACPI
+
+config XEN_PROCESSOR_EXTERNAL_CONTROL
+       def_bool y
+       depends on XEN_DOM0 && PROCESSOR_EXTERNAL_CONTROL
+
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index e680033..3a1a54b 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_XEN_NETDEV_BACKEND)	+=3D netback/
 obj-$(CONFIG_XENFS)			+=3D xenfs/
 obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+=3D sys-hypervisor.o
 obj-$(CONFIG_XEN_S3)			+=3D acpi.o
+obj-$(CONFIG_XEN_PROCESSOR_EXTERNAL_CONTROL) +=3D processor_extcntl.o
diff --git a/drivers/xen/processor_extcntl.c b/drivers/xen/processor_extcnt=
l.c
new file mode 100644
index 0000000..b5b5d62
--- /dev/null
+++ b/drivers/xen/processor_extcntl.c
@@ -0,0 +1,246 @@
+/*
+ * processor_extcntl.c - interface to notify Xen
+ *
+ *  Copyright (C) 2008, Intel corporation
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, write to the Free Software Foundation, Inc.=
,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/pm.h>
+#include <linux/cpu.h>
+
+#include <linux/cpufreq.h>
+#include <acpi/processor.h>
+#include <xen/acpi.h>
+
+#include <asm/xen/hypercall.h>
+#include <asm/xen/hypervisor.h>
+
+static inline void xen_convert_pct_reg(struct xen_pct_register *xpct,
+	struct acpi_pct_register *apct)
+{
+	xpct->descriptor =3D apct->descriptor;
+	xpct->length     =3D apct->length;
+	xpct->space_id   =3D apct->space_id;
+	xpct->bit_width  =3D apct->bit_width;
+	xpct->bit_offset =3D apct->bit_offset;
+	xpct->reserved   =3D apct->reserved;
+	xpct->address    =3D apct->address;
+}
+
+static inline void xen_convert_pss_states(struct xen_processor_px *xpss,
+	struct acpi_processor_px *apss, int state_count)
+{
+	int i;
+	for(i=3D0; i<state_count; i++) {
+		xpss->core_frequency     =3D apss->core_frequency;
+		xpss->power              =3D apss->power;
+		xpss->transition_latency =3D apss->transition_latency;
+		xpss->bus_master_latency =3D apss->bus_master_latency;
+		xpss->control            =3D apss->control;
+		xpss->status             =3D apss->status;
+		xpss++;
+		apss++;
+	}
+}
+
+static inline void xen_convert_psd_pack(struct xen_psd_package *xpsd,
+	struct acpi_psd_package *apsd)
+{
+	xpsd->num_entries    =3D apsd->num_entries;
+	xpsd->revision       =3D apsd->revision;
+	xpsd->domain         =3D apsd->domain;
+	xpsd->coord_type     =3D apsd->coord_type;
+	xpsd->num_processors =3D apsd->num_processors;
+}
+
+static int xen_cx_notifier(struct acpi_processor *pr, int action)
+{
+	int ret, count =3D 0, i;
+	xen_platform_op_t op =3D {
+		.cmd			=3D XENPF_set_processor_pminfo,
+		.interface_version	=3D XENPF_INTERFACE_VERSION,
+		.u.set_pminfo.id	=3D pr->acpi_id,
+		.u.set_pminfo.type	=3D XEN_PM_CX,
+	};
+	struct xen_processor_cx *data, *buf;
+	struct acpi_processor_cx *cx;
+
+	if (action =3D=3D PROCESSOR_PM_CHANGE)
+		return -EINVAL;
+
+	/* Convert to Xen defined structure and hypercall */
+	buf =3D kzalloc(pr->power.count * sizeof(struct xen_processor_cx),
+			GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data =3D buf;
+	for (i =3D 1; i <=3D pr->power.count; i++) {
+		cx =3D &pr->power.states[i];
+		/* Skip invalid cstate entry */
+		if (!cx->valid)
+			continue;
+
+		data->type =3D cx->type;
+		data->latency =3D cx->latency;
+		data->power =3D cx->power;
+		data->reg.space_id =3D cx->reg.space_id;
+		data->reg.bit_width =3D cx->reg.bit_width;
+		data->reg.bit_offset =3D cx->reg.bit_offset;
+		data->reg.access_size =3D cx->reg.reserved;
+		data->reg.address =3D cx->reg.address;
+
+		/* Get dependency relationships, _CSD is not supported yet */
+		data->dpcnt =3D 0;
+		set_xen_guest_handle(data->dp, NULL);
+
+		data++;
+		count++;
+	}
+
+	if (!count) {
+		printk("No available Cx info for cpu %d\n", pr->acpi_id);
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	op.u.set_pminfo.power.count =3D count;
+	op.u.set_pminfo.power.flags.bm_control =3D pr->flags.bm_control;
+	op.u.set_pminfo.power.flags.bm_check =3D pr->flags.bm_check;
+	op.u.set_pminfo.power.flags.has_cst =3D pr->flags.has_cst;
+	op.u.set_pminfo.power.flags.power_setup_done =3D pr->flags.power_setup_do=
ne;
+
+	set_xen_guest_handle(op.u.set_pminfo.power.states, buf);
+	ret =3D HYPERVISOR_dom0_op(&op);
+	kfree(buf);
+	return ret;
+}
+
+static int xen_px_notifier(struct acpi_processor *pr, int action)
+{
+	int ret =3D -EINVAL;
+	xen_platform_op_t op =3D {
+		.cmd			=3D XENPF_set_processor_pminfo,
+		.interface_version	=3D XENPF_INTERFACE_VERSION,
+		.u.set_pminfo.id	=3D pr->acpi_id,
+		.u.set_pminfo.type	=3D XEN_PM_PX,
+	};
+	struct xen_processor_performance *perf;
+	struct xen_processor_px *states =3D NULL;
+	struct acpi_processor_performance *px;
+	struct acpi_psd_package *pdomain;
+
+	if (!pr)
+		return -EINVAL;
+
+	perf =3D &op.u.set_pminfo.perf;
+	px =3D pr->performance;
+
+	switch(action) {
+	case PROCESSOR_PM_CHANGE:
+		/* ppc dynamic handle */
+		perf->flags =3D XEN_PX_PPC;
+		perf->platform_limit =3D pr->performance_platform_limit;
+
+		ret =3D HYPERVISOR_dom0_op(&op);
+		break;
+
+	case PROCESSOR_PM_INIT:
+		/* px normal init */
+		perf->flags =3D XEN_PX_PPC |
+			      XEN_PX_PCT |
+			      XEN_PX_PSS |
+			      XEN_PX_PSD;
+
+		/* ppc */
+		perf->platform_limit =3D pr->performance_platform_limit;
+
+		/* pct */
+		xen_convert_pct_reg(&perf->control_register, &px->control_register);
+		xen_convert_pct_reg(&perf->status_register, &px->status_register);
+
+		/* pss */
+		perf->state_count =3D px->state_count;
+		states =3D kzalloc(px->state_count*sizeof(xen_processor_px_t),GFP_KERNEL=
);
+		if (!states)
+			return -ENOMEM;
+		xen_convert_pss_states(states, px->states, px->state_count);
+		set_xen_guest_handle(perf->states, states);
+
+		/* psd */
+		pdomain =3D &px->domain_info;
+		xen_convert_psd_pack(&perf->domain_info, pdomain);
+		if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_ALL)
+			perf->shared_type =3D CPUFREQ_SHARED_TYPE_ALL;
+		else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_SW_ANY)
+			perf->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
+		else if (pdomain->coord_type =3D=3D DOMAIN_COORD_TYPE_HW_ALL)
+			perf->shared_type =3D CPUFREQ_SHARED_TYPE_HW;
+		else {
+			ret =3D -ENODEV;
+			kfree(states);
+			break;
+		}
+
+		ret =3D HYPERVISOR_dom0_op(&op);
+		kfree(states);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int xen_tx_notifier(struct acpi_processor *pr, int action)
+{
+	return -EINVAL;
+}
+static int xen_hotplug_notifier(struct acpi_processor *pr, int event)
+{
+	return -EINVAL;
+}
+
+static struct processor_extcntl_ops xen_extcntl_ops =3D {
+	.hotplug		=3D xen_hotplug_notifier,
+};
+
+static int __init xen_acpi_processor_extcntl_init(void)
+{
+	unsigned int pmbits =3D (xen_start_info->flags & SIF_PM_MASK) >> 8;
+
+	if (!pmbits)
+		return 0;
+	if (pmbits & XEN_PROCESSOR_PM_CX)
+		xen_extcntl_ops.pm_ops[PM_TYPE_IDLE] =3D xen_cx_notifier;
+	if (pmbits & XEN_PROCESSOR_PM_PX)
+		xen_extcntl_ops.pm_ops[PM_TYPE_PERF] =3D xen_px_notifier;
+	if (pmbits & XEN_PROCESSOR_PM_TX)
+		xen_extcntl_ops.pm_ops[PM_TYPE_THR] =3D xen_tx_notifier;
+
+	processor_extcntl_register(&xen_extcntl_ops);
+	return 0;
+}
+
+subsys_initcall(xen_acpi_processor_extcntl_init);

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CDpdsmsx502ccrcor_
Content-Type: application/octet-stream; name="external-control-xen.patch"
Content-Description: external-control-xen.patch
Content-Disposition: attachment; filename="external-control-xen.patch";
	size=8525; creation-date="Sun, 19 Jul 2009 21:50:46 GMT";
	modification-date="Sun, 19 Jul 2009 21:36:28 GMT"
Content-Transfer-Encoding: base64

WGVuIGltcGxlbWVudGF0aW9uIG9mIHRoZSBleHRlcm5hbCBjb250cm9sIG9wZXJhdGlvbiBpbnRl
cmZhY2UKCkZyb206IFl1IEtlIDxrZS55dUBpbnRlbC5jb20+CgpUaGlzIHBhdGNoIGltcGxlbWVu
dHMgdGhlIFhlbiB2ZXJzaW9uIG9mIHRoZSBleHRlcm5hbCBjb250cm9sIG9wZXJhdGlvbiBpbnRl
cmZhY2UuCgpTaWduZWQtb2ZmLWJ5OiBZdSBLZSA8a2UueXVAaW50ZWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBUaWFuIEtldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT4KLS0tCgogZHJpdmVycy94ZW4v
S2NvbmZpZyAgICAgICAgICAgICB8ICAgIDUgKwogZHJpdmVycy94ZW4vTWFrZWZpbGUgICAgICAg
ICAgICB8ICAgIDEgCiBkcml2ZXJzL3hlbi9wcm9jZXNzb3JfZXh0Y250bC5jIHwgIDI0NiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjUy
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy94ZW4vcHJvY2Vzc29yX2V4dGNudGwuYwoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9LY29u
ZmlnIGIvZHJpdmVycy94ZW4vS2NvbmZpZwppbmRleCBkMWIyNjQyLi5jMDM3MGI2IDEwMDY0NAot
LS0gYS9kcml2ZXJzL3hlbi9LY29uZmlnCisrKyBiL2RyaXZlcnMveGVuL0tjb25maWcKQEAgLTk4
LDMgKzk4LDggQEAgY29uZmlnIFhFTl9HTlRERVYKIGNvbmZpZyBYRU5fUzMKICAgICAgICBkZWZf
Ym9vbCB5CiAgICAgICAgZGVwZW5kcyBvbiBYRU5fRE9NMCAmJiBBQ1BJCisKK2NvbmZpZyBYRU5f
UFJPQ0VTU09SX0VYVEVSTkFMX0NPTlRST0wKKyAgICAgICBkZWZfYm9vbCB5CisgICAgICAgZGVw
ZW5kcyBvbiBYRU5fRE9NMCAmJiBQUk9DRVNTT1JfRVhURVJOQUxfQ09OVFJPTAorCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3hlbi9NYWtlZmlsZSBiL2RyaXZlcnMveGVuL01ha2VmaWxlCmluZGV4IGU2
ODAwMzMuLjNhMWE1NGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMveGVuL01ha2VmaWxlCisrKyBiL2Ry
aXZlcnMveGVuL01ha2VmaWxlCkBAIC0xMSwzICsxMSw0IEBAIG9iai0kKENPTkZJR19YRU5fTkVU
REVWX0JBQ0tFTkQpCSs9IG5ldGJhY2svCiBvYmotJChDT05GSUdfWEVORlMpCQkJKz0geGVuZnMv
CiBvYmotJChDT05GSUdfWEVOX1NZU19IWVBFUlZJU09SKQkrPSBzeXMtaHlwZXJ2aXNvci5vCiBv
YmotJChDT05GSUdfWEVOX1MzKQkJCSs9IGFjcGkubworb2JqLSQoQ09ORklHX1hFTl9QUk9DRVNT
T1JfRVhURVJOQUxfQ09OVFJPTCkgKz0gcHJvY2Vzc29yX2V4dGNudGwubwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy94ZW4vcHJvY2Vzc29yX2V4dGNudGwuYyBiL2RyaXZlcnMveGVuL3Byb2Nlc3Nvcl9l
eHRjbnRsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYjViNWQ2MgotLS0g
L2Rldi9udWxsCisrKyBiL2RyaXZlcnMveGVuL3Byb2Nlc3Nvcl9leHRjbnRsLmMKQEAgLTAsMCAr
MSwyNDYgQEAKKy8qCisgKiBwcm9jZXNzb3JfZXh0Y250bC5jIC0gaW50ZXJmYWNlIHRvIG5vdGlm
eSBYZW4KKyAqCisgKiAgQ29weXJpZ2h0IChDKSAyMDA4LCBJbnRlbCBjb3Jwb3JhdGlvbgorICoK
KyAqIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQg
YnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvciAoYXQKKyAqICB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0
IHdpbGwgYmUgdXNlZnVsLCBidXQKKyAqICBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUKKyAqICBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCisg
KiAgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbiwgSW5jLiwKKyAqICA1OSBUZW1wbGUgUGxhY2UsIFN1aXRlIDMzMCwgQm9zdG9u
LCBNQSAwMjExMS0xMzA3IFVTQS4KKyAqCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
PgorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2FjcGkuaD4KKyNpbmNsdWRlIDxsaW51eC9wbS5oPgorI2luY2x1ZGUgPGxp
bnV4L2NwdS5oPgorCisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgorI2luY2x1ZGUgPGFjcGkv
cHJvY2Vzc29yLmg+CisjaW5jbHVkZSA8eGVuL2FjcGkuaD4KKworI2luY2x1ZGUgPGFzbS94ZW4v
aHlwZXJjYWxsLmg+CisjaW5jbHVkZSA8YXNtL3hlbi9oeXBlcnZpc29yLmg+CisKK3N0YXRpYyBp
bmxpbmUgdm9pZCB4ZW5fY29udmVydF9wY3RfcmVnKHN0cnVjdCB4ZW5fcGN0X3JlZ2lzdGVyICp4
cGN0LAorCXN0cnVjdCBhY3BpX3BjdF9yZWdpc3RlciAqYXBjdCkKK3sKKwl4cGN0LT5kZXNjcmlw
dG9yID0gYXBjdC0+ZGVzY3JpcHRvcjsKKwl4cGN0LT5sZW5ndGggICAgID0gYXBjdC0+bGVuZ3Ro
OworCXhwY3QtPnNwYWNlX2lkICAgPSBhcGN0LT5zcGFjZV9pZDsKKwl4cGN0LT5iaXRfd2lkdGgg
ID0gYXBjdC0+Yml0X3dpZHRoOworCXhwY3QtPmJpdF9vZmZzZXQgPSBhcGN0LT5iaXRfb2Zmc2V0
OworCXhwY3QtPnJlc2VydmVkICAgPSBhcGN0LT5yZXNlcnZlZDsKKwl4cGN0LT5hZGRyZXNzICAg
ID0gYXBjdC0+YWRkcmVzczsKK30KKworc3RhdGljIGlubGluZSB2b2lkIHhlbl9jb252ZXJ0X3Bz
c19zdGF0ZXMoc3RydWN0IHhlbl9wcm9jZXNzb3JfcHggKnhwc3MsCisJc3RydWN0IGFjcGlfcHJv
Y2Vzc29yX3B4ICphcHNzLCBpbnQgc3RhdGVfY291bnQpCit7CisJaW50IGk7CisJZm9yKGk9MDsg
aTxzdGF0ZV9jb3VudDsgaSsrKSB7CisJCXhwc3MtPmNvcmVfZnJlcXVlbmN5ICAgICA9IGFwc3Mt
PmNvcmVfZnJlcXVlbmN5OworCQl4cHNzLT5wb3dlciAgICAgICAgICAgICAgPSBhcHNzLT5wb3dl
cjsKKwkJeHBzcy0+dHJhbnNpdGlvbl9sYXRlbmN5ID0gYXBzcy0+dHJhbnNpdGlvbl9sYXRlbmN5
OworCQl4cHNzLT5idXNfbWFzdGVyX2xhdGVuY3kgPSBhcHNzLT5idXNfbWFzdGVyX2xhdGVuY3k7
CisJCXhwc3MtPmNvbnRyb2wgICAgICAgICAgICA9IGFwc3MtPmNvbnRyb2w7CisJCXhwc3MtPnN0
YXR1cyAgICAgICAgICAgICA9IGFwc3MtPnN0YXR1czsKKwkJeHBzcysrOworCQlhcHNzKys7CisJ
fQorfQorCitzdGF0aWMgaW5saW5lIHZvaWQgeGVuX2NvbnZlcnRfcHNkX3BhY2soc3RydWN0IHhl
bl9wc2RfcGFja2FnZSAqeHBzZCwKKwlzdHJ1Y3QgYWNwaV9wc2RfcGFja2FnZSAqYXBzZCkKK3sK
Kwl4cHNkLT5udW1fZW50cmllcyAgICA9IGFwc2QtPm51bV9lbnRyaWVzOworCXhwc2QtPnJldmlz
aW9uICAgICAgID0gYXBzZC0+cmV2aXNpb247CisJeHBzZC0+ZG9tYWluICAgICAgICAgPSBhcHNk
LT5kb21haW47CisJeHBzZC0+Y29vcmRfdHlwZSAgICAgPSBhcHNkLT5jb29yZF90eXBlOworCXhw
c2QtPm51bV9wcm9jZXNzb3JzID0gYXBzZC0+bnVtX3Byb2Nlc3NvcnM7Cit9CisKK3N0YXRpYyBp
bnQgeGVuX2N4X25vdGlmaWVyKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIsIGludCBhY3Rpb24p
Cit7CisJaW50IHJldCwgY291bnQgPSAwLCBpOworCXhlbl9wbGF0Zm9ybV9vcF90IG9wID0gewor
CQkuY21kCQkJPSBYRU5QRl9zZXRfcHJvY2Vzc29yX3BtaW5mbywKKwkJLmludGVyZmFjZV92ZXJz
aW9uCT0gWEVOUEZfSU5URVJGQUNFX1ZFUlNJT04sCisJCS51LnNldF9wbWluZm8uaWQJPSBwci0+
YWNwaV9pZCwKKwkJLnUuc2V0X3BtaW5mby50eXBlCT0gWEVOX1BNX0NYLAorCX07CisJc3RydWN0
IHhlbl9wcm9jZXNzb3JfY3ggKmRhdGEsICpidWY7CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX2N4
ICpjeDsKKworCWlmIChhY3Rpb24gPT0gUFJPQ0VTU09SX1BNX0NIQU5HRSkKKwkJcmV0dXJuIC1F
SU5WQUw7CisKKwkvKiBDb252ZXJ0IHRvIFhlbiBkZWZpbmVkIHN0cnVjdHVyZSBhbmQgaHlwZXJj
YWxsICovCisJYnVmID0ga3phbGxvYyhwci0+cG93ZXIuY291bnQgKiBzaXplb2Yoc3RydWN0IHhl
bl9wcm9jZXNzb3JfY3gpLAorCQkJR0ZQX0tFUk5FTCk7CisJaWYgKCFidWYpCisJCXJldHVybiAt
RU5PTUVNOworCisJZGF0YSA9IGJ1ZjsKKwlmb3IgKGkgPSAxOyBpIDw9IHByLT5wb3dlci5jb3Vu
dDsgaSsrKSB7CisJCWN4ID0gJnByLT5wb3dlci5zdGF0ZXNbaV07CisJCS8qIFNraXAgaW52YWxp
ZCBjc3RhdGUgZW50cnkgKi8KKwkJaWYgKCFjeC0+dmFsaWQpCisJCQljb250aW51ZTsKKworCQlk
YXRhLT50eXBlID0gY3gtPnR5cGU7CisJCWRhdGEtPmxhdGVuY3kgPSBjeC0+bGF0ZW5jeTsKKwkJ
ZGF0YS0+cG93ZXIgPSBjeC0+cG93ZXI7CisJCWRhdGEtPnJlZy5zcGFjZV9pZCA9IGN4LT5yZWcu
c3BhY2VfaWQ7CisJCWRhdGEtPnJlZy5iaXRfd2lkdGggPSBjeC0+cmVnLmJpdF93aWR0aDsKKwkJ
ZGF0YS0+cmVnLmJpdF9vZmZzZXQgPSBjeC0+cmVnLmJpdF9vZmZzZXQ7CisJCWRhdGEtPnJlZy5h
Y2Nlc3Nfc2l6ZSA9IGN4LT5yZWcucmVzZXJ2ZWQ7CisJCWRhdGEtPnJlZy5hZGRyZXNzID0gY3gt
PnJlZy5hZGRyZXNzOworCisJCS8qIEdldCBkZXBlbmRlbmN5IHJlbGF0aW9uc2hpcHMsIF9DU0Qg
aXMgbm90IHN1cHBvcnRlZCB5ZXQgKi8KKwkJZGF0YS0+ZHBjbnQgPSAwOworCQlzZXRfeGVuX2d1
ZXN0X2hhbmRsZShkYXRhLT5kcCwgTlVMTCk7CisKKwkJZGF0YSsrOworCQljb3VudCsrOworCX0K
KworCWlmICghY291bnQpIHsKKwkJcHJpbnRrKCJObyBhdmFpbGFibGUgQ3ggaW5mbyBmb3IgY3B1
ICVkXG4iLCBwci0+YWNwaV9pZCk7CisJCWtmcmVlKGJ1Zik7CisJCXJldHVybiAtRUlOVkFMOwor
CX0KKworCW9wLnUuc2V0X3BtaW5mby5wb3dlci5jb3VudCA9IGNvdW50OworCW9wLnUuc2V0X3Bt
aW5mby5wb3dlci5mbGFncy5ibV9jb250cm9sID0gcHItPmZsYWdzLmJtX2NvbnRyb2w7CisJb3Au
dS5zZXRfcG1pbmZvLnBvd2VyLmZsYWdzLmJtX2NoZWNrID0gcHItPmZsYWdzLmJtX2NoZWNrOwor
CW9wLnUuc2V0X3BtaW5mby5wb3dlci5mbGFncy5oYXNfY3N0ID0gcHItPmZsYWdzLmhhc19jc3Q7
CisJb3AudS5zZXRfcG1pbmZvLnBvd2VyLmZsYWdzLnBvd2VyX3NldHVwX2RvbmUgPSBwci0+Zmxh
Z3MucG93ZXJfc2V0dXBfZG9uZTsKKworCXNldF94ZW5fZ3Vlc3RfaGFuZGxlKG9wLnUuc2V0X3Bt
aW5mby5wb3dlci5zdGF0ZXMsIGJ1Zik7CisJcmV0ID0gSFlQRVJWSVNPUl9kb20wX29wKCZvcCk7
CisJa2ZyZWUoYnVmKTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IHhlbl9weF9ub3Rp
ZmllcihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgYWN0aW9uKQoreworCWludCByZXQg
PSAtRUlOVkFMOworCXhlbl9wbGF0Zm9ybV9vcF90IG9wID0geworCQkuY21kCQkJPSBYRU5QRl9z
ZXRfcHJvY2Vzc29yX3BtaW5mbywKKwkJLmludGVyZmFjZV92ZXJzaW9uCT0gWEVOUEZfSU5URVJG
QUNFX1ZFUlNJT04sCisJCS51LnNldF9wbWluZm8uaWQJPSBwci0+YWNwaV9pZCwKKwkJLnUuc2V0
X3BtaW5mby50eXBlCT0gWEVOX1BNX1BYLAorCX07CisJc3RydWN0IHhlbl9wcm9jZXNzb3JfcGVy
Zm9ybWFuY2UgKnBlcmY7CisJc3RydWN0IHhlbl9wcm9jZXNzb3JfcHggKnN0YXRlcyA9IE5VTEw7
CisJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1hbmNlICpweDsKKwlzdHJ1Y3QgYWNwaV9w
c2RfcGFja2FnZSAqcGRvbWFpbjsKKworCWlmICghcHIpCisJCXJldHVybiAtRUlOVkFMOworCisJ
cGVyZiA9ICZvcC51LnNldF9wbWluZm8ucGVyZjsKKwlweCA9IHByLT5wZXJmb3JtYW5jZTsKKwor
CXN3aXRjaChhY3Rpb24pIHsKKwljYXNlIFBST0NFU1NPUl9QTV9DSEFOR0U6CisJCS8qIHBwYyBk
eW5hbWljIGhhbmRsZSAqLworCQlwZXJmLT5mbGFncyA9IFhFTl9QWF9QUEM7CisJCXBlcmYtPnBs
YXRmb3JtX2xpbWl0ID0gcHItPnBlcmZvcm1hbmNlX3BsYXRmb3JtX2xpbWl0OworCisJCXJldCA9
IEhZUEVSVklTT1JfZG9tMF9vcCgmb3ApOworCQlicmVhazsKKworCWNhc2UgUFJPQ0VTU09SX1BN
X0lOSVQ6CisJCS8qIHB4IG5vcm1hbCBpbml0ICovCisJCXBlcmYtPmZsYWdzID0gWEVOX1BYX1BQ
QyB8CisJCQkgICAgICBYRU5fUFhfUENUIHwKKwkJCSAgICAgIFhFTl9QWF9QU1MgfAorCQkJICAg
ICAgWEVOX1BYX1BTRDsKKworCQkvKiBwcGMgKi8KKwkJcGVyZi0+cGxhdGZvcm1fbGltaXQgPSBw
ci0+cGVyZm9ybWFuY2VfcGxhdGZvcm1fbGltaXQ7CisKKwkJLyogcGN0ICovCisJCXhlbl9jb252
ZXJ0X3BjdF9yZWcoJnBlcmYtPmNvbnRyb2xfcmVnaXN0ZXIsICZweC0+Y29udHJvbF9yZWdpc3Rl
cik7CisJCXhlbl9jb252ZXJ0X3BjdF9yZWcoJnBlcmYtPnN0YXR1c19yZWdpc3RlciwgJnB4LT5z
dGF0dXNfcmVnaXN0ZXIpOworCisJCS8qIHBzcyAqLworCQlwZXJmLT5zdGF0ZV9jb3VudCA9IHB4
LT5zdGF0ZV9jb3VudDsKKwkJc3RhdGVzID0ga3phbGxvYyhweC0+c3RhdGVfY291bnQqc2l6ZW9m
KHhlbl9wcm9jZXNzb3JfcHhfdCksR0ZQX0tFUk5FTCk7CisJCWlmICghc3RhdGVzKQorCQkJcmV0
dXJuIC1FTk9NRU07CisJCXhlbl9jb252ZXJ0X3Bzc19zdGF0ZXMoc3RhdGVzLCBweC0+c3RhdGVz
LCBweC0+c3RhdGVfY291bnQpOworCQlzZXRfeGVuX2d1ZXN0X2hhbmRsZShwZXJmLT5zdGF0ZXMs
IHN0YXRlcyk7CisKKwkJLyogcHNkICovCisJCXBkb21haW4gPSAmcHgtPmRvbWFpbl9pbmZvOwor
CQl4ZW5fY29udmVydF9wc2RfcGFjaygmcGVyZi0+ZG9tYWluX2luZm8sIHBkb21haW4pOworCQlp
ZiAocGRvbWFpbi0+Y29vcmRfdHlwZSA9PSBET01BSU5fQ09PUkRfVFlQRV9TV19BTEwpCisJCQlw
ZXJmLT5zaGFyZWRfdHlwZSA9IENQVUZSRVFfU0hBUkVEX1RZUEVfQUxMOworCQllbHNlIGlmIChw
ZG9tYWluLT5jb29yZF90eXBlID09IERPTUFJTl9DT09SRF9UWVBFX1NXX0FOWSkKKwkJCXBlcmYt
PnNoYXJlZF90eXBlID0gQ1BVRlJFUV9TSEFSRURfVFlQRV9BTlk7CisJCWVsc2UgaWYgKHBkb21h
aW4tPmNvb3JkX3R5cGUgPT0gRE9NQUlOX0NPT1JEX1RZUEVfSFdfQUxMKQorCQkJcGVyZi0+c2hh
cmVkX3R5cGUgPSBDUFVGUkVRX1NIQVJFRF9UWVBFX0hXOworCQllbHNlIHsKKwkJCXJldCA9IC1F
Tk9ERVY7CisJCQlrZnJlZShzdGF0ZXMpOworCQkJYnJlYWs7CisJCX0KKworCQlyZXQgPSBIWVBF
UlZJU09SX2RvbTBfb3AoJm9wKTsKKwkJa2ZyZWUoc3RhdGVzKTsKKwkJYnJlYWs7CisKKwlkZWZh
dWx0OgorCQlicmVhazsKKwl9CisKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IHhlbl90
eF9ub3RpZmllcihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgYWN0aW9uKQoreworCXJl
dHVybiAtRUlOVkFMOworfQorc3RhdGljIGludCB4ZW5faG90cGx1Z19ub3RpZmllcihzdHJ1Y3Qg
YWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgZXZlbnQpCit7CisJcmV0dXJuIC1FSU5WQUw7Cit9CisK
K3N0YXRpYyBzdHJ1Y3QgcHJvY2Vzc29yX2V4dGNudGxfb3BzIHhlbl9leHRjbnRsX29wcyA9IHsK
KwkuaG90cGx1ZwkJPSB4ZW5faG90cGx1Z19ub3RpZmllciwKK307CisKK3N0YXRpYyBpbnQgX19p
bml0IHhlbl9hY3BpX3Byb2Nlc3Nvcl9leHRjbnRsX2luaXQodm9pZCkKK3sKKwl1bnNpZ25lZCBp
bnQgcG1iaXRzID0gKHhlbl9zdGFydF9pbmZvLT5mbGFncyAmIFNJRl9QTV9NQVNLKSA+PiA4Owor
CisJaWYgKCFwbWJpdHMpCisJCXJldHVybiAwOworCWlmIChwbWJpdHMgJiBYRU5fUFJPQ0VTU09S
X1BNX0NYKQorCQl4ZW5fZXh0Y250bF9vcHMucG1fb3BzW1BNX1RZUEVfSURMRV0gPSB4ZW5fY3hf
bm90aWZpZXI7CisJaWYgKHBtYml0cyAmIFhFTl9QUk9DRVNTT1JfUE1fUFgpCisJCXhlbl9leHRj
bnRsX29wcy5wbV9vcHNbUE1fVFlQRV9QRVJGXSA9IHhlbl9weF9ub3RpZmllcjsKKwlpZiAocG1i
aXRzICYgWEVOX1BST0NFU1NPUl9QTV9UWCkKKwkJeGVuX2V4dGNudGxfb3BzLnBtX29wc1tQTV9U
WVBFX1RIUl0gPSB4ZW5fdHhfbm90aWZpZXI7CisKKwlwcm9jZXNzb3JfZXh0Y250bF9yZWdpc3Rl
cigmeGVuX2V4dGNudGxfb3BzKTsKKwlyZXR1cm4gMDsKK30KKworc3Vic3lzX2luaXRjYWxsKHhl
bl9hY3BpX3Byb2Nlc3Nvcl9leHRjbnRsX2luaXQpOwo=

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CDpdsmsx502ccrcor_
Content-Type: text/plain; name="ATT00001.txt"
Content-Description: ATT00001.txt
Content-Disposition: attachment; filename="ATT00001.txt"; size=142;
	creation-date="Sun, 19 Jul 2009 14:48:37 GMT";
	modification-date="Sun, 19 Jul 2009 14:48:37 GMT"
Content-Transfer-Encoding: base64

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClhlbi1kZXZl
bCBtYWlsaW5nIGxpc3QNClhlbi1kZXZlbEBsaXN0cy54ZW5zb3VyY2UuY29tDQpodHRwOi8vbGlz
dHMueGVuc291cmNlLmNvbS94ZW4tZGV2ZWwNCg==

--_003_4D05DB80B95B23498C72C700BD6C2E0B315D64CDpdsmsx502ccrcor_--
