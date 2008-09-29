From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bug (?) in ACPI info reporting
Date: Mon, 29 Sep 2008 23:23:32 +0400
Message-ID: <48E12B34.804@gmail.com>
References: <1222708111.3688.15.camel@shaptop.om-md.eros-os.com>	 <48E12277.6060801@gmail.com> <1222714691.3688.32.camel@shaptop.om-md.eros-os.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:25332 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYI2TXg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2008 15:23:36 -0400
Received: by ey-out-2122.google.com with SMTP id 6so625684eyi.37
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2008 12:23:34 -0700 (PDT)
In-Reply-To: <1222714691.3688.32.camel@shaptop.om-md.eros-os.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jonathan S. Shapiro" <shap@eros-os.com>
Cc: linux-acpi@vger.kernel.org

Jonathan S. Shapiro wrote:
> On Mon, 2008-09-29 at 22:46 +0400, Alexey Starikovskiy wrote:
>   
>> Jonathan S. Shapiro wrote:
>>     
>>> I just stuck an HP ev089aa battery into a dv6000 family laptop. Here is
>>> the content of /proc/acpi/battery/BAT0/info:
>>>
>>>   
>>>       
>>>> present:                 yes
>>>> design capacity:         6000 mAh
>>>> last full capacity:      8384 mAh
>>>> battery technology:      rechargeable
>>>> design voltage:          14800 mV
>>>> design capacity warning: 422 mAh
>>>> design capacity low:     254 mAh
>>>> capacity granularity 1:  10 mAh
>>>> capacity granularity 2:  25 mAh
>>>> model number:            Primary
>>>> serial number:            
>>>> battery type:            LION
>>>> OEM info:                Hewlett-Packard
>>>>         
>>>   
>>>       
>> Could it be that this is not default battery for your system (with 
>> default being 6000)?
>> Please send in acpidump output.
>>     
>
> acpidump output follows, but indeed this is not the default battery for
> the system. It is a high capacity that is also designed for this product
> line.
>
>   
Then this is most probably shortcoming of BIOS on your machine,
design values are hardcoded, while actual values are read from battery 
itself.
> As long as charging works okay I can't say as how I'm really bothered,
> but it seemed worth checking.
>
> DSDT @ 0x7fed364b
>   0000: 44 53 44 54 45 85 00 00 01 2f 48 50 20 20 20 20
> DSDTE..../HP    
>   
Please do it as attachment, we can't parse split lines.

