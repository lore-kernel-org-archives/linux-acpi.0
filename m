From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI
Date: Mon, 9 Sep 2002 17:12:37 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE31@orsmsx119.jf.intel.com>
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
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

A bunch of assorted ACPI fixes and cleanups, please apply.

You can pull from:
http://linux-acpi.bkbits.net/linux-acpi
<http://linux-acpi.bkbits.net/linux-acpi>  .


ChangeSet-Eo5DMOVaGn8@public.gmane.org, 2002-09-09 17:00:28-07:00, agrover@groveronline.com
  ACPI: Fix possible sleeping at interrupt context (Matthew Wilcox)

ChangeSet-ALLLLFoGt6I@public.gmane.org, 2002-09-09 14:35:46-07:00, agrover@groveronline.com
  ACPI: Do not compile functions not used in HT_ONLY mode

ChangeSet-buus5hzmOQM@public.gmane.org, 2002-09-04 17:59:10-07:00, agrover@groveronline.com
  ACPI: Do not do certain bits of APIC config if CONFIG_ACPI_HT_ONLY is set.

ChangeSet-8bMezWwbLIQ@public.gmane.org, 2002-09-04 17:18:49-07:00, agrover@groveronline.com
  ACPI: Remove interpreter debugger and kdb directories. These ultimately
  didn't prove useful enough to be used on a regular basis.

ChangeSet-JGszwtnY6O4@public.gmane.org, 2002-09-03 15:35:24-07:00, agrover@groveronline.com
  ifdef some arch-specific ACPI code

ChangeSet-Oj5efZNPAlA@public.gmane.org, 2002-09-03 15:12:32-07:00, agrover@groveronline.com
  Remove obsolete OSL functions (Kochi Takayoshi)

ChangeSet-/gjyQfi6Jvo@public.gmane.org, 2002-09-03 15:06:51-07:00, agrover@groveronline.com
  ACPI Config.in update by Christoph Hellwig
  - 3 space indents
  - one menu for all arches instead of duplicating
  - define_*s moved below the real questions

ChangeSet-Qg/eL0vA19Q@public.gmane.org, 2002-09-03 15:02:44-07:00, agrover@groveronline.com
  By John Belmonte - improvements to Toshiba ACPI driver:
  1) Fix sscanf
  2) Add TV out support
  3) Add hotkey status
  4) Add version info

ChangeSet-4cO+7sT5u5jBkAz3hwFLjg@public.gmane.org, 2002-08-30 15:56:22-07:00, agrover@groveronline.com
  ACPI trivial cleanups (Kochi Takayoshi)

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
