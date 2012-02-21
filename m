From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [v2 PATCH 1/2] ACPI, APEI, EINJ, new parameter to control
 trigger action
Date: Tue, 21 Feb 2012 17:56:05 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F03D5C0@ORSMSX104.amr.corp.intel.com>
References: <1329462665-4040-1-git-send-email-gong.chen@linux.intel.com>
 <4F41217A.7040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:32197 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465Ab2BUR4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2012 12:56:07 -0500
In-Reply-To: <4F41217A.7040909@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>, Chen Gong <gong.chen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Suggest to reset the notrigger flag to default value (zero) after the injection
> operation, so the test script doesn't need to explicitly set the notrigger flag
> for each injection operation and it's backward compatible with existing scripts.
> It would be better to reset the param2 too for the same reason.

That might cause more confusion. We haven't documented the behavior of the
other files here after an error is injected ... but their actual behavior has
always been that values written are sticky. I.e. you can write a script to
inject three errors to the same page like this:

echo 0x8 > error_type
echo 0x12340000 > param1
echo 0xfffffffffffff000 > param2

echo 1 > error_inject
sleep 1
echo 1 > error_inject
sleep 1
echo 1 > error_inject

so I think that it might be surprising if "notrigger" was not sticky
like everything else.

-Tony
