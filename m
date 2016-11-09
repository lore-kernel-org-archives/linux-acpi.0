From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: ACPI module-level code (MLC) not working?
Date: Wed, 9 Nov 2016 01:02:27 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A2702BA@SHSMSX101.ccr.corp.intel.com>
References: <20161108094951.GA20849@al>
 <1AE640813FDE7649BE1B193DEA596E886A263E92@SHSMSX101.ccr.corp.intel.com>
 <20161108175650.GB21992@al>
 <1AE640813FDE7649BE1B193DEA596E886A270249@SHSMSX101.ccr.corp.intel.com>
 <20161109003250.GA16755@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4033 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbcKIBCj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Nov 2016 20:02:39 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Rick Kerkhof <rick.2889@gmail.com>, Bartosz Skrzypczak <barteks2x@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Zheng, Lv
> Subject: RE: ACPI module-level code (MLC) not working?
> 
> Hi,
> 
> > From: Peter Wu [mailto:peter@lekensteyn.nl]
> > Subject: Re: ACPI module-level code (MLC) not working?
> >
> > On Wed, Nov 09, 2016 at 12:07:47AM +0000, Zheng, Lv wrote:
> > > Hi,
> > >
> > > > From: Peter Wu [mailto:peter@lekensteyn.nl]
> > > > Subject: Re: ACPI module-level code (MLC) not working?
> > > >
> > > > On Tue, Nov 08, 2016 at 05:35:07PM +0000, Zheng, Lv wrote:
> > > > > Hi,
> > > > >
> > > > > > From: Peter Wu [mailto:peter@lekensteyn.nl]
> > > > > > Subject: ACPI module-level code (MLC) not working?
> > > > > >
> > > > > > Hi Lv,
> > > > > >
> > > > > > According to some tests, setting acpi_gbl_parse_table_as_term_list to
> > > > > > TRUE does is not effective. The code within the If-block is still not
> > > > > > executed early enough or something else is wrong.
> > > > > >
> > > > > > Previously Rick had an issue with an Acer Aspire V7-582PG where the dGPU
> > > > > > could not be powered off and I demonstrated an isolated test case in
> > > > > > http://www.spinics.net/lists/linux-acpi/msg70069.html
> > > > > >
> > > > > > In Bartosz's case, the dGPU cannot be powered on (also using nouveau),
> > > > > > preventing suspend from working. Situation is as follows (tested with
> > > > > > Linux 3.16, 4.8.4, 4.9-rc2, 4.9-rc4):
> > > > > >
> > > > > > His Lenovo IdeaPad Z510 laptop (BIOS date 2014) enables power resources
> > > > > > and related _PR3 objects under the conditional If(_OSI("Windows 2013")).
> > > > > > Both with and without acpi_gbl_parse_table_as_term_list set to TRUE, the
> > > > > > module-level code is not loaded properly. Via a SSDT override, it was
> > > > > > confirmed that removing the If conditional results in the expected
> > > > > > behavior.
> > > > > >
> > > > > > Various details are given in https://github.com/Bumblebee-Project/bbswitch/issues/142
> > > > > > including lots of dmesg logs (see posts at the bottom).
> > > > > > With above MLC flag set (v4.9-rc4): https://pastebin.com/raw/vCEPGezX
> > > > > > With SSDT override (v4.9-rc2): https://pastebin.com/raw/3Fsf2VPU
> > > > >
> > > > > I checked the post.
> > > > > It seems the current working way is: disabling _OSI(Windows 2013) which disables power
> resources.
> > > >
> > > > That is how Lenovo probably intended to use it (only add Power Resources
> > > > when Windows 8 is detected).
> > > >
> > > > > I have several questions related to this issue:
> > > > > 1. The following messages are prompt up when "acpi_gbl_parse_table_as_term_list = TRUE":
> > > > > [    2.519113] ACPI Error: [\_SB_.PCI0.GFX0.DD02._BCL] Namespace lookup failure, AE_NOT_FOUND
> > > > (20160831/psargs-359)
> > > > > [    2.519121] ACPI Error: Method parse/execution failed [\_SB.PCI0.PEG1.PEGP.DD02._BCL] (Node
> > > > ffff8802568d3cf8), AE_NOT_FOUND (20160831/psparse-543)
> > > > > How was this triggered?
> > > >
> > > > This comes from acpi_video.c, ssdt4.dsl contains a \_SB.PCI0.GFX0.DD02
> > > > device with an _ADR method, but no _BCL one. It is not a regression
> > > > though, let's ignore this for now.
> > > >
> > > > > 2. I noticed the following statement:
> > > > >    So, for some reason Lenovo has decided to give all tables the same name.
> > > > >    The ACPI table override functionality matches possible candidates by signature, OEM ID and
> > OEM
> > > > Revision ID which are all the same.
> > > > >    As a result, the wrong SSDT is overridden.
> > > > > Could you provide the detail of the tables from the platform?
> > > > > What is the reason of doing such kind of craps in BIOS?
> > > >
> > > > I have no idea why Lenovo would do such a silly thing, but that is why
> > > > we had to patch tables.c with:
> > > >
> > > >     if (existing_table->checksum != 0xAF) {
> > > >         acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
> > > >         pr_info("Skipping next table\n");
> > > >         goto next_table;
> > > >     }
> > > >
> > > > This is of course an unacceptable hard-coded value, but it was needed in
> > > > as a quick hack. For a longterm solution, maybe we can name the table
> > > > files specially such that additional match conditions can be given. This
> > > > is a different issue though.
> > > >
> > > > What would you like to know about the platform? The acpidump is
> > > > available at
> > > > https://bugs.launchpad.net/lpbugreporter/+bug/752542/+attachment/4773050/+files/LENOVO-
> > 20287.tar.gz
> > > >
> > > > ssdt5.dsl is the file of interest, grep for "Windows 2013".
> > >
> > > The table headers are:
> > >
> > > DefinitionBlock ("dsdt.aml", "DSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > > DefinitionBlock ("ssdt1.aml", "SSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > > DefinitionBlock ("ssdt2.aml", "SSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > > DefinitionBlock ("ssdt3.aml", "SSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > > DefinitionBlock ("ssdt4.aml", "SSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > > DefinitionBlock ("ssdt5.aml", "SSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
> > >
> > > They will be deemed as different versions of the same table from linux ACPI's point of view.
> > > Whether override will be done or not depends on Linux version.
> >
> > When I mentioned override, I referred to the method described in
> > Documentation/acpi/method-customizing.txt where any ACPI table can be
> > overridden via the initrd. Indeed, that method is unable to pick
> > arbitrary tables when they all have the same ID.
> >
> > > In recent Linux, ssdt1.aml will be used (no override), while in old Linux, ssdt5.aml will be used
> > (override).
> >
> > Does this refer to the same override method as described above? The
> > tables are loaded normally even if they have the same name.
> >
> > > Let me ask further.
> > > 1. Should OSPM load only ssdt5.aml or load only ssdt1.aml, or load
> > ssdt1.aml,ssdt2.aml,ssdt3.aml,ssdt4.aml,ssdt5.aml?
> > > 2. Can you confirm Windows behavior here via amli?
> > >
> > > Anyway, this is a special case that violates spec and seems to be aiming to trigger regressions
> > against changed logic brought by me.
> > > No matter whether the change is reasonable.
> >
> > OSPM should load all tables, they are all different. Perhaps you are
> > confusing this override method with how Linux normally loads tables?
> > (Aren't the identifiers just used for visual purposes and irrelevant for
> > normal operation?)
> 
> No, I'm not confusing it.
> I want to know the exact behavior here.
> 
> Because I'm actually about to change acpi_tb_compare_tables().
> This allows and acpi_install_table() invocations to override matched tables.
> So I'll remove Linux table override callback.

I also was about to change /sys/firmware/acpi/tables, renaming tables using the IDs.
This platform makes such cleanup impossible...

Back to the issue, IMO, the bug report is against _OSI support in module level.
I'll check if _OSI can be invoked in module level.

Thanks and best regards
Lv

> 
> Please see my recent comment in the following link:
> https://github.com/Bumblebee-Project/bbswitch/issues/142
> 
> Thanks
> Lv
> 
> >
> > I have not checked Windows, but I would guess that it loads normally.
> > Otherwise Lenovo QA has really been sleeping.
> >
> > Kind regards,
> > Peter
> >
> > > Linux only need a quirk for this platform.
> > >
> > > Thanks
> > > Lv
> > >
> > > >
> > > > Kind regards,
> > > > Peter
> > > >
> > > > > Thanks and best regards
> > > > > Lv
> > > > >
> > > > > >
> > > > > > If you would like a new bugzilla entry or have some patches to test, you
> > > > > > know where to find us :)
> > > > > > --
> > > > > > Kind regards,
> > > > > > Peter Wu
> > > > > > https://lekensteyn.nl
