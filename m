From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Thu, 29 Aug 2002 16:02:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDF2@orsmsx119.jf.intel.com>
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

Hey, these more frequent, smaller pushes are kinda nice.

Please pull from http://linux-acpi.bkbits.net/linux-acpi
<http://linux-acpi.bkbits.net/linux-acpi>  .

Regards -- Andy

ChangeSet-xVCD6yrqPxE@public.gmane.org, 2002-08-29 13:12:56-07:00, agrover@groveronline.com
  ACPI interpreter update

ChangeSet-r978YHqf9BuKN0S5hHIosQ@public.gmane.org, 2002-08-21 14:21:04-07:00, agrover@groveronline.com
  ACPI Remove unused file

ChangeSet-r978YHqf9BtJcjYr3e4UJg@public.gmane.org, 2002-08-20 15:18:01-07:00, agrover@groveronline.com
  Ensure that the ACPI interrupt has the proper trigger and polarity

ChangeSet-WeBolnSZrjmAmxt+E6XRvg@public.gmane.org, 2002-08-20 14:15:57-07:00, agrover@groveronline.com
  local_irq_disable is extraneous (Matthew Wilcox)

ChangeSet-WeBolnSZrjnBkAz3hwFLjg@public.gmane.org, 2002-08-20 13:29:41-07:00, agrover@groveronline.com
  There are a few problems with ACPI init. One of these is that acpi=off
  will disable the ACPI interpreter init, but not stop the OS from using
  ACPI tables for finding CPUs and IOAPICs. Another problem is that if we
  use the tables, but then the interpreter fails to init, we are in deep
  trouble, because it is too late to revert to using MPS, but we cannot get
  _PRT info without the interpreter.
  
  This changeset doesn't fix the latter problem, but it does at least make
  "acpi=off" actually do what it says, and not use the ACPI interpreter *or*
  the tables.

ChangeSet-WeBolnSZrjkqMp+WYRx65w@public.gmane.org, 2002-08-19 11:35:40-07:00, agrover@groveronline.com
  Add arch-neutral support for parsing SLIT and SRAT tables (Kochi
Takayoshi)

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
