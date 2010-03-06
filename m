From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Q] How to tell we're using the KMS (during suspend/resume) outside
	the graphics driver
Date: Sat, 6 Mar 2010 22:36:09 +0100
Message-ID: <201003062236.09801.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,

For at least two reasons it would be beneficial for some code outisde the
graphics driver(s) to know if the KMS are used.

First, in the non-KMS (ie. UMS) case we probably wouldn't want to call
acpi_video_resume(), because that has a potential to mess up with the GPU
(it actually is known to do that on at least one system).

Second, in the KMS case, we'd be able to skip the kernel VT switch, because
the KMS driver uses its own framebuffer anyway.

So, is there any reasonable way to check that from the outside of the graphics
driver?  It should be general enough to cover the cases when there are two
graphics adapters with different drivers in the system and so forth.

Rafael

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
