From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Thu, 11 Jan 2007 23:01:30 +0300
Message-ID: <45A6979A.8030000@linux.intel.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701051310.41131.lenb@kernel.org> <200701052109.35707.bjorn.helgaas@hp.com> <200701111452.31490.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:6039 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751460AbXAKUBf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 15:01:35 -0500
In-Reply-To: <200701111452.31490.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, MoRpHeUz <morpheuz@gmail.com>, Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Len Brown wrote:
> On Friday 05 January 2007 23:09, Bjorn Helgaas wrote:
>   
>> On Friday 05 January 2007 11:10, Len Brown wrote:
>>     
>>> On Friday 05 January 2007 12:24, MoRpHeUz wrote:
>>>       
>>>>> What workaround are you using?
>>>>>           
>>>>  This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465
>>>>         
>>> Ah yes, the duplicate MADT issue is clearly a BIOS bug.
>>> It is possible that we can tweak our Linux workaround for it to be more
>>> Microsoft Windows Bug Compatbile(TM).
>>>       
>> Maybe Windows discovers processors using the namespace rather
>> than the MADT.
>>     
>
> Nod.
>
> Based on the fact that the 1st MADT on this box is toast, they're not using that.
> If the last one also doesn't work universally, then they must be using the namespace.
>
> For us to do the same would be a relatively significant change -- as it means
> we either have to push SMP startup after the interpreter init, or move the
> interpreter init yet sooner.
>
> In general, over the last couple of years, we've been forced for compatibility
> with various systems to move ACPI initialization sooner and sooner.
> (I think the last issue was getting the HW into "ACPI mode" sooner
>  because some stuff I don't recall didn't work if we didn't)
> It would probably make sense to experiment with what the soonest we
> can initialize ACPI, as I have a feeling we're going to have to head that way.
>
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

If any of the two tables does not work, may be we need both together?

Regards,
    Alex.
