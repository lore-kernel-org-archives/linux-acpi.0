From: Michel Lespinasse <walken@google.com>
Subject: Re: ACPI fan driver: uninitialized variable when CONFIG_PM is not set
Date: Thu, 16 May 2013 00:56:37 -0700
Message-ID: <CANN689EHkK3xzN1bN5tUar=VLQxEanUEvopDH+0qAYkopHJibw@mail.gmail.com>
References: <CANN689GoQm8dGEN6L1xuuc_aZ_65G3N7tBPbEXHjAfebB7xrLw@mail.gmail.com>
	<1368666443.2063.22.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61590 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab3EPH4i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2013 03:56:38 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so5636759ieb.24
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2013 00:56:38 -0700 (PDT)
In-Reply-To: <1368666443.2063.22.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, May 15, 2013 at 6:07 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> Hi, Michel,
>
> thanks for your report.
> please check if the following patch helps or not.
> https://patchwork.kernel.org/patch/2574691/

Yes, this solves the issue.

Is there a chance that this will make it into 3.10 ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
