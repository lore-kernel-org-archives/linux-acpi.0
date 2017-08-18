From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI / sysfs: Extend ACPI sysfs to provide access to
 boot error region
Date: Fri, 18 Aug 2017 02:12:50 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F613425E2@ORSMSX114.amr.corp.intel.com>
References: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
        <20170817213946.16939-1-tony.luck@intel.com>
 <20170818013047.427e38b7@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753857AbdHRCMx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Aug 2017 22:12:53 -0400
In-Reply-To: <20170818013047.427e38b7@alans-desktop>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> Should this not also have a capability check. Assuming file permissions
> are sufficient for grabbing a chunk of system memory holding error
> info doesn't seem too scary but it's at odds with a lot of other cases ?

At least one of those other cases (pstore) added a capability check and now regret
it.  There's a thread on reverting it. Look for:

   Revert "pstore: Honor dmesg_restrict sysctl on dmesg dumps"

-Tony
