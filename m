From: Hans de Goede <hdegoede@redhat.com>
Subject: ACPI regression in 3.6, no more battery status, with Dell Latitude
 E6430
Date: Wed, 26 Sep 2012 11:54:01 +0200
Message-ID: <5062D0B9.1030000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab2IZJwk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2012 05:52:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi,

First of all, sorry for not reporting this earlier in the cycle, but
I only got this (new) laptop yesterday ...

With both the 3.5 kernels as well as with the 3.6 kernels, there is
quite some unhappiness being reported in dmesg about the ACPI
tables, esp. surrounding BAT0. But with 3.5 I do get battery
status reported, where as with 3.6 I do not.

Here is the dmesg output of booting with 3.5.4, resp. 3.6.0-rc7:
http://people.fedoraproject.org/~jwrdegoede/dmesg-3.5
http://people.fedoraproject.org/~jwrdegoede/dmesg-3.6

Both boots were done with a standard Fedora kernel build.

Please let me know what else I can do to help. I'm a kernel developer
myself, so you can just throw a patch in my direction and I can build
a test kernels without needing any hand-holding, etc.

Regards,

Hans
