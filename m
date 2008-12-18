From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: state of some x86 acpi patches
Date: Thu, 18 Dec 2008 11:46:39 -0800
Message-ID: <494AA89F.8020308@goop.org>
References: <4947FF4C.80706@goop.org> <874p111tta.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:45529 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbYLRTql (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Dec 2008 14:46:41 -0500
In-Reply-To: <874p111tta.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Brown, Len" <len.brown@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Andi Kleen wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>   
>> However, unlike early_ioremap(), __acpi_map_table just maintains a
>> single mapping which gets replaced each call, and has no corresponding
>> unmap function.  Implement this by just removing the previous mapping
>> each time its called.  Unfortunately, this will leave a stray mapping
>> at the end.
>>     
>
> Stray mappings are dangerous. They can lead to illegal cache aliases
> later. Better avoid them.
>
> I guess ACPI could call a cleanup function after it's done with
> all early mappings.
>   

Right.  But Yinghai (I think) went through and made all the acpi 
mappings get properly mapped and unmapped, so my patch is moot.

    J
