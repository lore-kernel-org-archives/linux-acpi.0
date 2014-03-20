From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 09:27:53 -0400
Message-ID: <CAJ5Y-ebMtsdMPYsBo7h2hmDMnLks+b9wEgPX26EtHor+EFjs+g@mail.gmail.com>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
	<532ABD83.9020003@linaro.org>
	<532ABFF2.6080103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50635 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbaCTN1y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 09:27:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so938841pab.24
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 06:27:53 -0700 (PDT)
In-Reply-To: <532ABFF2.6080103@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

On 20 March 2014 06:16, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:

>>> +    return acpi_parse_entries(table_header->length, handler,
>>> table_header,
>>> +            entry_id, max_entries);
>
> Also, first argument of acpi_parse_entries() expect subtable start point
> offset, but now it points to the end of table.
>


Not sure what you mean. First arg of acpi_parse_entries expects
table_size, not an offset.

Ashwin
