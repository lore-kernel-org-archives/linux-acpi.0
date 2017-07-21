From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: device property: acpi: add fwnode.h
Date: Fri, 21 Jul 2017 15:33:05 -0700
Message-ID: <59728121.2020508@gmail.com>
References: <1500578005-25893-1-git-send-email-frowand.list@gmail.com>
 <1500578005-25893-2-git-send-email-frowand.list@gmail.com>
 <2851122.8a0ts3VkAi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2851122.8a0ts3VkAi-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 07/21/17 15:03, Rafael J. Wysocki wrote:
> On Thursday, July 20, 2017 12:13:24 PM frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Frank Rowand <frank.rowand-7U/KSKJipcs@public.gmane.org>
>>
>> ACPI is impacted by changes to fwnode.h, add a file entry
>> to ACPI
>>
>> Signed-off-by: Frank Rowand <frank.rowand-7U/KSKJipcs@public.gmane.org>
> 
> ACK for this one.
> 
> Or do you want me to apply it?

Please apply it.  So there won't be any conflicts between trees if
any other changes get made to this entry later in this cycle.

Thanks,

Frank


> 
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 205d3977ac46..c0ac362e850a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -302,6 +302,7 @@ S:	Supported
>>  F:	drivers/acpi/
>>  F:	drivers/pnp/pnpacpi/
>>  F:	include/linux/acpi.h
>> +F:	include/linux/fwnode.h
>>  F:	include/acpi/
>>  F:	Documentation/acpi/
>>  F:	Documentation/ABI/testing/sysfs-bus-acpi
>>
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
