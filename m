From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 14:48:37 +0100
Message-ID: <532AF1B5.7050409@linaro.org>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>	<532ABD83.9020003@linaro.org> <CAJ5Y-eaw4PbBMerXQXjzuiW=wB8G6bJe8QmCxmUW_ya9+iun1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50675 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbaCTNr4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 09:47:56 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so772535wiw.6
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 06:47:55 -0700 (PDT)
In-Reply-To: <CAJ5Y-eaw4PbBMerXQXjzuiW=wB8G6bJe8QmCxmUW_ya9+iun1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

On 20.03.2014 14:25, Ashwin Chaugule wrote:
> Hi Tomasz,
>
> On 20 March 2014 06:05, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
>
>>> +       if (!table_size)
>>> +               table_size = table_header->length;
>>> +
>>
>>
>> If table_size == 0, that would causes 'entry' and 'table_end' are equal and
>> no entries at all. For that case I would suggest to print error and return.
>>
>
> Hm. tbl_size and table_header->length are not the same. This needs to
> be revisited.
Indeed, table_size is used to find out where entry list starts.
table_header->length in turn, is used to find out end of entry list. If 
we pass table_size = 0, then we will parse none of entries.
>
>
>>
>> Changelog is saying that acpi_parse_entries() takes already mapped table and
>> parses entries. IMO, caller should takes care about unmapping table. It can
>> be still parsed using different ID later on.
>>
>
> Although I generally agree that mapping/umapping should be done in the
> caller, it seems umapping in this manner is baked in APCI core code
> and I didn't want to change too many things at once without causing
> unintentional side effects elsewhere.

You will not cause any side effects if unmapping will stay in 
acpi_table_parse_entries().

Tomasz
