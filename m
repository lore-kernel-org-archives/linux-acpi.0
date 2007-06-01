From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Laptop screen doesn't come on when lid is reopened
Date: Thu, 31 May 2007 23:03:39 -0400
Message-ID: <465F8C8B.7050304@gentoo.org>
References: <463E37EE.2060008@gentoo.org> <200705091148.21097.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp165.iad.emailsrvr.com ([207.97.245.165]:38789 "EHLO
	smtp165.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbXFADFG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 23:05:06 -0400
In-Reply-To: <200705091148.21097.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, luming.yu@intel.com

Len Brown wrote:
> Then the button driver should take the lid event and
> cause the code in the video driver to be invoked.
> I'm not sure what the best method for inter-driver
> event like this, since both of them can be modules.

I have taken a stab at this approach and it is working nicely. I'm 
sending patches to the linux-acpi list shortly.

Daniel
