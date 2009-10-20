From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's
	already on.
Date: Tue, 20 Oct 2009 15:19:54 +0100
Message-ID: <9b2b86520910200719l34e96c88y739c14f0b9f339be@mail.gmail.com>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
	 <20091020083555.GG19095@wrars-comp.wrarsdomain>
	 <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
	 <20091020092402.GI19095@wrars-comp.wrarsdomain>
	 <9b2b86520910200238u66af0d34v99931cf86507d5ff@mail.gmail.com>
	 <20091020094143.GJ19095@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:65500 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZJTOTv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 10:19:51 -0400
Received: by fxm18 with SMTP id 18so6477620fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2009 07:19:55 -0700 (PDT)
In-Reply-To: <20091020094143.GJ19095@wrars-comp.wrarsdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On 10/20/09, Andrey Rahmatullin <wrar@altlinux.org> wrote:
> On Tue, Oct 20, 2009 at 10:38:17AM +0100, Alan Jenkins wrote:
>> yes but if you are missing the original "enable camera by default"
>> patch  *which has already been merged* then you are almost certainly
>> also missing the patch to enable autosuspend on uvcvideo by default.
> No, I'm not missing it, I'm using .32-rc5
>
>> Yeah, powertop's autosuspend recommendation is a bit outdated.
> So, can I safely ignore it and assume all is right when I use latest
> kernels?

Sorry, I assumed this was the case but I didn't check properly.  As
Luca observes it's not been merged yet.  <google>.

The patch exists in Fedora
<http://osdir.com/ml/fedora-extras-commits/2009-07/msg06079.html>.

with the aim of beta-testing it
<http://lkml.indiana.edu/hypermail/linux/kernel/0909.1/03142.html>.
It's fair to say there's a degree of risk to it.  UVC is a "standard"
which presumably has various implementations with their own potential
bugs.

In the mean time - the thread I linked to includes a helpful note from
Xandros.  They measured that enabling the camera on the 901 model cost
~3% of overall power.

I guess the argument is that it's better to waste a little power,
rather than make life hard for people who install Linux themselves
:-/.  After all these devices are mainly shipped with Windows, and the
original pre-installed Linux (which hacked around this in video
applications) is not seriously maintained.  The problem is that when
the pre-installed OS uses the hack, the camera will be disabled in the
BIOS.  When you install a generic version of Linux without hacked
applications, you either have eeepc-laptop enable the camera, or the
user has to learn how to do it themself.

I don't have a strong opinion myself, so long as it's fixed properly
in the long term.

Alan
