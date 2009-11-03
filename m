From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Mon, 2 Nov 2009 19:09:30 -0800
Message-ID: <43e72e890911021909ke760ee1sd68caa92f66d1727@mail.gmail.com>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
	<20091027165345.3237d3df@infradead.org> <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38471 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbZKCDJq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2009 22:09:46 -0500
In-Reply-To: <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Nov 2, 2009 at 7:02 PM, Len Brown <lenb@kernel.org> wrote:
>> > I get this when modprobing some module I am working on. I figured it
>> > was the module's fault but the EIP points to something else so I am
>> > not sure. I get the following repeating about 4 times on 2.6.32-rc5:
>>
>>
>> you can get this if your own code leaves interrupts disabled in a
>> kernel thread and then lets the cpu go idle...
>
> Unclear.
>
> acpi_enter_idle_bm() assumes that it is entered with irqs enabled,
> and so it we unconditionally disables IRQs.
>
> Then we unconditionally re-enable them.
>
> The problem seems to be that right after we enable them,
> we find that they are actually disabled, perhaps as
> a side-effect of SMM.
>
> Is your machine a Dell, per chance?

Nope.

> Please test the patches in this bug report:
> http://bugzilla.kernel.org/show_bug.cgi?id=14101

In my case it was as Arjan pointed out and I've fixed it in my driver.
Sorry for not reporting back and thanks for your review.

  Luis
