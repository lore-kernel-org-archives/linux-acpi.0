From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] cleanups in ACPI - removing tboot_ calls for
	3.4 (v1)
Date: Tue, 17 Jan 2012 15:50:06 -0500
Message-ID: <1326833408-23685-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, x86@kernel.org, joseph.cihula@intel.com, linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net, len.brown@intel.com, rjw@sisk.pl, mingo@redhat.com
List-Id: linux-acpi@vger.kernel.org

I am not really sure if these patches should go through the ACPI or x86 tree.
I think they are more x86-ish related and earlier patches for tboot went through
tip.. Thoughts?

Theset two patches cleanup the ACPI code by removing the 'tboot_sleep'
function call within the ACPI call and instead use a function call.

The function call is set if Intel TXT is detected, otherwise we just skip over
and continue on in hwsleep.c.

Tested on AMD, Intel w/TXT and w/o TXT. Also compile tested on IA64 which has
some reference to tboot but does not use it.

The diff-stat:
 arch/x86/kernel/tboot.c       |    9 ++++++---
 drivers/acpi/acpica/hwsleep.c |   10 +++++++---
 drivers/acpi/osl.c            |   24 ++++++++++++++++++++++++
 include/acpi/acexcep.h        |    1 +
 include/linux/acpi.h          |   10 ++++++++++
 include/linux/tboot.h         |    1 -
 6 files changed, 48 insertions(+), 7 deletions(-)


The purpose of this cleanup is two-fold:
 1). Cleanup the call a bit - that 'tboot_sleep' in ACPICA, which is suppose to be
     OS-agnostic code looks odd.
 2). Piggy-back on the function call if running under Xen [https://lkml.org/lkml/2011/12/16/447].
     Those patches are still going through review, but the cleanup patches
     can be submitted as standalone.

Thanks! 

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
