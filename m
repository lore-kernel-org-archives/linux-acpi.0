From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Sat, 22 Apr 2006 22:23:33 +0100
Message-ID: <20060422212333.GA11557@srcf.ucam.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com> <m21wytlwv3.fsf@phoenix.squirrel.nl> <4446C84B.7020104@rrz.uni-koeln.de> <m2vet41q9n.fsf@phoenix.squirrel.nl> <20060420113231.GA27965@srcf.ucam.org> <m27j5h49jl.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:62089 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751234AbWDVVXj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 17:23:39 -0400
Content-Disposition: inline
In-Reply-To: <m27j5h49jl.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-acpi@vger.kernel.org

On Sat, Apr 22, 2006 at 10:53:02PM +0200, Johan Vromans wrote:
> Matthew Garrett <mjg59@srcf.ucam.org> writes:
> > No. There needs to be a kernel driver, regardless of how it provides 
> > information. 
> 
> Isn't that exactly what Rich Townsend's acpi_sbs implements?

Yes, and it seems to work fairly well. It should really be submitted for 
mainline.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
