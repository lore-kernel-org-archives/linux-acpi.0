From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 15:06:14 +0100
Message-ID: <532AF5D6.3060406@linaro.org>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>	<532ABD83.9020003@linaro.org>	<CAJ5Y-eaw4PbBMerXQXjzuiW=wB8G6bJe8QmCxmUW_ya9+iun1Q@mail.gmail.com>	<532AF1B5.7050409@linaro.org> <CAJ5Y-eZCB=gZp2vvfY11y4-fxqRbwA4o2m2TAEPNZ_x-+hgwig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45132 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbaCTOFd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 10:05:33 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so790121wiv.15
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 07:05:32 -0700 (PDT)
In-Reply-To: <CAJ5Y-eZCB=gZp2vvfY11y4-fxqRbwA4o2m2TAEPNZ_x-+hgwig@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

On 20.03.2014 14:53, Ashwin Chaugule wrote:
> On 20 March 2014 09:48, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
>
>>>
>>> Although I generally agree that mapping/umapping should be done in the
>>> caller, it seems umapping in this manner is baked in APCI core code
>>> and I didn't want to change too many things at once without causing
>>> unintentional side effects elsewhere.
>>
>>
>> You will not cause any side effects if unmapping will stay in
>> acpi_table_parse_entries().
>
> What if callers only call acpi_parse_entries()?

acpi_parse_entries() requires already mapped MADT table and as you 
agreed on caller mapping/unmapping responsibility, caller need to unmap 
MADT table after all. I mean sth like that:

1. Get MADT table pointer
2. Map MADT table
3. Use acpi_parse_entries() as many times as you wish (some calls can 
return error but you don't have to map MADT again)
4. Unmap MADT table

What do you think?

Tomasz
