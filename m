From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [1/2] 2.6.23-rc3: known regressions with patches
Date: Sat, 01 Sep 2007 10:36:51 +0200
Message-ID: <46D924A3.3070207__47137.5365196311$1188635883$gmane$org@googlemail.com>
References: <46D59081.2040605@googlemail.com> <200708311741.22863.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:5829 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXIAIhK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Sep 2007 04:37:10 -0400
Received: by nf-out-0910.google.com with SMTP id f5so862289nfh
        for <linux-acpi@vger.kernel.org>; Sat, 01 Sep 2007 01:37:09 -0700 (PDT)
In-Reply-To: <200708311741.22863.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Daniel Ritz <daniel.ritz-ml@swissonline.ch>

Len Brown pisze:
> On Wednesday 29 August 2007 11:28, Michal Piotrowski wrote:
> 
>> ACPI
>>
>> Subject         : the fan doesn't work any more
>> References      : http://lkml.org/lkml/2007/8/28/359
>> Last known good : ?
>> Submitter       : Daniel Ritz <daniel.ritz-ml@swissonline.ch>
>> Caused-By       : Alexey Starikovskiy <astarikovskiy@suse.de>
>>                   commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
>> Handled-By      : Alexey Starikovskiy <astarikovskiy@suse.de>
>> Patch           : http://lkml.org/lkml/2007/8/29/15
>> Status          : patch was suggested
> 
> I believe that this is gone as of 2.6.23-rc4-git3
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8958

BTW. Maciej Rutecki has said that "MCFG bug on hp nx6310" is not
a regression, so regression counter for ACPI == 0 (if I didn't
overlook something :))

> 
> thanks,
> -Len
> 

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
