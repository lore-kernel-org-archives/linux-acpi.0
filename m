From: Chase Douglas <chase.douglas@ubuntu.com>
Subject: Quirking acpi_enforce_resources
Date: Mon, 01 Mar 2010 16:01:37 -0500
Message-ID: <1267477297.15581.152.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43443 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0CAVBl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 16:01:41 -0500
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NmCkG-0006ft-HP
	for <linux-acpi@vger.kernel.org>; Mon, 01 Mar 2010 21:01:40 +0000
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=[10.0.1.13])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <chase.douglas@ubuntu.com>)
	id 1NmCkG-0003ME-8r
	for linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 21:01:40 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I've noticed there are a lot of bugs filed against Ubuntu due to the
changes that introduced strict resource checking between the acpi driver
and legacy hardware monitor drivers [1]. Although I understand the
reason for the strict checking, the legacy drivers seemed to work fine.
I'm unaware of any real issues that were caused by using them. Thus, I'm
wondering if it would be worthwhile to whitelist machines that are known
to work OK even with the resources being doubly held by both the acpi
driver and a legacy driver. It certainly does not seem prudent to set
acpi_enforce_resources=lax across the board, but the change to strict
resource checking seems to have done more harm than good for the average
user.

I noticed a similar thread at [2]. At the end it was proposed that a
whitelist be set up to handle this issue. Has anyone been working on
this?

Beyond the potential breakage of function, I'm also concerned by the
logging level of the message that informs the user of the resource
contention. Right now, KERN_ERR is used by default when a contention is
found. Basically, the message means "You tried to use a legacy driver,
but that's not a good idea, so I've prevented you from doing so." It
seems ok on the one hand to call this an error condition. On the other
hand, it pollutes Ubuntu's startup screen because it thinks there's a
real error occurring in the kernel. From this point of reference, it
seems better to emit the message at the KERN_WARN level at all times,
since it's not really something that a user should be frightened of when
they see their computer spit out such a message at boot.

Any thoughts on these two ideas? I can work on some patches if either is
deemed worthwhile.

Thanks,
Chase Douglas

[1]
https://launchpad.net/+search?field.text=acpi_enforce_resources&field.actions.search=Search
[2] http://marc.info/?l=linux-acpi&m=125233061012344&w=2

