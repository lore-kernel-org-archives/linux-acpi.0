From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [RFC 4/5] PCIe native PME detection
Date: Tue, 9 Sep 2008 09:21:22 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F3091@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
 <20080908092305.546278414@sli10-desk.sh.intel.com>
 <200809082336.34091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23129 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756267AbYIIBV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 21:21:26 -0400
In-Reply-To: <200809082336.34091.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, Jesse Barnes <jbarnes@virtuousgeek.org>


>On Monday, 8 of September 2008, shaohua.li@intel.com wrote:
>> This implements PCIe native PME detection.
>
>Could you please describe how this is done?
>
>Generally, please add kerneldoc comments to all of the functions and make
>it
>clear what they are for.
Sorry, I'll do it later. Currently the main goal is to discuss the device core changes. We need generic implementation not just for x86.

>It looks like 'dev' will always be the root complex.  Is that correct?
Right, and the port driver is just for root complex.

>> +     struct work_struct work;
>> +     u16 bdf; /* device which invokes PME */
>> +     int exit;
>> +};
>> +
>
>This one is analogous to pci_pme_active(), isn't it?
>
>Why don't you want it to clear the status bit as well?
No, they are some pcie root complex's native pme bits, I'll document them later. Also, I'll address your other comments later.

Thanks,
Shaohua
