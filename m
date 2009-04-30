From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 0/6] ACPI: support system events for .notify
Date: Thu, 30 Apr 2009 09:35:32 -0600
Message-ID: <20090430153419.12628.91088.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Karol Kozimor <sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Starikovskiy <alexey.y.starikovskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This series extends the .notify method I recently added so drivers
can request system notification events as well as device-specific
events.  This simplifies some drivers a bit.

Comments welcome.

---

Bjorn Helgaas (6):
      ACPI: eeepc-laptop: use .notify method instead of installing handler directly
      ACPI: asus-acpi: use .notify method instead of installing handler directly
      ACPI: asus-laptop: use .notify method instead of installing handler directly
      ACPI: battery: use .notify method instead of installing handler directly
      ACPI: ac: use .notify method instead of installing handler directly
      ACPI: allow drivers to request both device and system notify events


 drivers/acpi/ac.c                   |   20 +++++---------------
 drivers/acpi/battery.c              |   22 +++++-----------------
 drivers/acpi/bus.c                  |    6 +++++-
 drivers/platform/x86/asus-laptop.c  |   23 +++++------------------
 drivers/platform/x86/asus_acpi.c    |   30 +++++++++++++-----------------
 drivers/platform/x86/eeepc-laptop.c |   19 ++++++-------------
 include/acpi/acpi_bus.h             |    3 +++
 7 files changed, 42 insertions(+), 81 deletions(-)

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
