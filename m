From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Thu, 20 Apr 2006 12:32:31 +0100
Message-ID: <20060420113231.GA27965@srcf.ucam.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com> <m21wytlwv3.fsf@phoenix.squirrel.nl> <4446C84B.7020104@rrz.uni-koeln.de> <m2vet41q9n.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:62683 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750702AbWDTLcl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 07:32:41 -0400
Content-Disposition: inline
In-Reply-To: <m2vet41q9n.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Berthold Cogel <cogel@rrz.uni-koeln.de>, linux-acpi@vger.kernel.org

On Thu, Apr 20, 2006 at 12:43:16PM +0200, Johan Vromans wrote:
> Berthold Cogel <cogel@rrz.uni-koeln.de> writes:
> 
> > What is the recommended way to solve the problem with the smart
> > battery for newer kernels?
> 
> The right solution is hal, but I don't know whether it has been picked
> up yet.

No. There needs to be a kernel driver, regardless of how it provides 
information. hal can only display what the kernel gives it - it's not a 
set of drivers, and it can't read from a smart battery on its own.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
