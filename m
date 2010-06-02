From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Fix the incorrect calculation about C-state idle
	time
Date: Wed, 2 Jun 2010 16:06:59 +0100
Message-ID: <20100602150659.GA5335@srcf.ucam.org>
References: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47643 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab0FBPHK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 11:07:10 -0400
Content-Disposition: inline
In-Reply-To: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venki@google.com>

On Wed, Jun 02, 2010 at 11:04:09AM +0800, yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> The C-state idle time is not calculated correctly, which will return the wrong
> residency time in C-state. It will have the following effects:
>    1.  The system can't choose the deeper C-state when it is idle next time.
> Of course the system power is increased. E.g. On one server machine about 40W
> idle power is increased.
>    2.  The powertop shows that it will stay in C0 running state about 95% time
> although the system is idle at most time.

What kind of system was this seen on?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
