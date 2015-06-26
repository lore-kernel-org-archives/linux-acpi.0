From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ACPI: Remove FSF mailing addresses
Date: Fri, 26 Jun 2015 11:27:41 +0300
Message-ID: <1435307261-7478-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:1062 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbbFZI1u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jun 2015 04:27:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, devel@acpica.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>

There is no need to carry potentially outdated Free Software Foundation
mailing address in file headers since the COPYING file includes it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/acpi/ac.c                   | 4 ----
 drivers/acpi/acpi_ipmi.c            | 4 ----
 drivers/acpi/acpi_memhotplug.c      | 5 -----
 drivers/acpi/acpi_pad.c             | 4 ----
 drivers/acpi/acpi_video.c           | 4 ----
 drivers/acpi/apei/apei-base.c       | 4 ----
 drivers/acpi/apei/einj.c            | 4 ----
 drivers/acpi/apei/erst-dbg.c        | 4 ----
 drivers/acpi/apei/erst.c            | 4 ----
 drivers/acpi/apei/ghes.c            | 4 ----
 drivers/acpi/apei/hest.c            | 4 ----
 drivers/acpi/battery.c              | 4 ----
 drivers/acpi/blacklist.c            | 4 ----
 drivers/acpi/bus.c                  | 4 ----
 drivers/acpi/button.c               | 4 ----
 drivers/acpi/cm_sbs.c               | 4 ----
 drivers/acpi/container.c            | 4 ----
 drivers/acpi/device_pm.c            | 4 ----
 drivers/acpi/dock.c                 | 4 ----
 drivers/acpi/ec.c                   | 4 ----
 drivers/acpi/fan.c                  | 4 ----
 drivers/acpi/hed.c                  | 4 ----
 drivers/acpi/internal.h             | 3 ---
 drivers/acpi/numa.c                 | 4 ----
 drivers/acpi/osl.c                  | 4 ----
 drivers/acpi/pci_irq.c              | 4 ----
 drivers/acpi/pci_link.c             | 4 ----
 drivers/acpi/pci_root.c             | 4 ----
 drivers/acpi/pci_slot.c             | 4 ----
 drivers/acpi/power.c                | 4 ----
 drivers/acpi/processor_driver.c     | 4 ----
 drivers/acpi/processor_idle.c       | 4 ----
 drivers/acpi/processor_perflib.c    | 4 ----
 drivers/acpi/processor_thermal.c    | 4 ----
 drivers/acpi/processor_throttling.c | 4 ----
 drivers/acpi/resource.c             | 4 ----
 drivers/acpi/sbs.c                  | 4 ----
 drivers/acpi/tables.c               | 4 ----
 drivers/acpi/thermal.c              | 4 ----
 drivers/acpi/utils.c                | 4 ----
 include/acpi/acpi_bus.h             | 4 ----
 include/acpi/acpi_drivers.h         | 4 ----
 include/linux/acpi.h                | 4 ----
 43 files changed, 172 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 9b5354a2cd08..f71b756b05c4 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index ac0f52f6df2b..f77956c3fd45 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -17,10 +17,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index ee28f4d15625..6b0d3ef7309c 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -16,11 +16,6 @@
  * NON INFRINGEMENT.  See the GNU General Public License for more
  * details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *
  * ACPI based HotPlug driver that supports Memory Hotplug
  * This driver fields notifications from firmware for memory add
  * and remove operations and alerts the VM of the affected memory
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 00b39802d7ec..ae307ff36acb 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -12,10 +12,6 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 8c2fe2f2f9fd..5778e8e4313a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -17,10 +17,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a85ac07f3da3..a2c8d7adb6eb 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -24,10 +24,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a095d4f858da..0431883653be 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -18,10 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 04ab5c9d3ced..6330f557a2c8 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -17,10 +17,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 3670bbab57a3..6682c5daf742 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -18,10 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2bfd53cbfe80..23981ac1c6c2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -23,10 +23,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 06e9b411a0a2..20b3fcf4007c 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -21,10 +21,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b3628cc01a53..b719ab3090bb 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -18,10 +18,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 1d1791935c31..3b1d17179f51 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -20,10 +20,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 513e7230e3d0..c8356eb79911 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -15,10 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 6d5d1832a588..5c3b0918d5fd 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 6c9ee68e46fb..d0918d421f90 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -11,10 +11,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index c8ead9f97375..12c240903c18 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -20,10 +20,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/acpi.h>
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 717afcdb5f4a..d06cd59b5906 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -15,10 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a688aa243f6c..e8e128dede29 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -17,10 +17,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9d4761d2f6b7..990446629935 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -22,10 +22,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index bea0bbaafa97..e297a480e135 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index a322710b5ba4..5c67a6d8f803 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -15,10 +15,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 787c629bc9b4..17bb44695c49 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -13,9 +13,6 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef _ACPI_INTERNAL_H_
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 1333cbdc3ea2..6242af42bb02 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -15,10 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a5dc9034efee..e6a2f169ff04 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -19,10 +19,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 304eccb0ae5c..25fff35df82c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -19,10 +19,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index cfd7581cc19f..2f5f84ced85f 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -17,10 +17,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  * TBD: 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 1b5569c092c6..393706a5261b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 139d9e479370..7188e53b6b7c 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -20,10 +20,6 @@
  *  WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 93eac53b5110..45b47f2c9f03 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d9f71581b79b..3af8dc30f129 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -21,10 +21,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d540f42c9232..175c86bee3a9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -21,10 +21,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index cfc8aba72f86..53cfe8ba9799 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -20,10 +20,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index e003663b2f8e..1fed84a092c2 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -19,10 +19,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 84243c32e29c..f170d746336d 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -19,10 +19,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 10561ce16ed1..64ea0d10b788 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -15,10 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 01504c819e8f..cb3dedb1beae 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -17,10 +17,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e19189da0ee..17a6fa01a338 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -15,10 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d24fa1964eb8..55dccbdd8ed4 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  *  This driver fully implements the ACPI thermal policy as described in the
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 67c548ad3764..475c9079bf85 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061cac719b..5ba8fb64f664 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index ea6428b7dacb..29c691265b49 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -16,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed79b063f027..69af1c0e47c4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,10 +15,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-- 
2.1.4

