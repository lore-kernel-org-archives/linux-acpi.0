From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms
Date: 2 Jun 2006 22:37:29 +0200
Message-ID: <20060602203729.GA74096@muc.de>
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E508@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:20485 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932563AbWFBUhb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 16:37:31 -0400
Date: Fri, 2 Jun 2006 22:37:29 +0200
Content-Disposition: inline
In-Reply-To: <8E5ACAE05E6B9E44A2903C693A5D4E8A15D0E508@hqemmail02.nvidia.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Currid <ACurrid@nvidia.com>
Cc: akpm@osdl.org, len.brown@intel.com, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Fri, Jun 02, 2006 at 11:22:00AM -0700, Andy Currid wrote:
> 
> As currently written, I think it's safe to call it. The sdt_entry table
> will be empty if the user specified 'acpi=off', so the function will
> return 0.

Ok. I guess it's a 2.6.17 candidate then (are systems with this issue
already shipping?) 

-Andi
