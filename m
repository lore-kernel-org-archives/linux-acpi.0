From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Was: Re: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Sat, 22 Apr 2006 22:53:02 +0200
Message-ID: <m27j5h49jl.fsf@phoenix.squirrel.nl>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
	<m21wytlwv3.fsf@phoenix.squirrel.nl>
	<4446C84B.7020104@rrz.uni-koeln.de>
	<m2vet41q9n.fsf@phoenix.squirrel.nl>
	<20060420113231.GA27965@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:38666 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751172AbWDVUxF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Apr 2006 16:53:05 -0400
In-Reply-To: <20060420113231.GA27965@srcf.ucam.org> (Matthew Garrett's
 message of "Thu, 20 Apr 2006 12:32:31 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> On Thu, Apr 20, 2006 at 12:43:16PM +0200, Johan Vromans wrote:
>> Berthold Cogel <cogel@rrz.uni-koeln.de> writes:
>> 
>> > What is the recommended way to solve the problem with the smart
>> > battery for newer kernels?
>> 
>> The right solution is hal, but I don't know whether it has been picked
>> up yet.
>
> No. There needs to be a kernel driver, regardless of how it provides 
> information. 

Isn't that exactly what Rich Townsend's acpi_sbs implements?

-- Johan
