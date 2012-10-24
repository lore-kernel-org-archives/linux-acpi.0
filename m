From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] Improve container_notify_cb() to support container
 hot-remove.
Date: Wed, 24 Oct 2012 09:51:23 +0800
Message-ID: <5087499B.4050505@cn.fujitsu.com>
References: <1350997839-13260-1-git-send-email-tangchen@cn.fujitsu.com>  <1350997839-13260-3-git-send-email-tangchen@cn.fujitsu.com> <1351029261.16186.3.camel@QWERTY1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:11770 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab2JXBwd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Oct 2012 21:52:33 -0400
In-Reply-To: <1351029261.16186.3.camel@QWERTY1.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Maslenkin <mihailm@parallels.com>
Cc: linux-acpi@vger.kernel.org

On 10/24/2012 05:54 AM, Mike Maslenkin wrote:
> On Tue, 2012-10-23 at 21:10 +0800, Tang Chen wrote:
>> +static int container_device_remove(struct acpi_device *device)
>> +{
>> +	int ret;
>> +	struct acpi_eject_event *ej_event;
>> +
>> +	ej_event = kmalloc(sizeof(*ej_event), GFP_KERNEL);
>> +	if (!ej_event)
>> +		return -ENOMEM;
>> +
>> +	ej_event->device = device;
>> +	ej_event->event = ACPI_NOTIFY_EJECT_REQUEST;
>> +
>> +	/* stop container device at first */
>> +	ret = acpi_bus_trim(device, 0);
>> +	printk(KERN_WARNING "acpi_bus_trim stop return %x\n", ret);
>> +	if (ret)
>> +		return ret;
>> +
> Looks like kfree() is missed here. Would it be better to stop container
> before event allocation?

Oh yes, my mistake.

And do the allocation after stopping container would be better. :)

Thanks.

>
>
> Mike.
>
>

