From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Fri, 16 Aug 2002 11:59:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDA9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from:
http://linux-acpi.bkbits.net/linux-acpi
<http://linux-acpi.bkbits.net/linux-acpi> 

ChangeSet-vlIbsYQfmuI@public.gmane.org, 2002-08-15 15:35:28-07:00, agrover@groveronline.com
  ACPI interpreter updates:
  - Improved ACPI mode switching (Kochi Takayoshi)
  - Improved namespace handling of parent operator "^^"
  - Changed the names of some proprocessor macros
  - Other improvements

ChangeSet-EKGBVuWAcag@public.gmane.org, 2002-08-14 18:41:19-07:00, agrover@groveronline.com
  A trio of minor fixes:
  Export acpi_get_firmware_table (Matthew Wilcox)
  Use proper root proc entry (Kochi Takayoshi)
  Fix early-boot table parsing (Bjorn Helgaas)

ChangeSet-fHJrsasPWiI@public.gmane.org, 2002-08-14 17:55:20-07:00, agrover@groveronline.com
  Change acpi_system_suspend to use new irq functions (Pavel Machek)

ChangeSet-1Ly6XNJFrW0@public.gmane.org, 2002-08-14 17:08:31-07:00, agrover@groveronline.com
  Make CONFIG_ACPI_BOOT work again (Pavel Machek)

ChangeSet-rM9gxoVVLVg@public.gmane.org, 2002-08-14 16:47:27-07:00, agrover@groveronline.com
  By Herbert Nachtnebel:
  1) Allow differently-ordered trip points
  2) Change acpi_thermal_check to always call acpi_thermal_active (to allow
that function to
     turn off active cooling if it wants
  3) Properly activate active cooling devices

ChangeSet-32Csfj4igmhgJAXftmDEsQ@public.gmane.org, 2002-08-13 14:09:47-07:00, agrover@acpi3.jf.intel.com
  remove redundant slab.h include (Brad Hards)

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
