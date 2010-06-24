From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Ubuntu patch enabling speedstep for sonoma processors
Date: Thu, 24 Jun 2010 18:50:06 +0300
Message-ID: <4C237EAE.3000908@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:50107 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0FXPuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jun 2010 11:50:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Hi,

The following patch enables speedstep for sonoma processors:
http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-maverick.git;a=blobdiff;f=arch/x86/kernel/cpu/cpufreq/speedstep-centrino.c;h=ee4e9f8050752923f9671f61ffbea662bc9ad12a;hp=9b1ff37de46ae6a729f48d2d94ad30548806884d;hb=23120eb5ae5a12924565e8af3d946a015e1caaf9;hpb=215cc71ef0b26b9434404f387681d9bd173d2434

The patch never got accepted by upstream after some discussions:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-06/msg01078.html

"""
This patch has been floating around for years.
So long, I've forgotten the original reason it wasn't accepted.
It had something to do with it working for some users, but not others,
and we can't detect the 'not working' case.

speedstep-centrino is also deprecated in favour of acpi-cpufreq for some time.
If acpi isn't working on these machines, we should find out why.

Dave Jones
"""

"""
My recollection is that we had no way to work out which voltage table
was appropriate for a given CPU, so there was a risk of us either over-
or under-volting the chip. Doing it via ACPI is safe.

Matthew Garrett
"""

I have bug report from a user which complains that frequency scaling is not available
on its computer. This patch fixes the issue but seen the discussions there should be a
better and more correct way to fix the issue.

What should I do in order to debug and try to fix it?

And also seen that Ubuntu carries this patch for a relatively long time, did you see
any negative effect like the aforementioned risk of over/under-volting the chip?

Thanks
Ozan Caglayan


