From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Kernel Version specific vendor override possibilities needed
 - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 17:48:33 +0300
Message-ID: <47BD8F41.6000801@gmail.com>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org> <20080221135132.GE14614@mit.edu> <20080221143052.GA8389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:1943 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYBUOsh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 09:48:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so996801ugc.16
        for <linux-acpi@vger.kernel.org>; Thu, 21 Feb 2008 06:48:36 -0800 (PST)
In-Reply-To: <20080221143052.GA8389@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> On Thu, Feb 21, 2008 at 08:51:32AM -0500, Theodore Tso wrote:
>
>   
>> It would be much better if we define feature-specific OSI() strings
>> that have well defined meanings for each place where Lenovo has to do
>> something different than What Happens With Windows --- especially for
>> stuff which is generic, since all laptop manufactuers need to
>> interoperate with whatever cr*p Windows ship.  At the end of the day,
>> since Intel was originally too lazy to ship an ACPI conformance test
>> suite, like it or not, Windows *has* become the APCI conformance test
>> suite, and all laptop manufacturers (at least for today) must bow to
>> the might and power which is the market share of Microsoft.
>>     
>
> My concern with this is that until we know where we deviate from the 
> Windows behaviour, we don't know what strings we'd need to provide. And 
> once we *do* know where we deviate, we should fix that deviation rather 
> than provide an identifying string.
>
>   
How about WMI?
Do you think that there will be some point in the future,
 when we could claim that our WMI implementation is the
same as Windows + HW manufacturer private driver?

Regards,
Alex.

