From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 19:35:53 +0400
Message-ID: <4447AA59.8010300@linux.intel.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:46312 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751032AbWDTPgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 11:36:05 -0400
In-Reply-To: <20060420073713.GA25735@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Thu, Apr 20, 2006 at 01:45:27PM +0800, Yu, Luming wrote:
> 
>> Do you plan to port the whole acpi event interface into input layer?
>> If so,  keycode is NOT a right way.
> 
> Not really, though it would be one possibility. However, the input layer 
> doesn't really provide the flexibility needed for certain events. I'm 
> not sure what the right answer is for other events, but I'm pretty sure 
> the button driver maps onto the input layer sensibly.
> 
Could it be more sensible to use kevent and dbus for sending all events from ACPI?
