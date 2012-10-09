From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Discussion on device's runtime wake capability
Date: Tue, 9 Oct 2012 21:57:23 +0100
Message-ID: <20121009205723.GA12385@srcf.ucam.org>
References: <5073C2D0.1080900@intel.com>
 <9718124.Sj45DoTPo2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52604 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab2JIU5g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2012 16:57:36 -0400
Content-Disposition: inline
In-Reply-To: <9718124.Sj45DoTPo2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Tue, Oct 09, 2012 at 10:48:58PM +0200, Rafael J. Wysocki wrote:

> Why do you think so?  How can you be sure that those resources are not needed
> to provide wakeup power to the device (or whatever generates the wakeup signal
> on its behalf))?

Right. For instance, on some Thinkpads turning off the power resources 
cuts power to the port entirely - there's no way to generate wakeups if 
there's no 5V line...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
