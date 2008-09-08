From: Don <harterc1@comcast.net>
Subject: Re: acpi dump per request
Date: Sun, 07 Sep 2008 23:55:56 -0500
Message-ID: <48C4B05C.8050105@comcast.net>
References: <48C0D3B7.2010405@comcast.net> <200809080255.25194.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:35569
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbYIHEz5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 00:55:57 -0400
In-Reply-To: <200809080255.25194.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Don <harterc1@comcast.net>, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> Hi,
>
> On Friday 05 September 2008 08:37:43 am Don wrote:
>   
>> Just installed a new motherboard.  It is a Asus M2N-SLI.   I saw the
>> following in the log.
>>
>> hdc: UDMA/66 mode selected
>> hdc: UDMA/33 mode selected
>> hdc: CHECK for good STATUS
>> powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 5000+
>> processors (2 cpu cores) (version 2.20.00)
>> powernow-k8: ACPI Processor support is required for SMP systems but is
>> absent. Please load the ACPI Processor module before starting this driver.
>> powernow-k8: ACPI Processor support is required for SMP systems but is
>> absent. Please load the ACPI Processor module before starting this driver.
>> NET: Registered protocol family 10
>> lo: Disabled Privacy Extensions
>> ip6_tables: (C) 2000-2006 Netfilter Core Team
>> NET: Registered protocol family 17
>> ACPI Exception (thermal-0469): AE_ERROR, ACPI thermal trip point state
>> changed
>> Please send acpidump to linux-acpi@vger.kernel.org
>>     
>
> what kernel is that?
> Does this also happen with the latest 2.6.27-rcX kernel?
>
> If yes, best  is to open a bug at http://bugzilla.kernel.org and attach full
> dmesg output and acpidump there.
>
> Best you add Zhang Rui <rui.zhang@intel.com> and myself to the CC list
> of the bug.
>
> Thanks,
>
>        Thomas
>
>   
Linux linux-dzdg 2.6.25.11-0.1-default #1 SMP 2008-07-13 20:48:28 +0200 
x86_64 x86_64 x86_64 GNU/Linux
/I  haven't tried it with a newer kernel./
