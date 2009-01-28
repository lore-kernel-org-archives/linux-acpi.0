From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: state of some x86 acpi patches
Date: Wed, 28 Jan 2009 15:45:16 -0800
Message-ID: <4980EE0C.4070308@goop.org>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu> <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain> <495C677F.6080707@goop.org> <20090102153957.GA1180@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:57287 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758254AbZA1XpT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jan 2009 18:45:19 -0500
In-Reply-To: <20090102153957.GA1180@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org

Ingo Molnar wrote:
> yes, that end result is the desired state of things. We did run with this 
> for several months and resolved all the cases that needed fixing, but 
> dropped them when the ACPI tree moved out from under us.
>
> Can resurrect it if Len feels OK about the concept. Len, you shouldnt 
> worry about conflicts - we can do it after the ACPI changes of this merge 
> window are upstream so there should be no conflict trouble at all. How 
> does that sound?
>   

Doesn't look like these changes made it in this time.  Did they get 
overlooked, or did some other problem come up?  Or did you want me to 
dig them up?

Thanks,
    J
