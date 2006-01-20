From: "Brown, Len" <len.brown@intel.com>
Subject: RE: wake-on-lan
Date: Thu, 19 Jan 2006 23:55:13 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:41371 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422745AbWATFBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 00:01:49 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joseph Dunn <jdunn14@hotpop.com>, linux-acpi@vger.kernel.org

>When I halt the machine (shutdown -h) I cannot
>wake it.  However, if the machine is unplugged, then plugged back in,
>*then* I can wake it. 

WOL can be done a couple of ways.

If it is implemented using ACPI GPE's, then
you need to find a string (unfortunately, they're arbitrary)
in /proc/acpi/wakeup that looks like your device and echo that
string into the file to toggle between enabled and disabled.

Only Power/Sleep/LID buttons are enabled for wakeup by default.

Note that this I/F is temporary -- the ability of
a device to wake the system should really be a property
of that device in the /sys tree.

cheers,
-Len
