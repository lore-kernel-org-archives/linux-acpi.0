From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 3/5]acpi:glue.c Fix warning: variable 'ret' set but not
 used
Date: Wed, 30 Jun 2010 06:21:58 -0700
Message-ID: <4C2B44F6.7000808@gmail.com>
References: <4C2A6B6C.1000306@gmail.com> <4C29674C.9070503@gmail.com> <4C28E14D.5050701@gmail.com> <1277621246-10960-4-git-send-email-justinmattock@gmail.com> <1277621246-10960-1-git-send-email-justinmattock@gmail.com> <7214.1277729293@redhat.com> <8066.1277750854@redhat.com> <22319.1277826461@redhat.com> <25800.1277889215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25800.1277889215@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 06/30/2010 02:13 AM, David Howells wrote:
> Justin P. Mattock<justinmattock@gmail.com>  wrote:
>
>>   	if (!ACPI_FAILURE(status)) {
>> -		int ret;
>>
>> -		ret = sysfs_create_link(&dev->kobj,&acpi_dev->dev.kobj,
>> +		fn = sysfs_create_link(&dev->kobj,&acpi_dev->dev.kobj,
>>   				"firmware_node");
>> -		ret = sysfs_create_link(&acpi_dev->dev.kobj,&dev->kobj,
>> +		pn = sysfs_create_link(&acpi_dev->dev.kobj,&dev->kobj,
>>   				"physical_node");
>> +	if (fn) {
>
> That new if-statement still needs indenting one more tab stop.  It's indented
> the same as the previous if-statement, but is actually in the body of that
> previous if-statement.
>
> The body of the second if-statement should be indented one tab beyond the if,
> and else/else-if statements and the final closing brace should be indented
> level with the if:
>
> 	if (...) {
> 		body;
> 	} else if (...) {
> 		body;
> 	} else {
> 		body;
> 	}
>
> so that they line up vertically.

Thanks for the info on this, I really appreciate it. I'll look at this 
today, and resend.
	

>
>> +		dev_warn(dev, "dev:%p Failed to create firmware_node: %d\n",
>> +			acpi_dev, fn);
>
> The "dev:%p " seems like it ought to be superfluous if you're using
> dev_warn(), and certainly, returning the pointer isn't really useful, I
> suspect.
>

I kept receiving an new warning for using acpi_dev the %p was the only 
option I saw in the Documentation that worked

> However, at this point you have two device struct pointers: dev and
> &acip_dev->dev, so printing them both is may be good.  Perhaps something like:
>
> +		dev_warn(&acpi_dev->dev,
> +			 "Failed to create firmware_node link to %s %s: %d\n",
> +			 dev_driver_string(dev), dev_name(dev), fn);
>
> David
>

o.k. I'll look at this today, and see if I can find/locate the device 
name and string for these.

Justin P. Mattock
