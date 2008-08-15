From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the function of acpi_ec_read_data
Date: Sat, 16 Aug 2008 00:38:58 +0400
Message-ID: <48A5E962.7030204@suse.de>
References: <1218699173.3998.60.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:42761 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbYHOUjG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 16:39:06 -0400
In-Reply-To: <1218699173.3998.60.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Zhao,
Good catch, it is probably debug patch gone bad. it is definitely needs to read "return x;"
Please submit patch, I ACK it.
Thanks,
Alex.


Zhao Yakui wrote:
> Hi, Alexey
>     There is a question about the function of acpi_ec_read_data.
>  
>     When the data is ready for OS, OS will check the OBF flag of EC status and then call the following
> function to read the data returned by EC controller.
> 
> static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
> {
>         u8 x = inb(ec->data_addr);
>         pr_debug(PREFIX "---> data = 0x%2.2x\n", x);
>         return inb(ec->data_addr);
> }
> 
>     Why is the EC data I/O address accessed twice to get the data returned by EC controller?
>     Does there exist some specific reason about it?
>  
> Thanks for the comments.
> 
> Best regards.
>    Yakui
> 

