From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's
	already on.
Date: Tue, 20 Oct 2009 10:04:04 +0100
Message-ID: <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
	 <20091020083555.GG19095@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56225 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZJTJEB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 05:04:01 -0400
Received: by fxm18 with SMTP id 18so6136867fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2009 02:04:05 -0700 (PDT)
In-Reply-To: <20091020083555.GG19095@wrars-comp.wrarsdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On 10/20/09, Andrey Rahmatullin <wrar@altlinux.org> wrote:
> On Fri, Oct 16, 2009 at 10:22:47PM +0200, Corentin Chary wrote:
>> Switching the camera takes 500ms, checking if it's on is almost free...
> So if I don't want camera to be enabled, I should wait 500ms on boot to
> enable it and then other 500ms to disable?

Yup.  The original patch from Pekka was accepted alongside a patch
which enabled auto-suspend for the uvcvideo driver by default.  This
was shown to have the same effect on CPU wakeups as measured by
powertop.

So the question is why do you want to disable it?  Have you measured
the power consumption on the current kernel using a more comprehensive
method than powertop?

Or perhaps you have a different camera chip?  Have you tried enabling
auto-suspend manually?  If it works, perhaps that driver can enable
auto-suspend as well.

Regards
Alan
