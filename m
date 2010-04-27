From: Mike Travis <travis@sgi.com>
Subject: Re: ACPI acpi_processor_get_throttling_info taking excessive time?
Date: Tue, 27 Apr 2010 10:19:03 -0700
Message-ID: <4BD71C87.8020501@sgi.com>
References: <4BD4F0A5.7050208@sgi.com> <1272248522.25088.67.camel@rzhang1-desktop> <4BD5D81B.4020600@sgi.com> <alpine.LFD.2.00.1004270301340.3999@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:52960 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab0D0RTG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 13:19:06 -0400
In-Reply-To: <alpine.LFD.2.00.1004270301340.3999@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jack Steiner <steiner@sgi.com>, Hedi Berriche <hedi@sgi.com>, Robin Holt <holt@sgi.com>



Len Brown wrote:
>> ...I've added a new BZ:
>>
>> 	https://bugzilla.kernel.org/show_bug.cgi?id=15856
>>
>> and attached the console output I collected from:
>>
>> ignore_loglevel acpi.debug_layer=0x2800001f acpi.debug_level=0x00000027
>>
>> This took almost an hour to boot so adding all flags would not be
>> practical.
> 
> I don't see any attachments to that bug report.
> 
> CONFIG_ACPI_DEBUG=y with
> acpi.debug_layer=0x20000000 maxcpus=4 should do it.
> 
> Also, the output from acpidump.
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 
Hmm, I wonder why it didn't get put in?  It was a gzipped text file.

I'll add the above as soon as I get back on the system.  I *think*
this might be the relevant part.  It repeats this sequence 1664 times:


  584.386705 (    0.000126)| [  282.565042] processor_core-0609 [00] processor_get_info    : Bus mastering arbitration control present
  584.485405 (    0.098700)| [  282.577452] processor_core-0686 [00] processor_get_info    : Processor [0:0]
  584.485498 (    0.000093)| [  282.585423] processor_core-0689 [00] processor_get_info    : No PBLK (NULL address)
  584.485585 (    0.000087)| [  282.594175] ACPI: Execute Method [\_SB_.C000._PDC] (Node ffff8b27fc070210)
  584.659625 (    0.174040)| [  282.705124] processor_throttling-1143 [00] processor_get_throttli: pblk_address[0x00000000] duty_offset[0] duty_width[0]
  584.659764 (    0.000139)| [  282.717472] ACPI: Execute Method [\_SB_.C000._PTC] (Node ffff89affb0811f0)
  584.659851 (    0.000087)| [  282.776192] ACPI: Execute Method [\_SB_.C000._TSS] (Node ffff8ae7fc0721f0)

  584.750913 (    0.091062)| [  282.887162] processor_throttling-0482 [00] processor_get_throttli: Found 8 throttling states
  584.751027 (    0.000114)| [  282.896661] processor_throttling-0502 [00] processor_get_throttli: Extracting state 0
  584.751116 (    0.000089)| [  282.905454] processor_throttling-0502 [00] processor_get_throttli: Extracting state 1
  584.751212 (    0.000096)| [  282.914245] processor_throttling-0502 [00] processor_get_throttli: Extracting state 2
  584.751300 (    0.000088)| [  282.923042] processor_throttling-0502 [00] processor_get_throttli: Extracting state 3
  584.858075 (    0.106775)| [  282.931843] processor_throttling-0502 [00] processor_get_throttli: Extracting state 4
  584.858178 (    0.000103)| [  282.940654] processor_throttling-0502 [00] processor_get_throttli: Extracting state 5
  584.858268 (    0.000090)| [  282.949441] processor_throttling-0502 [00] processor_get_throttli: Extracting state 6
  584.858369 (    0.000101)| [  282.958233] processor_throttling-0502 [00] processor_get_throttli: Extracting state 7
  584.858460 (    0.000091)| [  282.967170] ACPI: Execute Method [\_SB_.C000._TPC] (Node ffff8947fc0701f0)
  584.858551 (    0.000091)| [  283.026637] processor_throttling-1189 [00] processor_get_throttli: Found 8 throttling states
  584.858651 (    0.000100)| [  283.036188] processor_throttling-0845 [00] processor_get_throttli: Invalid throttling state, reset
  584.958958 (    0.100307)| [  283.046279] processor_throttling-0265 [00] processor_throttling_n: PreChange Event:target T-state of CPU 0 is T0
  584.959084 (    0.000126)| [  283.060729] processor_throttling-0275 [00] processor_throttling_n: PostChange Event:CPU 0 is switched to T0
  584.959193 (    0.000109)| [  283.071686] ACPI: processor limited to max C-state 1
  584.959262 (    0.000069)| [  283.077760] ACPI: Execute Method [\_SB_.C000._CST] (Node ffff8987fc09f1f0)
  584.959340 (    0.000078)| [  283.139369] Monitor-Mwait will be used to enter C-1 state
  585.043300 (    0.083960)| [  283.145718] Monitor-Mwait will be used to enter C-3 state
  585.043375 (    0.000075)| [  283.151796] processor_idle-0519 [00] processor_get_power_in: Found 2 power states
