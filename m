From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] powernow-k8: don't load powernow-k8 driver when acpi=off
Date: Thu, 23 Jul 2009 10:11:10 +0800
Message-ID: <1248315070.2670.16.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22957 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZGWCK3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jul 2009 22:10:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: davej@redhat.com
Cc: linux-acpi <linux-acpi@vger.kernel.org>, cpufreq@vger.kernel.org, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, howl.nsp@gmail.com

when acpi=3Doff, powernow-k8 driver is still loaded, and fails with
a firmware bug warning message.
http://bugzilla.kernel.org/show_bug.cgi?id=3D13695#c5

this is misleading,
we should not load powernow-k8 driver when acpi=3Doff.
http://bugzilla.kernel.org/show_bug.cgi?id=3D13695

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: David Santamar=C3=ADa Rogado <howl.nsp@gmail.com>
---
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
+++ linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
@@ -1436,6 +1436,9 @@ static int __cpuinit powernowk8_init(voi
 {
 	unsigned int i, supported_cpus =3D 0;
=20
+	if (acpi_disabled)
+		return 0;
+
 	for_each_online_cpu(i) {
 		int rc;
 		smp_call_function_single(i, check_supported_cpu, &rc, 1);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
