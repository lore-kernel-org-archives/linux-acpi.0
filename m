From: "Scott Thompson" <postfail@hushmail.com>
Subject: [RFC] CONFIG_PM_LEGACY = compiler warnings for deprecation ... solution?
Date: Wed, 01 Aug 2007 01:08:05 -0400
Message-ID: <20070801050806.4A8BEDA820@mailserver8.hushmail.com>
Reply-To: postfail@hushmail.com
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.hushmail.com ([65.39.178.135]:59609 "EHLO
	smtp3.hushmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbXHAFIF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 01:08:05 -0400
Received: from smtp3.hushmail.com (localhost.hush.com [127.0.0.1])
	by smtp3.hushmail.com (Postfix) with SMTP id B285D61C24
	for <linux-acpi@vger.kernel.org>; Wed,  1 Aug 2007 05:07:41 +0000 (UTC)
Received: from mailserver8.hushmail.com (mailserver8.hushmail.com [65.39.178.61])
	by smtp3.hushmail.com (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Wed,  1 Aug 2007 05:07:41 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

w/ CONFIG_PM_LEGACY .config option set, you get following batch of
compile errors because it marks the functions as 'deprecated'. w/o 
it set, it just uses stubs. compiler warnings for refernece (from 
2.6.23-1, though appears to have been around since at least 2.6.11 
from another mail list post).

However, since these functions are required if you have
CONFIG_PM_LEGACY option marked...

I propose that within the include/linux/pm_legacy.h file, functions
in the CONFIG_PM_LEGACY aren't marked 'deprecated' and functions
outside the #if are marked deprecated.  Then the handful of calls
(12 or so) that actually call the pm_legacy apis can get wrapped in
the CONFIG_PM_LEGACY flag.

This is basically already being done in one case since as of
2.6.20.1 the pm_register function is only used in
drivers/serial/68328serial.c.

The pm_send_all is not wrapped around all uses yet, but that is
pretty easy to patch.  Then the compile will actually complain
should someone try to call it and not wrap w/ the CONFIG_PM_LEGACY
ifdef.

Happy to hear thoughts or other solutions.

------------------------------
Regards,
Scott Thompson / postfail@hushmail.com
------------------------------

--
Free information on vast array of home improvement projects.  Click here.
http://tagline.hushmail.com/fc/Ioyw6h4eNIBTzslyd6sFcem0DGn1xrajHGmTczUmHzuMeqA2wEMUHS/

