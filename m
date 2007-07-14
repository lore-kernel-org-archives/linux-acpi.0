From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [GIT PULL] thinkpad-acpi queue for 2.6.23 (v2)
Date: Sat, 14 Jul 2007 11:11:49 -0300
Message-ID: <11844223322928-git-send-email-hmh@hmh.eng.br>
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
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Len,

Please pull from:                                                                                                                                     
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test                                                                     

to receive the first batch of thinkpad-acpi changes for 2.6.23, now rebased to
apply on top of v2.6.22:

      ACPI: thinkpad-acpi: add DMI-based modalias
      ACPI: thinkpad-acpi: remove all uneeded initializers
      ACPI: thinkpad-acpi: update information on T43 thermal sensor 0xc1
      ACPI: thinkpad-acpi: enable more hotkeys
      ACPI: thinkpad-acpi: export hotkey maximum masks
      ACPI: thinkpad-acpi: export to sysfs the state of the radio slider switch
      ACPI: thinkpad-acpi: checkpoint sysfs interface version due to hotkey
      ACPI: thinkpad-acpi: update CMOS commands documentation
      ACPI: thinkpad-acpi: register input device
      ACPI: thinkpad-acpi: add input device support to hotkey subdriver
      ACPI: thinkpad-acpi: make the input event mode the default
      ACPI: thinkpad-acpi: add power-management handler capability
      ACPI: thinkpad-acpi: export EV_SW SW_RADIO events
      ACPI: thinkpad-acpi: checkpoint sysfs interface version due to input layer
      ACPI: thinkpad-acpi: rename pci HID constant

And to also receive the second batch of thinkpad-acpi changes for 2.6.23:

      ACPI: thinkpad_acpi: use bool for boolean parameters
      pci-ids: add Lenovo PCI vendor ID
      ACPI: thinkpad-acpi: store ThinkPad model information
      ACPI: thinkpad-acpi: allow use of CMOS NVRAM for brightness control
      ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
      ACPI: thinkpad-acpi: make sure DSDT TMPx readings don't return +128
      ACPI: thinkpad-acpi: make EC-based thermal readings non-experimental
      ACPI: thinkpad-acpi: bump up version to 0.15


These changes are composed mainly of the first part of the effort to move all
the hot keys functionality to the input layer, plus some fixes.

All these patches are targetted to 2.6.23.  Please merge for acpi-test.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
