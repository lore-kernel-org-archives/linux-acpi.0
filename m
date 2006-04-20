From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 20:28:02 +0400
Message-ID: <4447B692.3000704@linux.intel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <20060420161546.GB30021@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:9923 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751123AbWDTQ2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 12:28:10 -0400
In-Reply-To: <20060420161546.GB30021@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Apr 20, 2006 at 07:57:01PM +0400, Alexey Starikovskiy wrote:
> 
>> I think you will agree that ACPI buttons are special and will need special 
>> handling even in input stream...
>> Generic application does not need to know if power, sleep, or lid button is 
>> pressed, so you will need to intercept them from input stream... I cannot 
>> find any reason to mix these buttons into input, do you?
> 
> On many machines, they're /already/ in the input stream. Applications 
> that misbehave if they receive unknown keycodes are broken and need 
> fixing in any case.
> 
I don't quite understand your point... You want all buttons/switches in a computer to send events to input layer, regardless if this make sense or not, just to be consistent? May be you should go other way around and  if keyboard has some strange key, send it on its strange way? 
