From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH v2 1/3] ipmi: Raise precedence of PNP
	based discovery	mechanisms (ACPI, PCI)
Date: Sat, 13 Mar 2010 11:13:42 -0700
Message-ID: <20100313181342.20614.72981.stgit@bob.kio>
References: <20100313180121.20614.92547.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <20100313180121.20614.92547.stgit@bob.kio>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

This raises the precedence of PNP discovery mechanisms, ACPI and  PCI,
above SMBIOS and SPMI as indicated by Appendix C1 of the IPMI
specification.

Reference: IPMI - Intelligent Platform Management Interface Specification
           v2.0, Document Revision 1.0, 05.05.2005 Markup

  Appendix C1 - Locating IPMI System Interfaces via SMBIOS Tables
      "Note that the settings that this structure reports may be over-
      ridden by `Plug-and-Play' reassignment by the OS.  Therefore, this
      structure should be used only when the interface cannot be
      discovered via `Plug-and-Play' discovery mechanisms incorporated
      in interfaces such as PCI and ACPI."

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 176f175..86a7dd7 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -3197,13 +3197,6 @@ static __devinit int init_ipmi_si(void)
 
 	hardcode_find_bmc();
 
-#ifdef CONFIG_DMI
-	dmi_find_bmc();
-#endif
-
-#ifdef CONFIG_ACPI
-	spmi_find_bmc();
-#endif
 #ifdef CONFIG_ACPI
 	pnp_register_driver(&ipmi_pnp_driver);
 #endif
@@ -3220,6 +3213,14 @@ static __devinit int init_ipmi_si(void)
 	of_register_platform_driver(&ipmi_of_platform_driver);
 #endif
 
+#ifdef CONFIG_DMI
+	dmi_find_bmc();
+#endif
+
+#ifdef CONFIG_ACPI
+	spmi_find_bmc();
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
