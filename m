From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Mon, 01 Oct 2012 20:38:42 +0200
Message-ID: <5069E332.9060109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab2JAShW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2012 14:37:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: martin@hundeboll.net, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

Matthew Garrett wrote:
 > We're getting timeouts when trying to access the embedded controller,
 > which would explain your problems.

I've been seeing the same problem on my Dell E6430. but only
with 3.6 not with 3.5. I've done quite a bit of debugging on
this enabling all the debug prints in drivers/acpi/ec.c + adding
some of my own, and I've failed to catch Linux on doing anything
"wrong" (unsurprisingly).

I've learned 2 interesting things though:
1) The timeout of the EC transactions is timing dependent, if
we feed the EC commands + data with the right timing all is ok,
this is why 3.5 worked and 3.6 did not work for me, the Fedora 3.6
kernels for F-18 are build with various kernel debugging options
enabled, changing the timing. If I take a 3.6 build from Fedora
without the debugging options 3.6 works just as well as 3.5 for me.

2) Even with a 3.6 which shows the problematic behavior, I can
make things work by adding acpi.ec_delay=2000 to the kernel cmdline,
the debug traces show that the EC takes it sweet time to respond
(sometime close to 2 seconds) but it does eventually respond in all
cases I've seen sofar.

This also seems to fix a sporadic occurence of:
"ACPI: EC: input buffer is not empty aborting transaction"
Which I'm seeing with 3.5 / 3.6 in a non debug build.

Martin, can you see if adding that helps you with the E5430 problems
too ?

###

I'll go and report this to Dell's Linux team, as I believe this is
an EC firmware bug. In the mean time, since even if Dell fixes this,
people are bad in applying BIOS updates, maybe we should add a DMI
quirk for machines which need a longer ec_delay, and add these 2?

Regards,

Hans


