From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Discussion on device's runtime wake capability
Date: Wed, 10 Oct 2012 08:55:46 +0800
Message-ID: <5074C792.1030109@intel.com>
References: <5073C2D0.1080900@intel.com> <9718124.Sj45DoTPo2@vostro.rjw.lan> <20121009205723.GA12385@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16570 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174Ab2JJAzw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 20:55:52 -0400
In-Reply-To: <20121009205723.GA12385@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 10/10/2012 04:57 AM, Matthew Garrett wrote:
> On Tue, Oct 09, 2012 at 10:48:58PM +0200, Rafael J. Wysocki wrote:
> 
>> Why do you think so?  How can you be sure that those resources are not needed
>> to provide wakeup power to the device (or whatever generates the wakeup signal
>> on its behalf))?
> 
> Right. For instance, on some Thinkpads turning off the power resources 
> cuts power to the port entirely - there's no way to generate wakeups if 
> there's no 5V line...

Thanks for the info, and I've a question.
Are these ports run wake capable? i.e. do they have a _S0W object?

-Aaron

