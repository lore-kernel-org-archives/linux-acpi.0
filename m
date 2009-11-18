From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [patch 04/12] cmpc_acpi: add support for Classmate PC ACPI
	devices
Date: Wed, 18 Nov 2009 19:36:24 +0000
Message-ID: <9b2b86520911181136i2eec5850x355f6a279609b025@mail.gmail.com>
References: <200911172227.nAHMRUgH023139@imap1.linux-foundation.org>
	 <9b2b86520911180107r54fc14a2of2ccb19b25698523@mail.gmail.com>
	 <20091118182159.GC21600@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45405 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977AbZKRTgT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2009 14:36:19 -0500
Received: by bwz27 with SMTP id 27so1507708bwz.21
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2009 11:36:24 -0800 (PST)
In-Reply-To: <20091118182159.GC21600@vespa.holoscopio.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, don@syst.com.br

On 11/18/09, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> wrote:
> Since Andrew has put some patches over the first version, I had some
> doubts on how to handle the fixes. Should I import those patches as git
> patches and submit them together with many other patches fixing every
> issue in its own commit? Or should I write another version and write a
> log in the commit message?
>
> UPDATE:
> I've just fixed every issue reported. How should I send it?
>
> Regards,
> Cascardo.

Great!  I would send the revised version as a new patch.  Normally the
log of changes is not included in the commit message, because they
don't make much sense out of context.  I.e.

    commit message
    ---
      log of changes to original version here; git will ignore it

    diff ...

Thanks
Alan
