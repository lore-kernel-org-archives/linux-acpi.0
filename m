From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [Linaro-acpi] [RFC] ACPI: Add new function to get table entries
Date: Thu, 20 Mar 2014 09:53:27 -0400
Message-ID: <CAJ5Y-eZCB=gZp2vvfY11y4-fxqRbwA4o2m2TAEPNZ_x-+hgwig@mail.gmail.com>
References: <1395270568-30021-1-git-send-email-ashwin.chaugule@linaro.org>
	<532ABD83.9020003@linaro.org>
	<CAJ5Y-eaw4PbBMerXQXjzuiW=wB8G6bJe8QmCxmUW_ya9+iun1Q@mail.gmail.com>
	<532AF1B5.7050409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54620 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338AbaCTNx2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2014 09:53:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so973783pab.33
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2014 06:53:27 -0700 (PDT)
In-Reply-To: <532AF1B5.7050409@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>

On 20 March 2014 09:48, Tomasz Nowicki <tomasz.nowicki@linaro.org> wrote:

>>
>> Although I generally agree that mapping/umapping should be done in the
>> caller, it seems umapping in this manner is baked in APCI core code
>> and I didn't want to change too many things at once without causing
>> unintentional side effects elsewhere.
>
>
> You will not cause any side effects if unmapping will stay in
> acpi_table_parse_entries().

What if callers only call acpi_parse_entries()?

Ashwin
