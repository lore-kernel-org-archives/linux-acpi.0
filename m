From: Bastien Nocera <hadess@hadess.net>
Subject: Ghost Lid switch on Baytrail tablet
Date: Sun, 19 Jul 2015 02:42:48 +0200
Message-ID: <1437266568.3512.10.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:40118 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbGSBIn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jul 2015 21:08:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "dev@mgautier.fr" <dev@mgautier.fr>

Hey,

This tablet:
http://www.amazon.com/WinBook-10-1-Inch-Windows-full-size-Display/dp/B00N9ZG5U2/
doesn't have a physical lid switch unless you plug the keyboard accessory to it.

But it thinks that there is a lid, and that it's closed, making logind
suspend the machine after about 30 seconds.

I'm currently testing this on a 4.0 kernel, as there have been
regressions on Baytrail with 4.1 and 4.2rcs.

The DSDT for that tablet:
https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl

Any ideas how to handle this sort of device?

Cheers
