From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific driver
Date: Thu, 17 Jan 2008 12:51:39 -0800
Message-ID: <478FBFDB.4000600@oracle.com>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com> <20080117092030.a9dfe528.randy.dunlap@oracle.com> <200801171451.18613.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:54479 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbYAQUw3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 15:52:29 -0500
In-Reply-To: <200801171451.18613.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com

Len Brown wrote:
>>> +static int
>>> +memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
>>> +			     unsigned long *max_state)
>> Don't put 'static int' (return type etc.) on a line by itself.
>> That format is not wanted in Linux.   (many places here)
> 
> if checkpatch.pl and Lindent are happey (which they are not, totally)
> then I'm satisifed witht he Linux style of the code.
> 
> Randy, if you feel strongly about this this style nit,
> then change Lindent to implement it -- nagging
> developers about trivia is a waste of everybody's time.
> 
> thanks,
> -Len

http://marc.info/?l=linux-kernel&m=105451996829576&w=2

Thanks.

-- 
~Randy
