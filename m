From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC
	behaviour
Date: Fri, 19 Feb 2010 13:54:31 +0000
Message-ID: <20100219135431.GA29434@srcf.ucam.org>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com> <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35113 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0BSNye (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 08:54:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Fri, Feb 19, 2010 at 01:40:47AM -0500, Len Brown wrote:
> Matthew,
> 
> Is there a life failure someplace (eg. bugzilla) that works after this 
> patch?

My system statically initialises the variable containing the current 
brightness to 100, but doesn't include 100 in the list of valid 
brightnesses. Right now this causes us to stop believing _BQC. However, 
the enxt thing we do is set the brightness to maximum anyway - at this 
point _BQC will now return a correct value. So it makes sense to ignore 
_BQC failures until we've set a valid value. If it continues to give 
invalid results then we can invalidate it and just use our internal 
state.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
