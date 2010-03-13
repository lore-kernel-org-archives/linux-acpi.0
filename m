From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH v2 2/3] ipmi: Convert tracking of the
	ACPI device pointer to a	PNP device
Date: Sat, 13 Mar 2010 11:13:47 -0700
Message-ID: <20100313181347.20614.7897.stgit@bob.kio>
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
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Convert PNP patch (git 9e368fa011d4e0aa050db348d69514900520e40b) to
maintain a pointer to a PNP device, 'pnp_dev', instead of the ACPI
device, 'acpi_dev', that is currently being tracked with PNP based
IPMI device discovery.

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 86a7dd7..0e31aa9 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2093,7 +2093,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		info->irq_setup = std_irq_setup;
 	}
 
-	info->dev = &acpi_dev->dev;
+	info->dev = &dev->dev;
 	pnp_set_drvdata(dev, info);
 
 	return try_smi_init(info);


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
