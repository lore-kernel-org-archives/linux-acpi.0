From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 15:59:46 +0100
Message-ID: <532B0262.3040708@linaro.org>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>	<532ABD83.9020003@linaro.org>	<532ABFF2.6080103@linaro.org>	<CAJ5Y-ebMtsdMPYsBo7h2hmDMnLks+b9wEgPX26EtHor+EFjs+g@mail.gmail.com>	<532AF5E9.2090208@linaro.org> <CAJ5Y-ebvg=Y0n9FUt2zx+ryCoqTD7kRnNy0A_55NCxaY9zKenA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39786 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933542AbaCTO7F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 10:59:05 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so686718wgg.13
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 07:59:04 -0700 (PDT)
In-Reply-To: <CAJ5Y-ebvg=Y0n9FUt2zx+ryCoqTD7kRnNy0A_55NCxaY9zKenA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>



On 20.03.2014 15:39, Ashwin Chaugule wrote:
> On 20 March 2014 10:06, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
>> On 20.03.2014 14:27, Ashwin Chaugule wrote:
>>>
>>> On 20 March 2014 06:16, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
>>>
>>>>>> +    return acpi_parse_entries(table_header->length, handler,
>>>>>> table_header,
>>>>>> +            entry_id, max_entries);
>>>>
>>>>
>>>> Also, first argument of acpi_parse_entries() expect subtable start point
>>>> offset, but now it points to the end of table.
>>>>
>>>
>>>
>>> Not sure what you mean. First arg of acpi_parse_entries expects
>>> table_size, not an offset.
>>
>>
>> As I mentioned in previous mail, first args of acpi_parse_entries will lead
>> us to first MADT entry list. By passing table_header->length we will get at
>> the end of MADT entry list. IMO, we should use table_size (snd argument of
>> acpi_table_parse_entries()) instead of table_header->length.
>>
>
> Right. I get the difference between tbl_size and table_header->length.
> But we need to rethink this apci_parse_entries() function and its use
> case again. If the caller is expected to pass tbl_size, then we're
> back full circle to using acpi_get_table_with_size() in the caller,
> which is kinda self defeating. :)

I believe that the most useful case for apci_parse_entries() is when you 
already get table pointer and want to do many things on entries. Then 
you don't have to traverse all ACPI tables list and do map/unmap dance 
over and over again :) and that's what your changelog is saying too :)

Tomasz
