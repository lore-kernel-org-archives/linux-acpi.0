From: "Brown, Len" <len.brown@intel.com>
Subject: FW: [Bug 194897] New: acpi_cpufreq prevents suspend (Could not power down device <NULL>)
Date: Tue, 13 Jun 2006 15:11:53 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6B89B43@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22352 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751168AbWFMTMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2006 15:12:16 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

volunteers?

-----Original Message-----
From: bugzilla@redhat.com [mailto:bugzilla@redhat.com] 
Sent: Monday, June 12, 2006 1:34 PM
To: davej@redhat.com
Subject: [Bug 194897] New: acpi_cpufreq prevents suspend (Could not
power down device <NULL>)

Please do not reply directly to this email. All additional
comments should be made in the comments box of this bug report.




https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194897

           Summary: acpi_cpufreq prevents suspend (Could not power down
                    device <NULL>)
           Product: Fedora Core
           Version: fc5
          Platform: All
        OS/Version: Linux
            Status: NEW
          Severity: normal
          Priority: normal
         Component: cpuspeed
        AssignedTo: davej@redhat.com
        ReportedBy: sitsofe@yahoo.com
   Estimated Hours: 0.0


Description of problem:
Attempts to suspend some desktops we have were being vetoed my a
mysterious
device <NULL>. Iterative investigation traced it to the acpi_cpufreq
module as
loaded by the cpuspeed initscript.

Version-Release number of selected component (if applicable):
cpuspeed-1.2.1-1.33

How reproducible:
Reproducible every time.

Steps to Reproduce:
1. Boot computer to runlevel 1.
2. Run pm-suspend.
  
Actual results:
Computer turns off monitor and disk then turns them straight back on
again.
Following message is in the logs:
Jun  5 18:10:23 x kernel: Shrinking memory... done (29166 pages freed)
Jun  5 18:10:23 x kernel: pnp: Device 00:08 disabled.
Jun  5 18:10:23 x kernel: pnp: Device 00:07 disabled.
Jun  5 18:10:23 x kernel: skge eth0: disabling interface
Jun  5 18:10:23 x kernel: Class driver suspend failed for cpu0
Jun  5 18:10:23 x kernel: Could not power down device <NULL>: error -22
Jun  5 18:10:23 x kernel: Some devices failed to power down, aborting
suspend

Expected results:
Computer to stay powered down until ACPI wake up event (e.g. mouse,
keyboard,
RTC etc).

Additional info:
Using:
modprobe -r acpi_cpufreq
allows the suspension to happen successfully. Atempting to disable the
cpuspeed
initscript using
/sbin/chkconfig cpuspeed off
left it on in runlevel 1.

The contents of /proc/acpi/processor/CPU0/throttling is:
state count:             2
active state:            T0
states:
   *T0:                  00%
    T1:                  50%

That is the only CPU in the machine. The BIOS is the last revision
available to
the best of my knowledge. Motherboard is a GA-7DX+ (with a VIA chipset)
according to dmidecode. Probably dates from around 2002.

-- 
Configure bugmail:
https://bugzilla.redhat.com/bugzilla/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
