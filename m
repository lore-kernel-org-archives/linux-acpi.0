From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: The regression about EC GPE storm on the latest linus git tree
Date: Thu, 13 Nov 2008 11:32:57 +0300
Message-ID: <491BE639.6070407@suse.de>
References: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:42087 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbYKMIdB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 03:33:01 -0500
In-Reply-To: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Hi Yakui,

Does your latest kernel include yesterday pool of patches? 

Thanks,
Alex.
Zhao Yakui wrote:
> Hi, Alexey
>     I do some tests on the latest kernel and find that there exists the
> EC GPE storm on the three laptops. And then EC will work in polling
> mode. One is Asus EEEPC 1000. The other are HP laptops. 
>     
>     I do the similar test on the previous kernel(for example:
> 2.6.27-rc6, 2.6.27.4) and there is no EC GPE storm on the three laptops.
> The EC works in EC GPE interrupt mode. 
>     After the EC debug is used on the 2.6.27-rc6 kernel, I find that at
> most 8 EC interrupts are triggered in each EC transaction(This includes
> the effective EC GPE interrupts). In such case it should not be regarded
> as EC GPE storm.
>        
>     The attached are the dmesg info on the Asus EEEPC 1000. (One is
> based on the latest git tree. One is based on 2.6.27-rc6 kernel).
>     If you need to investigate the root cause about the EC GPE storm,
> please tell me what I should do. I will try my best to test the patch
> from you and give response.
> 
> Thanks.
>    Yakui
>  
> 

