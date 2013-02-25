From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] ACPI: Overriding ACPI tables via initrd only works
 with an initrd and on X86
Date: Mon, 25 Feb 2013 12:02:18 -0800
Message-ID: <512BC34A.9090504@zytor.com>
References: <1361538742-67599-1-git-send-email-trenn@suse.de> <1361538742-67599-3-git-send-email-trenn@suse.de> <CAE9FiQXnJF_qXgG5fN7xE7t40a5yF79hksei6YgYAcmjtaNwOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:32891 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759460Ab3BYUDQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2013 15:03:16 -0500
In-Reply-To: <CAE9FiQXnJF_qXgG5fN7xE7t40a5yF79hksei6YgYAcmjtaNwOg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net

On 02/25/2013 12:00 PM, Yinghai Lu wrote:
> 
> Can replace max_low_pfn_mapped with max_low_pfn instead ?
> like to see if you can put acpi tables above 4G for x86_64.
> 
> if it does not work, you can use min(max_low_pfn<<PAGE_SHIFT,  0xffffffffUL)
> instead.
> 

This is part of why we really need to get rid of these stupid variables
one and for all.  The only exception should perhaps be to mark the
HIGHMEM crossover point on HIGHMEM systems.

	-hpa


