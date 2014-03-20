From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 10:39:40 -0400
Message-ID: <CAJ5Y-ebvg=Y0n9FUt2zx+ryCoqTD7kRnNy0A_55NCxaY9zKenA@mail.gmail.com>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
	<532ABD83.9020003@linaro.org>
	<532ABFF2.6080103@linaro.org>
	<CAJ5Y-ebMtsdMPYsBo7h2hmDMnLks+b9wEgPX26EtHor+EFjs+g@mail.gmail.com>
	<532AF5E9.2090208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50496 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322AbaCTOjl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 10:39:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so1043652pad.3
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 07:39:41 -0700 (PDT)
In-Reply-To: <532AF5E9.2090208@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

On 20 March 2014 10:06, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
> On 20.03.2014 14:27, Ashwin Chaugule wrote:
>>
>> On 20 March 2014 06:16, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:
>>
>>>>> +    return acpi_parse_entries(table_header->length, handler,
>>>>> table_header,
>>>>> +            entry_id, max_entries);
>>>
>>>
>>> Also, first argument of acpi_parse_entries() expect subtable start point
>>> offset, but now it points to the end of table.
>>>
>>
>>
>> Not sure what you mean. First arg of acpi_parse_entries expects
>> table_size, not an offset.
>
>
> As I mentioned in previous mail, first args of acpi_parse_entries will lead
> us to first MADT entry list. By passing table_header->length we will get at
> the end of MADT entry list. IMO, we should use table_size (snd argument of
> acpi_table_parse_entries()) instead of table_header->length.
>

Right. I get the difference between tbl_size and table_header->length.
But we need to rethink this apci_parse_entries() function and its use
case again. If the caller is expected to pass tbl_size, then we're
back full circle to using acpi_get_table_with_size() in the caller,
which is kinda self defeating. :)

Ashwin
