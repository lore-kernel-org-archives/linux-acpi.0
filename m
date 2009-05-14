From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Thu, 14 May 2009 09:47:39 +0800
Message-ID: <1242265659.3773.428.camel@localhost.localdomain>
References: <1242106060.3773.216.camel@localhost.localdomain>
	 <200905120857.40058.bjorn.helgaas@hp.com>
	 <1242184384.3773.241.camel@localhost.localdomain>
	 <20090513130803.GA27522@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57459 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbZENBpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 May 2009 21:45:16 -0400
In-Reply-To: <20090513130803.GA27522@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-05-13 at 21:08 +0800, Matthew Garrett wrote:
> The default behaviour should be to be compatible with Windows, 
> regardless of what the spec says. There's an argument for providing a 
> strict interpretation of the spec for testing purposes, but I don't
> see 
> any reason for it to be split up into dozens of individual kernel 
> parameters
The ACPI 1.0 spec is followed by windows XP. And the power state is not
checked in power transition under windows XP.
But we don't know whether it is still skipped on the new version
windows.(For example: Windows 7).

If the module param is removed, we must delete the source code related
with power state check. And if the power state is checked in power
transition on windows 7, what we should do? It is not reasonable to add
them again.

Maybe it is better to determine whether the power state check is skipped
in power transition.

Thanks.

