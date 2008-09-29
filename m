From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bug (?) in ACPI info reporting
Date: Mon, 29 Sep 2008 22:46:15 +0400
Message-ID: <48E12277.6060801@gmail.com>
References: <1222708111.3688.15.camel@shaptop.om-md.eros-os.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:14125 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYI2Sqc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2008 14:46:32 -0400
Received: by ey-out-2122.google.com with SMTP id 6so619210eyi.37
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2008 11:46:30 -0700 (PDT)
In-Reply-To: <1222708111.3688.15.camel@shaptop.om-md.eros-os.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jonathan S. Shapiro" <shap@eros-os.com>
Cc: linux-acpi@vger.kernel.org

Jonathan S. Shapiro wrote:
> I just stuck an HP ev089aa battery into a dv6000 family laptop. Here is
> the content of /proc/acpi/battery/BAT0/info:
>
>   
>> present:                 yes
>> design capacity:         6000 mAh
>> last full capacity:      8384 mAh
>> battery technology:      rechargeable
>> design voltage:          14800 mV
>> design capacity warning: 422 mAh
>> design capacity low:     254 mAh
>> capacity granularity 1:  10 mAh
>> capacity granularity 2:  25 mAh
>> model number:            Primary
>> serial number:            
>> battery type:            LION
>> OEM info:                Hewlett-Packard
>>     
>
>
> Note the reported design capacity is (a) lower than last full capacity,
> which is clearly nonsensical, and (b) probably wrong, since manufacturer
> spec on this battery is 8800mAh, per
>
>  http://h20141.www2.hp.com/hpparts/Search_Results.asp?mscssid=AQNAGTTMERA38MKXNF2TN094B2SU9LUB&SearchInc=PartNumber
>
> Anybody have an idea what is going on here? I haven't had a chance to
> check the blacklist yet. I'm wondering if there may be a bug in the
> multiple capacity granularity handling?
>
>   
Could it be that this is not default battery for your system (with 
default being 6000)?
Please send in acpidump output.

Regards,
Alex.
> shap
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

