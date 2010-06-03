From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Fix the incorrect calculation about C-state idle
	time
Date: Thu, 3 Jun 2010 02:39:04 +0100
Message-ID: <20100603013904.GB18755@srcf.ucam.org>
References: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com> <20100602150659.GA5335@srcf.ucam.org> <1275527214.3718.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46576 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518Ab0FCBjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2010 21:39:12 -0400
Content-Disposition: inline
In-Reply-To: <1275527214.3718.38.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venki@google.com>

On Thu, Jun 03, 2010 at 09:06:54AM +0800, ykzhao wrote:
> On Wed, 2010-06-02 at 23:06 +0800, Matthew Garrett wrote:
> > What kind of system was this seen on?
> 
> This can be seen on laptops. But maybe the idle power effect is not
> significant on laptops like that on server machine. 
>      I also test the power on one T400 laptop and test shows that about
> 0.3W idle power is increased. 

Thanks, I was able to reproduce this behaviour. Your patch appears to 
fix it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
