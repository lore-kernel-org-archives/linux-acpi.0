From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [GIT PATCH] thinkpad-acpi queue for 2.6.25-rc3
Date: Sat, 16 Feb 2008 02:17:49 -0200
Message-ID: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br>
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

This patchset has my current thinkpad-acpi queue with fixes that should go
into 2.6.25-rc.

There are some minor obviously correct fixes, some typo fixes, and an event
interface change that I'd rather get into 2.6.25, since the interface that
is being changed was introduced in my previous patch series, which made it
to -rc1.  That way, I can avoid changing an interface published in a stable
kernel...

The interface change is in patch "ACPI: thinkpad-acpi: issue input events
for tablet swivel events".  Patch "ACPI: thinkpad-acpi: add tablet-mode
reporting" is required for it to work well, otherwise we might lose the
first event we try to send through the input layer.  The change is an
"obviously desired" one: instead of issuing thinkpad-acpi specific events
over the ACPI netlink socket, issue a generic event over an input device.

Here's the shortlog:

Henrique de Moraes Holschuh (9):
      ACPI: thinkpad-acpi: trivial fix to module_desc typo
      ACPI: thinkpad-acpi: trivial fix to documentation
      ACPI: thinkpad-acpi: always track input device open/close
      ACPI: thinkpad-acpi: synchronize input device switches
      ACPI: thinkpad-acpi: make the video output feature optional
      ACPI: thinkpad-acpi: issue input events for tablet swivel events
      ACPI: thinkpad-acpi: improve thinkpad-acpi input device documentation
      ACPI: thinkpad-acpi: minor hotkey_radio_sw fixes
      ACPI: thinkpad-acpi: add tablet-mode reporting

Please merge it with the changes targetted at -rc3.

Thanks!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
