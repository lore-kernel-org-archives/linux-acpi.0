From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 09:25:20 -0400
Message-ID: <CAJ5Y-eaw4PbBMerXQXjzuiW=wB8G6bJe8QmCxmUW_ya9+iun1Q@mail.gmail.com>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
	<532ABD83.9020003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36808 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872AbaCTNZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 09:25:21 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so914097pdj.40
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 06:25:20 -0700 (PDT)
In-Reply-To: <532ABD83.9020003@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

Hi Tomasz,

On 20 March 2014 06:05, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:

>> +       if (!table_size)
>> +               table_size = table_header->length;
>> +
>
>
> If table_size == 0, that would causes 'entry' and 'table_end' are equal and
> no entries at all. For that case I would suggest to print error and return.
>

Hm. tbl_size and table_header->length are not the same. This needs to
be revisited.


>
> Changelog is saying that acpi_parse_entries() takes already mapped table and
> parses entries. IMO, caller should takes care about unmapping table. It can
> be still parsed using different ID later on.
>

Although I generally agree that mapping/umapping should be done in the
caller, it seems umapping in this manner is baked in APCI core code
and I didn't want to change too many things at once without causing
unintentional side effects elsewhere.


Thanks,
Ashwin
