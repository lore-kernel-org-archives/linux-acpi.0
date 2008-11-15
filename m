From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sat, 15 Nov 2008 12:23:09 +0300
Message-ID: <491E94FD.4090002@gmail.com>
References: <1226722577.3104.4.camel@LiNuX> <20081114224321.ed9b1d7c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:25159 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYKOJXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 04:23:10 -0500
Received: by ug-out-1314.google.com with SMTP id 39so59868ugf.37
        for <linux-acpi@vger.kernel.org>; Sat, 15 Nov 2008 01:23:08 -0800 (PST)
In-Reply-To: <20081114224321.ed9b1d7c.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> (cc linux-acpi)
>
> On Fri, 14 Nov 2008 20:16:17 -0800 "Justin P. Mattock" <justinmattock@gmail.com> wrote:
>
>   
>> just pulled the latest git today and am now noticing
>> the lovely gpe storm being triggered.(dmesg below);
>>     
>
> Are any other effects observeable?
>
> I assume that 2.6.27 didn't do this.
>
>   
It did. Justin even opened a bug -- #11724.

