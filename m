From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Wrong commit in the ACPI release branch
Date: Sat, 11 Dec 2010 23:29:34 +0100
Message-ID: <201012112329.35080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46447 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab0LKWat (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Dec 2010 17:30:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jan Beulich <jbeulich@novell.com>

Hi Len,

The following commit:

http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=091aad6af4ab29af693ced5d6970ceee9d5981c8

(ACPI: eliminate unused variable warning for !ACPI_SLEEP)
is actually wrong, because it's going to break compilation for
(!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).

I haven't seen it before, let alone acking it or something like this, so I wonder
why it's being pushed directly to Linus?

Thanks,
Rafael
