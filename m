From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 4/5] acpi: fix trivial warning
Date: Sun, 15 Nov 2009 21:10:27 +0300
Message-ID: <4B004413.5090903@gmail.com>
References: <1252870707-4824-1-git-send-email-felipe.contreras@gmail.com>	 <1252870707-4824-4-git-send-email-felipe.contreras@gmail.com>	 <1252870707-4824-5-git-send-email-felipe.contreras@gmail.com>	 <1252936556.28368.215.camel@desktop>	 <94a0d4530909140734q51779b76g2ddc7211ece87171@mail.gmail.com>	 <1252940549.28368.255.camel@desktop>	 <94a0d4530911111623h1ae3463dte8a3f83ec0ad1f75@mail.gmail.com>	 <1258134207.6411.0.camel@c-dwalke-linux.qualcomm.com>	 <94a0d4530911131228s6b6b6221o7b24002ca03373e5@mail.gmail.com>	 <1258305351.6428.8.camel@desktop>	 <94a0d4530911150927l3224e815ha6ff17aab6f19251@mail.gmail.com>	 <1258306352.6428.10.camel@desktop>  <4B00403E.3090907@gmail.com> <1258307915.6428.14.camel@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:43834 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZKOSKX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:10:23 -0500
In-Reply-To: <1258307915.6428.14.camel@desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

Daniel Walker wrote:
> On Sun, 2009-11-15 at 20:54 +0300, Alexey Starikovskiy wrote:
>   
>> You've made changes to automatically generated files, so all the style 
>> changes
>> would be overwritten when next time these files are generated -- all the 
>> files go through
>> Lindent, and almost all your changes were introduced by it. If you 
>> really want to make
>> style changes to ACPICA files, try to play with Lindent, so it produce 
>> what you want.
>> If you have anything beside style patches, please submit them separately
>>
>>     
>
> AFAIK, Lindent can't produce checkpatch clean output. It has to do with
> various short comings in indent. You really need a human to check up on
> it.
>
> Daniel
>
>   
It is not really possible. Lindent is not the last step in the process.


