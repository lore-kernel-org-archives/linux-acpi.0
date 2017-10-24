From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] device property: Track owner device of device property
Date: Tue, 24 Oct 2017 16:41:21 +0300
Message-ID: <fcde8be2-e19b-901c-b8fe-8dc54d1e847d@linux.intel.com>
References: <20171009132837.1096-1-jarkko.nikula@linux.intel.com>
 <20171020143423.GA27882@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020143423.GA27882@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10/20/2017 05:34 PM, Greg Kroah-Hartman wrote:
>> @@ -938,6 +940,7 @@ int device_add_properties(struct device *dev,
>>   
>>   	p->fwnode.ops = &pset_fwnode_ops;
>>   	set_secondary_fwnode(dev, &p->fwnode);
>> +	p->dev = dev;
> 
> Don't you also need to increment the reference counter here?  Or how is
> it assured that it will not go away?
> 
I need to scratch my head on this. It sounds more robust to track 
references and remove properties when last reference is dropped in 
device_remove_properties(). What I don't know are properties be expected 
to be copied and be usable for another device for instance by 
ACPI_COMPANION_SET().

I can figure out case where properties are added to one device, another 
device gets reference to them via ACPI_COMPANION_SET() and properties 
get freed when the first device is removed. But should the second device 
be able to use those properties at first place?

Rafael: What's you opinion: should there be reference counting for 
device properties? Initial increment in device_add_properties(), other 
around ACPI_COMPANION_SET()/set_primary_fwnode() and decrementing in 
device_remove_properties().

-- 
Jarkko
