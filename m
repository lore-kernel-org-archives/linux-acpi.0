From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Tue, 21 Nov 2006 03:10:59 +0000
Message-ID: <E1GmM2F-0007v4-00@skye.ra.phy.cam.ac.uk>
References: <Pine.LNX.4.64.0611201020320.3692@woody.osdl.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:33209 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S966906AbWKUDLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 22:11:09 -0500
In-Reply-To: Your message of "Mon, 20 Nov 2006 10:27:05 PST."
             <Pine.LNX.4.64.0611201020320.3692@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

Linus Torvalds wrote:

  (it thinks all fans are on), but no fans are actually on:

	  cat /proc/acpi/fan/*/*

	  status:                  off
	  status:                  off
	  status:                  off
	  status:                  off

I saw a related problem with suspend to disk; a second suspend to RAM
would hang while suspending -- bugzilla 5989, 6749 -- so I couldn't
test its effect on the fans.

After resuming, the fans would be off but the system thought they were
on, and the fan/*/* files would confirm that wrong idea.  Because the
fans were allegedly on, they would never get turned on, even as the
temperature climbed into the sky.  I reported this problem to the acpi
list and bugzilla, and the fan driver was fixed to have suspend/resume
methods, and that plus other patches eventually fixed it for my box
(IBM TP 600X).  Though with some of the intermediate patches, I saw
the behavior you are seeing (with 'off' status in fan/*/*, but showing
'on' in thermal_zone/*/* or in 'acpi -t').

Also there was some question there on whether exactly the right
version of the patch got merged.

See the discussions in
<http://bugzilla.kernel.org/show_bug.cgi?id=5000>.

Unfortunately I haven't kept testing it because my 600X's screen died,
and its replacement (T60) doesn't export any fan control or trip
points to ACPI (it's all done at a lower level, alas, so the damn fan
is on way too much).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
