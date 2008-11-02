From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/3] acpi: compal-laptop: use rfkill switch subsystem
Date: Sun, 02 Nov 2008 10:13:51 +0000
Message-ID: <490D7D5F.8070109@tuffmail.co.uk>
References: <200810292113.m9TLDM2g016601@imap1.linux-foundation.org> <490C30E8.6050708@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:54543 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYKBKLw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Nov 2008 05:11:52 -0500
Received: by nf-out-0910.google.com with SMTP id d3so803203nfc.21
        for <linux-acpi@vger.kernel.org>; Sun, 02 Nov 2008 02:11:50 -0800 (PST)
In-Reply-To: <490C30E8.6050708@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <aj504@student.cs.york.ac.uk>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, cezary.jackiewicz@gmail.com, andi@firstfloor.org, randy.dunlap@oracle.com

Alan Jenkins wrote:
> allakpm@linux-foundation.org wrote:
>   
>> From: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
>>
>> Removing unnecessary attributes, use rfkill switch subsystem.
>>
>> It depends on the rfkill changes in net-next-2.6.
>>
>> [randy.dunlap@oracle.com: compal-laptop: depends on RKFILL]
>> Signed-off-by: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
>> Cc: Andi Kleen <andi@firstfloor.org>
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     
>
> Having read rfkill.txt and tested the rfkill conversion for eeepc-laptop, 
> I have a few queries about this one.  I hope they are useful.
>
> Firstly, does the hardware preserve the rfkill state over power-off / reboot,
> like the EeePC?
>
> If it does, I think rfkill.txt says you need to generate "gratuitous"
> input events on init.  That would allow rfkill_input to initialize
> the system rfkill state from the hardware.  You should also do so on resume,
> in case someone hibernates, boots into another OS, changes the state, and then
> resumes back into Linux.
>
> Otherwise, the system rfkill state will default to enabled on boot,
> and your rfkill device will be set accordingly.  If compal-laptop
> used to preserve the state, I think this would be a regression.
>   
Scratch that, I've been re-educated by Herique.  If the platform does 
make the rfkill state persistent, you should call rfkill_set_default() 
at load-time, before rfkill_allocate / _register.
