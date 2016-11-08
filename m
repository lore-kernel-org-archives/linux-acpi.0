From: Peter Wu <peter@lekensteyn.nl>
Subject: ACPI module-level code (MLC) not working?
Date: Tue, 8 Nov 2016 10:49:51 +0100
Message-ID: <20161108094951.GA20849@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:43823 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752510AbcKHJuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Nov 2016 04:50:15 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Rick Kerkhof <rick.2889@gmail.com>, Bartosz Skrzypczak <barteks2x@gmail.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

Hi Lv,

According to some tests, setting acpi_gbl_parse_table_as_term_list to
TRUE does is not effective. The code within the If-block is still not
executed early enough or something else is wrong.

Previously Rick had an issue with an Acer Aspire V7-582PG where the dGPU
could not be powered off and I demonstrated an isolated test case in
http://www.spinics.net/lists/linux-acpi/msg70069.html

In Bartosz's case, the dGPU cannot be powered on (also using nouveau),
preventing suspend from working. Situation is as follows (tested with
Linux 3.16, 4.8.4, 4.9-rc2, 4.9-rc4):

His Lenovo IdeaPad Z510 laptop (BIOS date 2014) enables power resources
and related _PR3 objects under the conditional If(_OSI("Windows 2013")).
Both with and without acpi_gbl_parse_table_as_term_list set to TRUE, the
module-level code is not loaded properly. Via a SSDT override, it was
confirmed that removing the If conditional results in the expected
behavior.

Various details are given in https://github.com/Bumblebee-Project/bbswitch/issues/142
including lots of dmesg logs (see posts at the bottom).
With above MLC flag set (v4.9-rc4): https://pastebin.com/raw/vCEPGezX
With SSDT override (v4.9-rc2): https://pastebin.com/raw/3Fsf2VPU

If you would like a new bugzilla entry or have some patches to test, you
know where to find us :)
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
