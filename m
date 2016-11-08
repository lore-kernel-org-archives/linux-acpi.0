From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ACPI module-level code (MLC) not working?
Date: Tue, 8 Nov 2016 17:35:07 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A263E92@SHSMSX101.ccr.corp.intel.com>
References: <20161108094951.GA20849@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbcKHRfL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Nov 2016 12:35:11 -0500
In-Reply-To: <20161108094951.GA20849@al>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Rick Kerkhof <rick.2889@gmail.com>, Bartosz Skrzypczak <barteks2x@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Peter Wu [mailto:peter@lekensteyn.nl]
> Subject: ACPI module-level code (MLC) not working?
> 
> Hi Lv,
> 
> According to some tests, setting acpi_gbl_parse_table_as_term_list to
> TRUE does is not effective. The code within the If-block is still not
> executed early enough or something else is wrong.
> 
> Previously Rick had an issue with an Acer Aspire V7-582PG where the dGPU
> could not be powered off and I demonstrated an isolated test case in
> http://www.spinics.net/lists/linux-acpi/msg70069.html
> 
> In Bartosz's case, the dGPU cannot be powered on (also using nouveau),
> preventing suspend from working. Situation is as follows (tested with
> Linux 3.16, 4.8.4, 4.9-rc2, 4.9-rc4):
> 
> His Lenovo IdeaPad Z510 laptop (BIOS date 2014) enables power resources
> and related _PR3 objects under the conditional If(_OSI("Windows 2013")).
> Both with and without acpi_gbl_parse_table_as_term_list set to TRUE, the
> module-level code is not loaded properly. Via a SSDT override, it was
> confirmed that removing the If conditional results in the expected
> behavior.
> 
> Various details are given in https://github.com/Bumblebee-Project/bbswitch/issues/142
> including lots of dmesg logs (see posts at the bottom).
> With above MLC flag set (v4.9-rc4): https://pastebin.com/raw/vCEPGezX
> With SSDT override (v4.9-rc2): https://pastebin.com/raw/3Fsf2VPU

I checked the post.
It seems the current working way is: disabling _OSI(Windows 2013) which disables power resources.

I have several questions related to this issue:
1. The following messages are prompt up when "acpi_gbl_parse_table_as_term_list = TRUE":
[    2.519113] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup failure, AE_NOT_FOUND (20160831/psargs-359)
[    2.519121] ACPI Error: Method parse/execution failed [\_SB.PCI0.PEG1.PEGP.DD02._BCL] (Node ffff8802568d3cf8), AE_NOT_FOUND (20160831/psparse-543)
How was this triggered?

2. I noticed the following statement:
   So, for some reason Lenovo has decided to give all tables the same name.
   The ACPI table override functionality matches possible candidates by signature, OEM ID and OEM Revision ID which are all the same.
   As a result, the wrong SSDT is overridden.
Could you provide the detail of the tables from the platform?
What is the reason of doing such kind of craps in BIOS?

Thanks and best regards
Lv

> 
> If you would like a new bugzilla entry or have some patches to test, you
> know where to find us :)
> --
> Kind regards,
> Peter Wu
> https://lekensteyn.nl
