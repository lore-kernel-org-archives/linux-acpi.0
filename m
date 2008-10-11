From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 19:09:48 +0200
Message-ID: <200810111909.48897.rjw@sisk.pl>
References: <48F0DB0C.7060201@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58755 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759296AbYJKRFj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Oct 2008 13:05:39 -0400
In-Reply-To: <48F0DB0C.7060201@tuffmail.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Saturday, 11 of October 2008, Alan Jenkins wrote:
> I've just run an acpi-test kernel on my EeePC and noticed a new issue. 
> It seems to be caused (or revealed) by the EC interrupt transaction patch.
> 
> On the second suspend/resume cycle, I see a kernel error message.
> 
> [   78.747707] ACPI: Waking up from system sleep state S3
> [   79.330001] ACPI: EC: input buffer not empty, aborting transaction
> [   79.423327] ACPI: EC: non-query interrupt received, switching to
> interrupt mode
> 
> I still don't see any issues in the code.  I'll try getting a DEBUG
> trace to see the EC interrupts.  Any other suggestions?

Not really, but is this reproducible?  I mean, does it happen always on the
second resume and does it happen on every next resume after the first one?

Thanks,
Rafael
