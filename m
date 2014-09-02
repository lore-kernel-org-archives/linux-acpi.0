From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Question of " 202317a : ACPI / scan: Add acpi_device objects for
 all device nodes in the namespace" commit
Date: Tue, 2 Sep 2014 10:53:09 +0900
Message-ID: <54052305.9060308@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38]:49802 "EHLO
	fgwmail8.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaIBCC3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Sep 2014 22:02:29 -0400
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id DB8B21796788
	for <linux-acpi@vger.kernel.org>; Tue,  2 Sep 2014 10:54:07 +0900 (JST)
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [10.0.237.143])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 73C1F3EE0B6
	for <linux-acpi@vger.kernel.org>; Tue,  2 Sep 2014 10:53:57 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 86917AC0199
	for <linux-acpi@vger.kernel.org>; Tue,  2 Sep 2014 10:53:56 +0900 (JST)
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 322501DB8044
	for <linux-acpi@vger.kernel.org>; Tue,  2 Sep 2014 10:53:56 +0900 (JST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

Hi Rafael,

Why is _SUN method decoded and the sun sysfs created even if _STA reports
that the device is not present and not functional?

By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
device nodes in the namespace", all device nodes in the namespace are
shown under /sys/bus/acpi/devices direcotry even if the devices are not
present and not functional.

But ACPI specification says against return value information of _STA:
A device can only decode its hardware resources if both bits 0 and 1 are set.
If the device is not present (bit 0 cleared) or not enabled (bit 1 cleared),
then the device must not decode its resources.

In my understanding, when the device is not present and not functional,
_SUN of the device must not be decoded. Is my understanding worng?

In our box, when the device is not present and not functional, _SUN method
of the device returns wrong value. And the values is cached to
acpi_device->pnp.sun. So when hot adding the device and changing _SUN value,
the information is not reflected to acpi_device->pnp.sun.

I think the issue is solved by not caching sun value. But at first, I want
to know whether current implementation is correct or not.

Thanks,
Yasuaki Ishimatsu

