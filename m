From: "Koornstra, Reinoud" <koornstra@hp.com>
Subject: RE: rc8 didn't include patch (was Re: 2.6.28-rc7 acpi error
 messages)
Date: Fri, 12 Dec 2008 19:22:47 +0000
Message-ID: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319841@GVW1089EXB.americas.hpqcorp.net>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17319337@GVW1089EXB.americas.hpqcorp.net>
 <alpine.LFD.2.00.0812120137440.27968@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:25277 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYLLTXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Dec 2008 14:23:49 -0500
In-Reply-To: <alpine.LFD.2.00.0812120137440.27968@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

What can I do to help out in this?
I could install windows on this machine as well, but I guess you'd be more interested in how this is supported under windows and just seeing that it's supported well under windows doesn't give the info that's needed.
Since it's HP hardware, HP must have provided detailed specs to MS to be able to do this well, that is ......
IF it's being supported well.
Kind Regards,

Reinoud.

-----Original Message-----
From: Len Brown [mailto:lenb@kernel.org]
Sent: Thursday, December 11, 2008 10:40 PM
To: Koornstra, Reinoud
Cc: linux-acpi@vger.kernel.org
Subject: Re: rc8 didn't include patch (was Re: 2.6.28-rc7 acpi error messages)

> RC8 didn't include from Matthew Garret.
> Will the next version contain this patch?

nope.

That patch was based on a guess about what Windows does.
R8 isn't a time to patch Linux behaviour on all machines
based on speculation about what Windows does.

The "regression" is that we print an an error message
that we didn't used to print.  If we have to do anything
in rc8, we'd delete that warning message for now.

thanks,
Len Brown, Intel Open Source Technology Center

