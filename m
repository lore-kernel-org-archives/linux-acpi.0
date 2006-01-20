From: "Brown, Len" <len.brown@intel.com>
Subject: RE: High pitched sound with 2.6.15-ck1 --  Need your help
Date: Thu, 19 Jan 2006 23:29:52 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEBD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:52370 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161266AbWATE3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2006 23:29:54 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasileios Gkanis <gkanis@cems.umn.edu>, linux-acpi@vger.kernel.org


>I have a laptop which makes this high pitched sound when HZ is 1000.

The voltage regulators are switching at a frequency and a
magnitude sufficient to cause the capacitors to "ring".
This is more common on systems with inexpensive capacitors.

Whatever the HZ, static or dynamic, look at the rate between
a couple of timed snapshots of /proc/interrupts to see what
you're getting in practice.

The fact that "idle=poll" makes the symptom go away probably
means that the following is what you need...

As you're entering C4, try:

# echo $NUM /sys/module/processor/parameters/max_cstate

Where $NUM is the highest number that makes the sound go away.
You're running in C4 now, so try 3, then 2, then 1.
3 may do it, 2 almost certainly will.

Of course the other way to approach this problem is to
keep your C4 for idle power savings, but play around with HZ.
Eg hard-code to 100 or 250 will probably do it.

cheers,
-Len
