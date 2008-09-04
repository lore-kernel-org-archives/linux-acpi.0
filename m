From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two
	patches in bug 10724 & 11428]
Date: Thu, 04 Sep 2008 10:58:15 +0800
Message-ID: <1220497095.4007.76.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>
	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
	 <48BE427C.3070204@suse.de>
	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
	 <48BF07E1.8080304@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57860 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbYIDCoO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Sep 2008 22:44:14 -0400
In-Reply-To: <48BF07E1.8080304@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-09-04 at 01:55 +0400, Alexey Starikovskiy wrote:
> Hi,
> Here is the patch, which moves almost all transaction functionality into interrupt handler, which is IMHO good.
> 
> with the enabled DEBUG, the interrupt picture looks like this (single transaction):
Thanks for your work and efforts. Maybe you have tested the patch on
your laptop. But IMO this is not reasonable. In the following cases
maybe the patch can't work well.
   a. EC GPE storm.  According to ACPI spec the EC uses the pulse
interrupt and interrupt is firmware generated using an EC GPIO output,
which is connected with chipset GPIO input. If the pulse waveform is
very wide, maybe several EC GPE interrupts will be triggered although EC
firmware generates one pulse waveform. How can we read the corresponding
data from EC in the GPE interrupt service handler? Maybe the read/write
data is completely incorrect.
   b. If there is no EC interrupt although OBF_1 bit is valid.(In theory
when OBF_1 is valid, EC should trigger GPE interrupt). In such case the
read/write flowchart will be wrong.

  At the same time it seems that EC transaction flowchart will become
more complex in this patch.


> [  228.823886] ACPI: EC: ---> status = 0x08 -- this is a check for IBF=0 before starting transaction
> [  228.823888] ACPI: EC: transaction start
> [  228.823890] ACPI: EC: <--- command = 0x80 -- here we write command
> [  228.824123] ACPI: EC: ~~~> interrupt -- this interrupt is generated with the same content in status register as before writing a command...
> [  228.824127] ACPI: EC: ---> status = 0x08
> [  228.824129] ACPI: EC: <--- data = 0x58
> [  228.824152] ACPI: EC: ~~~> interrupt -- and now EC start sending us interrupts like crazy...
> [  228.824155] ACPI: EC: ---> status = 0x02
> [  228.824169] ACPI: EC: ~~~> interrupt
> [  228.824172] ACPI: EC: ---> status = 0x02
> [  228.824186] ACPI: EC: ~~~> interrupt
> [  228.824189] ACPI: EC: ---> status = 0x02
> [  228.824203] ACPI: EC: ~~~> interrupt
> [  228.824206] ACPI: EC: ---> status = 0x02
> [  228.824219] ACPI: EC: ~~~> interrupt
> [  228.824222] ACPI: EC: ---> status = 0x02
> [  228.824236] ACPI: EC: ~~~> interrupt
> [  228.824239] ACPI: EC: ---> status = 0x02
> [  228.824253] ACPI: EC: ~~~> interrupt
> [  228.824256] ACPI: EC: ---> status = 0x02
> [  228.824270] ACPI: EC: ~~~> interrupt
> [  228.824273] ACPI: EC: ---> status = 0x02
> [  228.824287] ACPI: EC: ~~~> interrupt
> [  228.824290] ACPI: EC: ---> status = 0x02
> [  228.824304] ACPI: EC: ~~~> interrupt
> [  228.824307] ACPI: EC: ---> status = 0x02
> [  228.824321] ACPI: EC: ~~~> interrupt
> [  228.824324] ACPI: EC: ---> status = 0x02
> [  228.824337] ACPI: EC: ~~~> interrupt
> [  228.824340] ACPI: EC: ---> status = 0x02
> [  228.824354] ACPI: EC: ~~~> interrupt
> [  228.824357] ACPI: EC: ---> status = 0x02
> [  228.824371] ACPI: EC: ~~~> interrupt
> [  228.824374] ACPI: EC: ---> status = 0x02
> [  228.824388] ACPI: EC: ~~~> interrupt
> [  228.824391] ACPI: EC: ---> status = 0x02
> [  228.824405] ACPI: EC: ~~~> interrupt
> [  228.824408] ACPI: EC: ---> status = 0x02
> [  228.824422] ACPI: EC: ~~~> interrupt
> [  228.824425] ACPI: EC: ---> status = 0x02
> [  228.824439] ACPI: EC: ~~~> interrupt
> [  228.824442] ACPI: EC: ---> status = 0x02
> [  228.824455] ACPI: EC: ~~~> interrupt
> [  228.824458] ACPI: EC: ---> status = 0x02
> [  228.824472] ACPI: EC: ~~~> interrupt
> [  228.824475] ACPI: EC: ---> status = 0x02
> [  228.824489] ACPI: EC: ~~~> interrupt
> [  228.824492] ACPI: EC: ---> status = 0x02
> [  228.824506] ACPI: EC: ~~~> interrupt
> [  228.824509] ACPI: EC: ---> status = 0x02
> [  228.824523] ACPI: EC: ~~~> interrupt
> [  228.824526] ACPI: EC: ---> status = 0x02
> [  228.824540] ACPI: EC: ~~~> interrupt
> [  228.824543] ACPI: EC: ---> status = 0x02
> [  228.824557] ACPI: EC: ~~~> interrupt
> [  228.824560] ACPI: EC: ---> status = 0x02
> [  228.824573] ACPI: EC: ~~~> interrupt
> [  228.824576] ACPI: EC: ---> status = 0x02
> [  228.824590] ACPI: EC: ~~~> interrupt
> [  228.824593] ACPI: EC: ---> status = 0x02
> [  228.824607] ACPI: EC: ~~~> interrupt
> [  228.824610] ACPI: EC: ---> status = 0x02
> [  228.824624] ACPI: EC: ~~~> interrupt
> [  228.824627] ACPI: EC: ---> status = 0x02
> [  228.824641] ACPI: EC: ~~~> interrupt
> [  228.824644] ACPI: EC: ---> status = 0x02
> [  228.824658] ACPI: EC: ~~~> interrupt
> [  228.824661] ACPI: EC: ---> status = 0x02
> [  228.824675] ACPI: EC: ~~~> interrupt
> [  228.824678] ACPI: EC: ---> status = 0x02
> [  228.824691] ACPI: EC: ~~~> interrupt
> [  228.824694] ACPI: EC: ---> status = 0x02
> [  228.824708] ACPI: EC: ~~~> interrupt
> [  228.824711] ACPI: EC: ---> status = 0x02
> [  228.824785] ACPI: EC: ~~~> interrupt    --- one more "real" interrupt. Others are just garbage.
> [  228.824788] ACPI: EC: ---> status = 0x01
> [  228.824791] ACPI: EC: ---> data = 0x35
> [  228.824805] ACPI: EC: ~~~> interrupt
> [  228.824808] ACPI: EC: ---> status = 0x00
> [  228.824822] ACPI: EC: ~~~> interrupt
> [  228.824825] ACPI: EC: ---> status = 0x00
> [  228.824839] ACPI: EC: ~~~> interrupt
> [  228.824842] ACPI: EC: ---> status = 0x00
> [  228.824856] ACPI: EC: ~~~> interrupt
> [  228.824859] ACPI: EC: ---> status = 0x00
> [  228.824873] ACPI: EC: ~~~> interrupt
> [  228.824876] ACPI: EC: ---> status = 0x00
> [  228.824890] ACPI: EC: ~~~> interrupt
> [  228.824893] ACPI: EC: ---> status = 0x00
> [  228.824907] ACPI: EC: ~~~> interrupt
> [  228.824910] ACPI: EC: ---> status = 0x00
> [  228.824924] ACPI: EC: ~~~> interrupt
> [  228.824926] ACPI: EC: ---> status = 0x00
> [  228.824940] ACPI: EC: ~~~> interrupt
> [  228.824943] ACPI: EC: ---> status = 0x00
> [  228.824957] ACPI: EC: ~~~> interrupt
> [  228.824960] ACPI: EC: ---> status = 0x00
> [  228.824974] ACPI: EC: ~~~> interrupt
> [  228.824977] ACPI: EC: ---> status = 0x00
> [  228.824991] ACPI: EC: ~~~> interrupt
> [  228.824994] ACPI: EC: ---> status = 0x00
> [  228.825008] ACPI: EC: ~~~> interrupt
> [  228.825011] ACPI: EC: ---> status = 0x00
> [  228.825025] ACPI: EC: ~~~> interrupt
> [  228.825028] ACPI: EC: ---> status = 0x00
> [  228.825042] ACPI: EC: ~~~> interrupt
> [  228.825044] ACPI: EC: ---> status = 0x00
> [  228.825058] ACPI: EC: ~~~> interrupt
> [  228.825061] ACPI: EC: ---> status = 0x00
> [  228.825075] ACPI: EC: ~~~> interrupt
> [  228.825078] ACPI: EC: ---> status = 0x00
> [  228.825092] ACPI: EC: ~~~> interrupt
> [  228.825095] ACPI: EC: ---> status = 0x00
> [  228.825109] ACPI: EC: ~~~> interrupt
> [  228.825112] ACPI: EC: ---> status = 0x00
> [  228.825126] ACPI: EC: ~~~> interrupt
> [  228.825129] ACPI: EC: ---> status = 0x00
> [  228.825143] ACPI: EC: ~~~> interrupt
> [  228.825146] ACPI: EC: ---> status = 0x00
> [  228.825160] ACPI: EC: ~~~> interrupt
> [  228.825162] ACPI: EC: ---> status = 0x00
> [  228.825176] ACPI: EC: ~~~> interrupt
> [  228.825179] ACPI: EC: ---> status = 0x00
> [  228.825193] ACPI: EC: ~~~> interrupt
> [  228.825196] ACPI: EC: ---> status = 0x00
> [  228.825210] ACPI: EC: ~~~> interrupt
> [  228.825213] ACPI: EC: ---> status = 0x00
> [  228.825227] ACPI: EC: ~~~> interrupt
> [  228.825230] ACPI: EC: ---> status = 0x00
> [  228.825244] ACPI: EC: ~~~> interrupt
> [  228.825247] ACPI: EC: ---> status = 0x00
> [  228.825261] ACPI: EC: ~~~> interrupt
> [  228.825264] ACPI: EC: ---> status = 0x00
> [  228.825277] ACPI: EC: ~~~> interrupt
> [  228.825280] ACPI: EC: ---> status = 0x00
> [  228.825294] ACPI: EC: ~~~> interrupt
> [  228.825297] ACPI: EC: ---> status = 0x00
> [  228.825311] ACPI: EC: ~~~> interrupt
> [  228.825314] ACPI: EC: ---> status = 0x00
> [  228.825328] ACPI: EC: ~~~> interrupt
> [  228.825331] ACPI: EC: ---> status = 0x00
> [  228.825345] ACPI: EC: ~~~> interrupt
> [  228.825348] ACPI: EC: ---> status = 0x00
> [  228.825362] ACPI: EC: ~~~> interrupt
> [  228.825365] ACPI: EC: ---> status = 0x00
> [  228.825379] ACPI: EC: ~~~> interrupt
> [  228.825381] ACPI: EC: ---> status = 0x00
> [  228.825387] ACPI: EC: transaction end
> 
> "transaction end" happens to be printed than EC stops sending interrupts. It looks like we get 100% interrupt load for 1ms or so...
> This piece does not have 0x20 (SCI) bit set, so it is not a query issue.
> 
> I'm out of ideas, so if you have some, please speak up.
> Also, Intel wants back this problematic notebook in 2 weeks, so I will not be able to debug it afterwards.
> 
> Regards,
> Alex.

