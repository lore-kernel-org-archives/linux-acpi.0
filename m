From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 0/3] rfkill_unregister() should always be followed by
 rfkill_destroy()
Date: Mon, 14 Sep 2009 15:57:15 +0100
Message-ID: <4AAE59CB.8030702@tuffmail.co.uk>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net> <20090914132401.GC32253@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:54023 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZINO5S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 10:57:18 -0400
In-Reply-To: <20090914132401.GC32253@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Johannes Berg <johannes@sipsolutions.net>

Henrique de Moraes Holschuh wrote:
> On Mon, 14 Sep 2009, Corentin Chary wrote:
>   
>>  drivers/platform/x86/dell-laptop.c   |   36 ++++++++++++++++++++++-----------
>>  drivers/platform/x86/hp-wmi.c        |    2 +-
>>  drivers/platform/x86/thinkpad_acpi.c |    1 +
>>     
>
> These are also likely needed in 2.6.31, please add appropriate Cc: lines to
> stable@kernel.org while adding the Acked-By's.
>
>   

Do they meet the -stable criteria?

...
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.
... (Documentation/stable_kernel_rules.txt)

Regards
Alan
