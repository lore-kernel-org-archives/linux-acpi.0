From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI / APEI: Boot Error Record Table processing was
 needlessly complicated
Date: Fri, 5 May 2017 18:12:57 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F612887B8@ORSMSX114.amr.corp.intel.com>
References: <20170505181037.31668-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2863 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdEESNB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 May 2017 14:13:01 -0400
In-Reply-To: <20170505181037.31668-1-tony.luck@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

N.B. this really needs some testing by someone who has a system that
generates populated BERT records.  All I know at the moment is that it
works with en empty BERT log

-Tony
