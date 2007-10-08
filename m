From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [GIT PATCH] thinkpad-acpi changes for the merge
	window (part 2)
Date: Mon,  8 Oct 2007 10:03:59 -0300
Message-ID: <1191848642-22530-1-git-send-email-hmh@hmh.eng.br>
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

Here is the second batch of thinkpad-acpi changes for the merge window (target:
2.6.24).  There will be a third batch, soon.

This batch improves brightness support on Lenovo ThinkPads, and also disables
said support by default in any notebook that seems to do well without it :-)

Please merge this batch to acpi-test.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog of the above branch:

Henrique de Moraes Holschuh (12):
  (already submitted)
      ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
      ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
      ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
      ACPI: thinkpad-acpi: keep track of module state
      ACPI: thinkpad-acpi: check version of hot key firmware
      ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2.2)
      ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
      ACPI: thinkpad-acpi: use a separate platform device for hwmon and name it (v2)
      ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
  (new)
      ACPI: thinkpad-acpi: skip blanks before the data when parsing sysfs
      ACPI: thinkpad-acpi: support 16 levels of brightness (v2)
      ACPI: thinkpad-acpi: bump up version to 0.17

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
