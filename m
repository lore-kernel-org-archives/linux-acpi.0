From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [GIT PATCH] thinkpad-acpi queue for the 2.6.26
	merge window
Date: Thu, 10 Apr 2008 00:52:52 -0300
Message-ID: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Len,

This patchset has my current thinkpad-acpi queue.  The target is 2.6.26's
merge window.

Some of the thinkpad-acpi patches require patches from Richard Purdie's LED
tree that are already in -mm.  As far as I know, those are usually merged
early when the merge window opens, so that shouldn't be a big problem.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Note that the above repository branch *DOES* have Richard's LED patches
already merged in on top of 2.6.25-rc8 as a merge commit, and the
thinkpad-acpi queue merged in as another merge commit.  The LED tree can be
found at: git://git.o-hand.com/linux-rpurdie-leds for-mm

Shortlog (with the LED tree stuff removed):

Henrique de Moraes Holschuh (13):
      ACPI: thinkpad-acpi: BIOS backlight mode helper (v2)
      ACPI: thinkpad-acpi: warn once about weird hotkey masks
      ACPI: thinkpad-acpi: enhance box identification output
      ACPI: thinkpad-acpi: rate-limit CMOS/EC unsynced error messages
      ACPI: thinkpad-acpi: fix brightness dimming control bug
      ACPI: thinkpad-acpi: claim tpacpi as an official short handle
      ACPI: thinkpad-acpi: prepare light and LED for sysfs support
      ACPI: thinkpad-acpi: add sysfs led class support for thinklight (v3.1)
      ACPI: thinkpad-acpi: add sysfs led class support to thinkpad leds (v3.1)
      ACPI: thinkpad-acpi: fluff really minor fix
      ACPI: thinkpad-acpi: use a private workqueue
      ACPI: thinkpad-acpi: fix selects in Kconfig
      ACPI: thinkpad-acpi: bump up version to 0.20

Please merge the thinkpad-acpi changesets for acpi-test, for the next
mainline merge window.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
