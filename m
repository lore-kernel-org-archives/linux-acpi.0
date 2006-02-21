From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.16-rc[34]: resume-from-RAM unreliable
Date: Tue, 21 Feb 2006 18:47:59 -0500
Message-ID: <43FBA6AF.3070207@rtr.ca>
References: <43F9D3CA.1010709@rtr.ca> <20060220210943.7f159749.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:45484 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030211AbWBUXsJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 18:48:09 -0500
In-Reply-To: <20060220210943.7f159749.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
>> For the past week, I've been trying to keep with the latest -rc*-git*
>> releases of 2.6.16 on my notebook, and something new in those is
>> impacting resume-from-RAM.

Mmm.. working 100% now with Randy Dunlop's ACPI additions from here:

     http://www.xenotime.net/linux/SATA/2.6.16-rc3/

Note that these are the latest evolution from a simpler patch by Jens
which I first started using in *spring 2005* to get suspend/resume working.

Are we *ever* going to add these to mainstream?
It's been almost a friggin' year!

Cheers

