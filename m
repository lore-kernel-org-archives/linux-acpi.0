From: Kieran Clancy <clancy.kieran@gmail.com>
Subject: Re: [PATCH v2] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 6 Mar 2014 11:54:28 +1030
Message-ID: <CAGf84QK-N+C6eHct4XDzOCHwfN649F2okJ1y2V70wWz-wHFKEA@mail.gmail.com>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com>
 <53176D59.3030602@canonical.com> <CAGf84Q+7=abgk78WuhNWdy+3kgXma1fHj6OPk9ytQ4kFzcoFJA@mail.gmail.com>
 <1885040.WKp5oRmh5C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38984 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbaCFBY7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Mar 2014 20:24:59 -0500
In-Reply-To: <1885040.WKp5oRmh5C@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Li Guang <lig.fnst@cn.fujitsu.com>, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On Thu, Mar 6, 2014 at 11:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, March 06, 2014 11:04:14 AM Kieran Clancy wrote:
>>
>> Rafael, is it a separate process to get this in the stable tree or
>> will it naturally happen after being merged into the mainline?
>
> I need to add a proper "CC stable" tag to your patch for this to happen.
>
> Which -stable kernels should it go to?

3.2 and 3.10 seem like natural choices (3.4?), but I don't know the
norm for this kind of fix. Would there be any reason not to include it
in some particular stable kernels?

Cheers,
Kieran.
