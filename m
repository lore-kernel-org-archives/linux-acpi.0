From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [GIT PULL] thinkpad-acpi fixes and sysfs support
	part 2
Date: Fri, 27 Apr 2007 21:57:40 -0300
Message-ID: <1177721861912-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
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

to receive the following patches *already* in acpi-test:
      ACPI: ibm-acpi: kill trailing whitespace
      ACPI: ibm-acpi: rename some identifiers
      ACPI: ibm-acpi: add header file
      ACPI: ibm-acpi: organize code
      ACPI: ibm-acpi: update copyright notice
      ACPI: ibm-acpi: update documentation
      ACPI: ibm-acpi: move driver to drivers/misc hierarchy
      ACPI: ibm-acpi: rename driver to thinkpad-acpi
      ACPI: thinkpad-acpi: cleanup Kconfig for thinkpad-acpi
      ACPI: thinkpad-acpi: add compatibility MODULE_ALIAS entry
      ACPI: thinkpad-acpi: cleanup after rename
      ACPI: thinkpad-acpi: update MAINTAINERS
      ACPI: thinkpad-acpi: rename register_ibmacpi_subdriver
      ACPI: thinkpad-acpi: rename one stray use of ibm-acpi in a comment
      ACPI: thinkpad-acpi: rename module glue
      ACPI: thinkpad-acpi: rename thinkpad constants
      ACPI: thinkpad-acpi: update fan firmware documentation
      ACPI: thinkpad-acpi: add debug mode
      ACPI: thinkpad-acpi: clean up probing and move init to subdrivers
      ACPI: thinkpad-acpi: add subdriver debug statements
      ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
      ACPI: thinkpad-acpi: improve thinkpad detection
      ACPI: thinkpad-acpi: use bitfields to hold subdriver flags
      ACPI: thinkpad-acpi: use bitfields for module flags
      ACPI: thinkpad-acpi: prepare for device model conversion
      ACPI: thinkpad-acpi: mark acpi helper functions __must_check
      ACPI: thinkpad-acpi: clean up hotkey subdriver
      ACPI: thinkpad-acpi: cleanup bluetooth and wan for sysfs conversion
      ACPI: thinkpad-acpi: cleanup video subdriver
      ACPI: thinkpad-acpi: clean up CMOS commands subdriver
      ACPI: thinkpad-acpi: cleanup thermal subdriver for sysfs conversion
      ACPI: thinkpad-acpi: improve fan watchdog messages
      ACPI: thinkpad-acpi: register with the device model
      ACPI: thinkpad-acpi: driver sysfs conversion
      ACPI: thinkpad-acpi: add infrastructure for the sysfs device attributes
      ACPI: thinkpad-acpi: protect fan and hotkey data structures
      ACPI: thinkpad-acpi: add sysfs support to the thermal subdriver
      ACPI: thinkpad-acpi: add sysfs support to fan subdriver
      ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
      ACPI: thinkpad-acpi: add sysfs support to the cmos command subdriver
      ACPI: thinkpad-acpi: update brightness sysfs interface support

      (the above should not cause any probles if you already pulled
      from that branch, as I have not rebased the branch or modified
      any of the above patches)

and to receive the following *new* patches:

      ACPI: thinkpad-acpi: add a fan-control feature master toggle
      ACPI: thinkpad-acpi: do not arm fan watchdog if it would not work
      ACPI: thinkpad-acpi: fix a fan watchdog invocation
      ACPI: thinkpad-acpi: map ENXIO to EINVAL for fan sysfs
      ACPI: thinkpad-acpi: improve fan control documentation
      ACPI: thinkpad-acpi: improve debugging for acpi helpers
      ACPI: thinkpad-acpi: improve dock subdriver initialization
      ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
      ACPI: thinkpad-acpi: add sysfs support to wan and bluetooth subdrivers

This is some cleaning-up of the fan sysfs support and the "no fan
control by default" master switch (patches 1-5), some extra debugging
and a minor fix to a deprecated subdriver (patches 6, 7), and two more
sysfs conversions (patches 8, 9).

Please merge for 2.6.22.

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
