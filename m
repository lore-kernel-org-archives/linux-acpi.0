From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: ACPI module-level code (MLC) not working?
Date: Tue, 8 Nov 2016 18:56:50 +0100
Message-ID: <20161108175650.GB21992@al>
References: <20161108094951.GA20849@al>
 <1AE640813FDE7649BE1B193DEA596E886A263E92@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:34245 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbcKHR5R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Nov 2016 12:57:17 -0500
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A263E92@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Rick Kerkhof <rick.2889@gmail.com>, Bartosz Skrzypczak <barteks2x@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 08, 2016 at 05:35:07PM +0000, Zheng, Lv wrote:
> Hi,
> 
> > From: Peter Wu [mailto:peter@lekensteyn.nl]
> > Subject: ACPI module-level code (MLC) not working?
> > 
> > Hi Lv,
> > 
> > According to some tests, setting acpi_gbl_parse_table_as_term_list to
> > TRUE does is not effective. The code within the If-block is still not
> > executed early enough or something else is wrong.
> > 
> > Previously Rick had an issue with an Acer Aspire V7-582PG where the dGPU
> > could not be powered off and I demonstrated an isolated test case in
> > http://www.spinics.net/lists/linux-acpi/msg70069.html
> > 
> > In Bartosz's case, the dGPU cannot be powered on (also using nouveau),
> > preventing suspend from working. Situation is as follows (tested with
> > Linux 3.16, 4.8.4, 4.9-rc2, 4.9-rc4):
> > 
> > His Lenovo IdeaPad Z510 laptop (BIOS date 2014) enables power resources
> > and related _PR3 objects under the conditional If(_OSI("Windows 2013")).
> > Both with and without acpi_gbl_parse_table_as_term_list set to TRUE, the
> > module-level code is not loaded properly. Via a SSDT override, it was
> > confirmed that removing the If conditional results in the expected
> > behavior.
> > 
> > Various details are given in https://github.com/Bumblebee-Project/bbswitch/issues/142
> > including lots of dmesg logs (see posts at the bottom).
> > With above MLC flag set (v4.9-rc4): https://pastebin.com/raw/vCEPGezX
> > With SSDT override (v4.9-rc2): https://pastebin.com/raw/3Fsf2VPU
> 
> I checked the post.
> It seems the current working way is: disabling _OSI(Windows 2013) which disables power resources.

That is how Lenovo probably intended to use it (only add Power Resources
when Windows 8 is detected).

> I have several questions related to this issue:
> 1. The following messages are prompt up when "acpi_gbl_parse_table_as_term_list = TRUE":
> [    2.519113] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup failure, AE_NOT_FOUND (20160831/psargs-359)
> [    2.519121] ACPI Error: Method parse/execution failed [\_SB.PCI0.PEG1.PEGP.DD02._BCL] (Node ffff8802568d3cf8), AE_NOT_FOUND (20160831/psparse-543)
> How was this triggered?

This comes from acpi_video.c, ssdt4.dsl contains a \_SB.PCI0.GFX0.DD02
device with an _ADR method, but no _BCL one. It is not a regression
though, let's ignore this for now.

> 2. I noticed the following statement:
>    So, for some reason Lenovo has decided to give all tables the same name.
>    The ACPI table override functionality matches possible candidates by signature, OEM ID and OEM Revision ID which are all the same.
>    As a result, the wrong SSDT is overridden.
> Could you provide the detail of the tables from the platform?
> What is the reason of doing such kind of craps in BIOS?

I have no idea why Lenovo would do such a silly thing, but that is why
we had to patch tables.c with:

    if (existing_table->checksum != 0xAF) {
        acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
        pr_info("Skipping next table\n");
        goto next_table;
    }

This is of course an unacceptable hard-coded value, but it was needed in
as a quick hack. For a longterm solution, maybe we can name the table
files specially such that additional match conditions can be given. This
is a different issue though.

What would you like to know about the platform? The acpidump is
available at
https://bugs.launchpad.net/lpbugreporter/+bug/752542/+attachment/4773050/+files/LENOVO-20287.tar.gz

ssdt5.dsl is the file of interest, grep for "Windows 2013".

Kind regards,
Peter

> Thanks and best regards
> Lv
> 
> > 
> > If you would like a new bugzilla entry or have some patches to test, you
> > know where to find us :)
> > --
> > Kind regards,
> > Peter Wu
> > https://lekensteyn.nl
