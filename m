From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Wed, 15 Oct 2008 15:31:17 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858032780B6@orsmsx503.amr.corp.intel.com>
References: <1223885404.2735.183.camel@rzhang-dt>
 <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
 <1223947180.2735.228.camel@rzhang-dt>
 <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6435 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbYJOWbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 18:31:24 -0400
In-Reply-To: <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

>> hmm, when will this change be shipped to Linux?
>> BTW: Rafael has already proposed a patch which always clears 64 bit wake
>> vector and uses the 32 bit one.
>> http://marc.info/?l=linux-acpi&m=122370808622832&w=2
>
>BTW, Rafael's patch above is staged for 2.6.28.

Note that we have just changed the firmware vector interface in ACPICA by splitting it into a 32-bit version and a 64-bit version. This is the only correct way to do it, because of the real vs. protected mode issues that must be handled by the host OS.


