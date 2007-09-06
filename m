From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: obtaining acpi details outside of drivers/acpi
Date: Thu, 06 Sep 2007 18:17:44 +0400
Message-ID: <46E00C08.4030200@gmail.com>
References: <1189073769.7969.32.camel@localhost>	 <200709060743.42060.lenb@kernel.org> <1189079221.7969.40.camel@localhost>	 <200709060922.50337.lenb@kernel.org> <1189086833.7969.58.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55464 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbXIFORx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 10:17:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so160248ugc
        for <linux-acpi@vger.kernel.org>; Thu, 06 Sep 2007 07:17:51 -0700 (PDT)
In-Reply-To: <1189086833.7969.58.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Alan Hourihane wrote:
> On Thu, 2007-09-06 at 09:22 -0400, Len Brown wrote:
>> On Thursday 06 September 2007 07:47, Alan Hourihane wrote:
>>
>>> Mmm. It seems acpi_video_bus_check() is static and therefore not
>>> available outside of video.c
>>>
>>>> BTW. I'm curious what you are trying to do.
>>>> There is actually quite a bit of movement in this code right now.
>>> Think about fbdev drivers (or some video driver).... Rather than
>>> bang on the hardware to try and do auto-detection of devices, it's much
>>> easier (and sometimes required) to just ask the system BIOS via ACPI to
>>> see what devices are available.
>>>
>>> I want to parse _DOD myself to see what's available in kernel space.
>> It would be good to have this code in only one place
>> and export it from there to other parts of the kernel that need it.
>> I'd like to be able to not have fbdev drivers depend on the acpi video driver,
>> so perhaps we could have some generic interface where fbdev is the consumer
>> and in this case acpi/video.c is the provider?
> 
> That sounds good. I'm open to suggestions on interface.
> 
> But is there anything better available now to scan the namespace in
> current released kernels for _DOD ?
2.6.23-rc5 has it...
> 
> Alan.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

