From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] eeepc-laptop: Fix Kconfig
Date: Wed, 25 Feb 2009 00:03:17 -0800
Message-ID: <20090225000317.82c3c3a7.akpm@linux-foundation.org>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
	<1234722621-14498-2-git-send-email-corentincj@iksaif.net>
	<20090224144439.63c9b9f7.akpm@linux-foundation.org>
	<71cd59b00902242357o33e6c34dud718d470b9080b1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60008 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760582AbZBYIDd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Feb 2009 03:03:33 -0500
In-Reply-To: <71cd59b00902242357o33e6c34dud718d470b9080b1e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Wed, 25 Feb 2009 08:57:36 +0100 Corentin Chary <corentin.chary@gmail.com> wrote:

> On Tue, Feb 24, 2009 at 11:44 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Sun, 15 Feb 2009 19:30:18 +0100
> > Corentin Chary <corentincj@iksaif.net> wrote:
> >
> >> Add a "select INPUT" to Kconfig now that eeepc-laptop
> >> is using the input layer.
> >>
> >> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> >> ---
> >> __drivers/platform/x86/Kconfig | __ __1 +
> >> __1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> >> index 9436311..6f46bc6 100644
> >> --- a/drivers/platform/x86/Kconfig
> >> +++ b/drivers/platform/x86/Kconfig
> >> @@ -305,6 +305,7 @@ config EEEPC_LAPTOP
> >> __ __ __ select BACKLIGHT_CLASS_DEVICE
> >> __ __ __ select HWMON
> >> __ __ __ select RFKILL
> >> + __ __ select INPUT
> >> __ __ __ ---help---
> >> __ __ __ __ This driver supports the Fn-Fx keys on Eee PC laptops.
> >> __ __ __ __ It also adds the ability to switch camera/wlan on/off.
> >
> > I'm getting
> >
> > drivers/input/Kconfig:9:error: found recursive dependency: INPUT -> EEEPC_LAPTOP -> INPUT
> > make[1]: *** [oldconfig] Error 1
> >

(top-posting repaired.  Please don't - it makes it really hard to reply
to you)

> There was a patch collision in -mm
> It seems a patch with "depends INPUT" was already merged
> I used select because ASUS_LAPTOP and THINKPAD_ACPI are using select
> two, but for INPUT it's not realy needed.
> Maybe we should do a sed '/select INPUT/depends on INPUT/
> drivers/platform/x86/Kconfig
> 

I hate `select' and will gleefully leap on any s/select/depends/ patch,
whether it works or not :)

