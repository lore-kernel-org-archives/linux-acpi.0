From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Mon, 08 Oct 2007 11:36:28 +0900
Message-ID: <470997AC.4080600@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com> <470220FE.2090506@gmail.com> <47044C6C.5030905@gmail.com> <47083555.2060605@gmail.com> <470981EE.30103@gmail.com> <47099628.2050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:2166 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbXJHCgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Oct 2007 22:36:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so639152rvb
        for <linux-acpi@vger.kernel.org>; Sun, 07 Oct 2007 19:36:34 -0700 (PDT)
In-Reply-To: <47099628.2050108@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hgsolari@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Hello,

Hernan G Solari wrote:
>> Hmmm... and the kernel freezes after this?  libata driver isn't
>> initialized yet.  I don't think libata has anything to do with here.
>>
>>   
> as I told you, the ATA problem was with the 2.6.22 version of the kernel
> and is not longer related to the freeze with kernel 2.6.23-rc8  I asked
> whether you wanted to see the ATA problem in that kernel or the present
> crash.
> 
>> Options: I can compile the 2.6.22 kernel to get the reported problem
>>       or try to debug the problem in 2.6.22.8 or something else it
>>        fits the kernel-team.
> 
> was my offer.
> 
> As you did not answer that point (you answered other points) I thought
> it was useless to debug a problem that is not longer there. I still
> thing that way.
> The booting is apparently allocating port services at the  point of
> freezing but not too close of the disk driver, that much I  knew.

Right, sorry about the confusion.  I think the screen capture would be
useful to ACPI developers.  Thanks.

-- 
tejun
