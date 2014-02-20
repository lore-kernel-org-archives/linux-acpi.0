From: Russ Anderson <rja@sgi.com>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Thu, 20 Feb 2014 17:01:26 -0600
Message-ID: <20140220230126.GA13558@sgi.com>
References: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>
Reply-To: Russ Anderson <rja@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:34041 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751862AbaBTXBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Feb 2014 18:01:30 -0500
Content-Disposition: inline
In-Reply-To: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: minyard@acm.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rja@sgi.com

On Tue, Feb 18, 2014 at 11:28:29AM -0500, Matthew Garrett wrote:
> The ACPI IPMI driver implements IPMI operation region support for the ACPI
> core. Systems that declare ACPI operation regions may reference them at any
> time, including during kernel initialisation. These accesses will fail
> unless the ACPI IPMI driver is present, and undesirable system behaviour
> may result. 

Could you be more specific?  Is the problem kernel code
trying to use IPMI functionality before the ipmi_si driver
is loaded?  Or something else?

What is the "undesirable system behaviour"?


> Set the default to Y in order to encourage distributions and
> users to configure kernels to avoid awkward surprises.

What are the "awkward surprises"?

Thanks,
-- 
Russ Anderson,  Kernel and Performance Software Team Manager
SGI - Silicon Graphics Inc          rja@sgi.com
