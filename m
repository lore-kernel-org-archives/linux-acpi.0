From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [1/3] 2.6.23-rc2: known regressions
Date: Mon, 6 Aug 2007 20:37:25 +0800
Message-ID: <b6a2187b0708060537h4bff040eqa5f0b2f22a5a728e@mail.gmail.com>
References: <46B5FA29.2070509@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:31012 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbXHFMh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Aug 2007 08:37:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1768750wah
        for <linux-acpi@vger.kernel.org>; Mon, 06 Aug 2007 05:37:28 -0700 (PDT)
In-Reply-To: <46B5FA29.2070509@googlemail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Markus <lists4me@web.de>, "H. Peter Anvin" <hpa@zytor.com>, "Antonino A. Daplas" <adaplas@gmail.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Denis Sadykov <denis.m.sadykov@intel.com>, dth <dth@dth.net>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 8/6/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Unclassified
>
> Subject         : console is messed up after resume from s2ram or switching to console from X
> References      : http://lkml.org/lkml/2007/8/4/6
> Last known good : ?
> Submitter       : Jeff Chua <jeff.chua.linux@gmail.com>
> Caused-By       : ?
> Handled-By      : H. Peter Anvin <hpa@zytor.com>
>                   Antonino A. Daplas <adaplas@gmail.com>
> Status          : problem is being debugged

Thanks for Rafael for the workaround using "s2ram --force --acpi_sleep
1 --vbe_mode".
