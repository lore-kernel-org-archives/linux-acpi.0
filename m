From: Andy Neitzke <neitzke@ias.edu>
Subject: /proc/acpi/battery/BAT0/info stale when battery changed on Thinkpad X60t
Date: Wed, 14 May 2008 11:05:02 -0400
Message-ID: <200805141105.02277.neitzke@ias.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.ias.edu ([192.16.204.102]:35812 "EHLO smtp2.ias.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbYENQMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 12:12:19 -0400
Received: from pps1 (pps1.ias.edu [172.16.12.131])
	by smtp2.ias.edu (8.13.4/8.13.4) with ESMTP id m4EF5Lpl011673
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2008 11:05:21 -0400 (EDT)
Received: from iris.sns.ias.edu (iris.sns.ias.edu [172.16.17.15])
	by pps1.ias.edu (8.14.1/8.14.1) with ESMTP id m4EF5Kq2005946
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2008 11:05:20 -0400
Received: from dhcp-192-033-102-161.ethz.ch (dhcp-192-033-102-161.ethz.ch [192.33.102.161])
	(authenticated bits=0)
	by iris.sns.ias.edu (8.13.1/8.13.1) with ESMTP id m4EF53tx013869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2008 11:05:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have two batteries for my Thinkpad X60 Tablet, one 6-cell and one 9-cell, 
with very different capacities.  If I boot up or resume from suspend with say 
battery A connected, then /proc/acpi/battery/BAT0/info correctly shows 
information about battery A.  If I then connect the system to AC power and 
remove battery A, /proc/acpi/battery/BAT0/info correctly shows that no 
battery is present.  If I then attach battery B, 
then /proc/acpi/battery/BAT0/info incorrectly shows the information about 
battery A again!  (And similarly e.g. kpowersave shows the wrong capacity.)  
On the other hand /proc/acpi/battery/BAT0/state always shows the correct 
information.  A suspend-resume cycle clears up the problem.

For example:

andy@chirality ~ $ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      61650 mWh
present voltage:         16587 mV

andy@chirality ~ $ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         28800 mWh
last full capacity:      23550 mWh
battery technology:      rechargeable
design voltage:          14400 mV
design capacity warning: 1177 mWh
design capacity low:     200 mWh
capacity granularity 1:  1 mWh
capacity granularity 2:  1 mWh
model number:            93P5031
serial number:             482
battery type:            LION
OEM info:                SANYO

and then after suspend-resume, the correct information:

andy@chirality ~ $ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         66240 mWh
last full capacity:      61650 mWh
battery technology:      rechargeable
design voltage:          14400 mV
design capacity warning: 3082 mWh
design capacity low:     200 mWh
capacity granularity 1:  1 mWh
capacity granularity 2:  1 mWh
model number:            42T4507
serial number:             833
battery type:            LION
OEM info:                SANYO

At the moment I am seeing this problem with kernel 2.6.25.3, but I believe I 
have had it for a while (I was reminded of it only just now because I started 
using kpowersave again).

Any ideas?  I'm happy to try to debug, but don't know where to start.

Thanks, and best wishes,

-Andy
