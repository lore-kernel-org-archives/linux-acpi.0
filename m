From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Add Intel Poulsbo Stub Driver
Date: Fri, 10 Sep 2010 08:02:09 -0700
Message-ID: <4C8A4871.9040103@oracle.com>
References: <4C8A4285020000230002020B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:60886 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0IJPDs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Sep 2010 11:03:48 -0400
In-Reply-To: <4C8A4285020000230002020B@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: mjg@redhat.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

On 09/09/10 21:36, Joey Lee wrote:
>>> +        # Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
>>> +        # but for select to work, need to select ACPI_VIDEO's dependencies, ick
>>> +        select ACPI_VIDEO if ACPI
>>
>> What does it do when ACPI is not enabled?  Does the driver even build
>> when APCI is not enabled?  (given the acpi_video* calls in it)
>>
> 
> This driver will not do anything if API is not enabled. It only call
> acpi_video_register/acpi_video_unregister, and acpi/video.h handle it
> like the following:
> 
> #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> extern int acpi_video_register(void);
> extern void acpi_video_unregister(void);
> extern int acpi_video_get_edid(struct acpi_device *device, int type,
>                                int device_id, void **edid);
> #else
> static inline int acpi_video_register(void) { return 0; }
> static inline void acpi_video_unregister(void) { return; }
> static inline int acpi_video_get_edid(struct acpi_device *device, int
> type,
>                                       int device_id, void **edid)
> {
>         return -ENODEV;
> }
> #endif
> 
> So, I think don't need add "depends on ACPI_VIDEO". How do you think?

Yes, OK, I see.  Thanks.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
