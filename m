From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI / sysfs: Extend ACPI sysfs to provide access to
 boot error region
Date: Wed, 23 Aug 2017 14:56:46 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F61349912@ORSMSX114.amr.corp.intel.com>
References: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
        <20170817213946.16939-1-tony.luck@intel.com>
 <20170818013047.427e38b7@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:39715 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754113AbdHWO4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Aug 2017 10:56:49 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Kees Cook <keescook@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>> Should this not also have a capability check. Assuming file permissions
>> are sufficient for grabbing a chunk of system memory holding error
>> info doesn't seem too scary but it's at odds with a lot of other cases ?
>
> At least one of those other cases (pstore) added a capability check and now regret
> it.  There's a thread on reverting it. Look for:
>
>   Revert "pstore: Honor dmesg_restrict sysctl on dmesg dumps"

Here's at least part of that thread:

https://marc.info/?l=linux-kernel&m=150301241114262&w=2

Kees: you were OK with removing the capability check from pstore, right?

I'm now adding another place to access a blob of memory containing
crash information from the previous kernel (pointed at by the ACPI
BERT record).

-Tony

