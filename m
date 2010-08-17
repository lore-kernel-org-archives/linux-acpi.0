From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI video: fix a poor error message
Date: Tue, 17 Aug 2010 08:24:25 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AE61F464@orsmsx503.amr.corp.intel.com>
References: <1282012975.5181.16.camel@rui>
 <20100817133458.GA22699@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19939 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619Ab0HQPY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2010 11:24:27 -0400
In-Reply-To: <20100817133458.GA22699@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>

Do we agree that the original message is unclear?

I'm not even sure that ACPI requires this method.

Perhaps the message should describe what won't happen because of the missing _BQC method.


>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
>Sent: Tuesday, August 17, 2010 6:35 AM
>To: Zhang, Rui
>Cc: Brown, Len; linux-acpi@vger.kernel.org; Moore, Robert; Thomas Renninger
>Subject: Re: [PATCH] ACPI video: fix a poor error message
>
>On Tue, Aug 17, 2010 at 10:42:55AM +0800, Zhang Rui wrote:
>>  		*cap |= ACPI_VIDEO_BACKLIGHT;
>>  		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
>> -			printk(KERN_WARNING FW_BUG PREFIX "ACPI brightness "
>> -					"control misses _BQC function\n");
>> +			printk(KERN_WARNING FW_BUG PREFIX "could not find "
>> +					"required _BQC function\n");
>
>I don't really like the "required". It's a spec requirement but the
>driver will work fine (if suboptimally) without it.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
