From: Marco Aurelio da Costa <costa@gamic.com>
Subject: Re: [RFC][PATCH v3]: ACPI: Ignore invalid _PSS entries, but use valid ones
Date: Tue, 8 May 2012 13:13:18 +0200
Message-ID: <CAEe-dwjyd5wypPqAuNCwf+GcvGErQ_rXWbqpfCDAsihaNmbSeQ@mail.gmail.com>
References: <CAEe-dwjEM8bHV838VwAO1riQk7tVUgdwKxnULxXzrajqjHkLaQ@mail.gmail.com>
	<4FA8B62D.7000102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60554 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2EHLNT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 May 2012 07:13:19 -0400
Received: by obbtb18 with SMTP id tb18so9646995obb.19
        for <linux-acpi@vger.kernel.org>; Tue, 08 May 2012 04:13:19 -0700 (PDT)
In-Reply-To: <4FA8B62D.7000102@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

Hi, Len.

We are just using the data that is valid and ignoring the invalid
ones. The benefit is that we will have frequency control working on
Linux even if the table is not 100% correct.

We are not guessing anything, from what I see. This is not specific to
a brand or manufacturer. The test for the entry was there all along,
so the workaround is just improving on the simple case (bail out
completely and lose the capability).

With this patch, my battery lasts around 4h. Without it, less then 1h.

Cheers

On Tue, May 8, 2012 at 7:59 AM, Len Brown <lenb@kernel.org> wrote:
> A BIOS bug workaround like this is sort of a guessing game...
>
> What additional benefit do we get by making the workaround more complicated?
>
> thanks,
> -Len
>



-- 
Marco Costa
Customer Support
--
GAMIC mbH
Roermonder Strasse, 151
52072 Aachen
Germany
