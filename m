From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Tue, 30 Oct 2007 14:28:10 +0000
Message-ID: <200710301428.11471.cathectic@slackadelic.com>
References: <200710300336.43696.cathectic@slackadelic.com> <20071030134701.GA11877@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:60046 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbXJ3O11 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 10:27:27 -0400
In-Reply-To: <20071030134701.GA11877@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tuesday 30 Otober 2007 13:47:01 Matthew Garrett wrote:
> I suspect that for a lot of cases, exporting this to userspace would be 
> helpful - it's often easier for us to do this mapping in hal and just 
> push out an updated fdi file than it would be to push out an updated 
> kernel driver.

But what would be mapped via HAL?

WMI is such a completely undefined "standard", that not only do you have to map
the GUIDs, but you'd also have to map the program logic as well (marshalling 
arguments, restricting function parameters, call order, etc) and this strikes 
me as being beyond the scope of an fdi file.

For some methods, which are quite simple, this _might_ be possible. For others
I've seen, this will end up a complete mess.

If you're going to do all that, you may as well write a driver in kernel space
and leave that to export the functionality in a way userspace can already handle.

> And for similar reasons, I think it would be helpful to provide 
> userspace with the ability to trigger WMI calls. It's going to be easier 
> for people to add GUIDs to a userspace file than to extend a kernel 
> driver, even if there are some cases that are better handled by having a 
> full in-kernel driver.

There are also other technical problems with this, beyond my own personal
disagreement - since WMI relies so heavily on ACPI (well, the driver here is
really just a simple wrapper), then you would have to start exporting bits of ACPI
to userspace to access WMI. As mentioned in the original patches - the mapper knows
nothing about "types", this knowledge is known only by the caller - WMI just deals
in acpi_buffer. My understanding is that ACPI would have to export the required 
functions and data structures so that userspace could provide then translate from
acpi_buffer to the known type (unless there is another way round this to import and
export the data to/ from userspace?)

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
