From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Fri, 13 Jul 2012 08:13:55 +0100
Message-ID: <20120713071355.GA5516@srcf.ucam.org>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
 <20120713064801.GA4910@srcf.ucam.org>
 <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34795 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2GMHN7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 03:13:59 -0400
Content-Disposition: inline
In-Reply-To: <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, Jul 13, 2012 at 03:07:38PM +0800, AceLan Kao wrote:

> There are many different events to inform the system concurrently,
> evdev is just one of them.
> I'm not sure which one trigger the system to suspend while pressing
> the suspend hotkey, but
> the following suspends are triggered by acpi proc event.

I'm fine with killing the procfs interface (it's deprecated anyway, I 
think?) but I'm a little worried about this only handling one case. Is 
userspace guaranteed to ignore any further events that were delivered 
over the input layer.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
