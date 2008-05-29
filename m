From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 12:08:44 +0900
Message-ID: <483E1E3C.8070307@gmail.com>
References: <20080528143857.GB5585@homac.suse.de> <20080528200227.80f708cd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:10295 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbYE2DIu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 May 2008 23:08:50 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3855248rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 28 May 2008 20:08:50 -0700 (PDT)
In-Reply-To: <20080528200227.80f708cd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Holger Macht <hmacht@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Andrew Morton wrote:
>> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_EJ0",
>> +					      &arg_list, NULL)))
>> +		printk(KERN_ERR "Failed to evaluate _EJ0!\n");
>> +}
> 
> It would be better if the printk were to self-identify where it is
> coming from.  If your kernel just blurts "Failed to evaluate _EJ0!"
> it's a bit of a head-scratcher.
> 
> "libata-acpi: failed to evaluate _EJ0", perhaps?

ata_port_printk() would be better.

Thanks.

-- 
tejun
