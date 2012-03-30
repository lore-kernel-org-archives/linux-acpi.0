From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: Do cpufreq clamping for throttling per package
 v2
Date: Fri, 30 Mar 2012 08:00:48 -0400
Message-ID: <4F75A070.9020008@kernel.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org> <1328545032-21373-5-git-send-email-andi@firstfloor.org> <4F758569.9080608@kernel.org> <20120330114633.GA16502@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53138 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934174Ab2C3MAv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 08:00:51 -0400
In-Reply-To: <20120330114633.GA16502@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On 03/30/2012 07:46 AM, Matthew Garrett wrote:

> On Fri, Mar 30, 2012 at 06:05:29AM -0400, Len Brown wrote:
>> Andi,
>> Can you re-base this on top of my release tree?
>>
>> Your fix is important, but conflicted with mjg's
>> more invasive percentage -> frequency change.
> 
> Sorry, I think it's probably better not to take my patch here - the spec 
> uses percentages rather than frequencies. I'm not convinced that that 
> makes sense, but there's some chance that some behaviour may end up 
> depending on that.
> 


Ok Matthew, I've dropped your patch and pulled in Andi's.

thanks,
-Len
