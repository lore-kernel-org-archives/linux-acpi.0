From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Kernel Version specific vendor override possibilities needed
 - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 18:07:26 +0300
Message-ID: <47BD93AE.7000609@gmail.com>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org> <20080220182339.GC17648@khazad-dum.debian.net> <20080220184954.GB23679@srcf.ucam.org> <20080221031324.GB6344@khazad-dum.debian.net> <20080221091532.GA3091@srcf.ucam.org> <20080221135132.GE14614@mit.edu> <20080221143052.GA8389@srcf.ucam.org> <47BD8F41.6000801@gmail.com> <20080221145527.GA8768@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:52181 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbYBUPHe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 10:07:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1001645ugc.16
        for <linux-acpi@vger.kernel.org>; Thu, 21 Feb 2008 07:07:31 -0800 (PST)
In-Reply-To: <20080221145527.GA8768@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Theodore Tso <tytso@MIT.EDU>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> On Thu, Feb 21, 2008 at 05:48:33PM +0300, Alexey Starikovskiy wrote:
>
>   
>> How about WMI?
>> Do you think that there will be some point in the future,
>> when we could claim that our WMI implementation is the
>> same as Windows + HW manufacturer private driver?
>>     
>
> When vendors require custom drivers, we're going to end up requiring a 
> custom driver. That's true regardless of how the functionality is 
> exposed. The solution there is to encourage vendors not to require 
> custom drivers, not to get them to expose the same functionality in two 
> different ways.
>
>   
It will always be two ways -- Windows way with WMI and other OSes way 
without it.
The choice is there to place this non-Windows custom driver -- in C or 
in AML.
This is their choice, right? If they choose to not create custom
driver or have some concerns about complexity of its implementation in
C rather than in AML, they should be allowed to choose AML.
