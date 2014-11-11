From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 21:38:04 +0100
Message-ID: <1857695.vuMqt0pPSL@wuerfel>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com> <1625601.1yb4h3sjoe@wuerfel> <CAJe_ZhdEOWYzrB_nHwwJ51U0dHAZ7FkNvaVO1pYizfHN8KAg+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57343 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaKKUig (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 15:38:36 -0500
In-Reply-To: <CAJe_ZhdEOWYzrB_nHwwJ51U0dHAZ7FkNvaVO1pYizfHN8KAg+g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Patch Tracking <patches@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>

On Wednesday 12 November 2014 00:38:42 Jassi Brar wrote:
> On 11 November 2014 23:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 11 November 2014 23:09:16 Jassi Brar wrote:
> >> On 11 November 2014 22:03, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Tuesday 11 November 2014 19:27:07 Jassi Brar wrote:
> >> >> On 11 November 2014 18:32, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> >> >> > On 10 November 2014 23:04, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >> >>
> >> >> In even simpler terms.... I prefer controller specific
> >> >> encoding(0x50434300) instead of controller specific api
> >> >> (pcc_mbox_request_channel).  For a different class of controller, it
> >> >> is much cleaner to define a new encoding as compared to another
> >> >> xyz_mbox_request_channel() api.
> >> >
> >> > The problem with this approach is that it still leaves the interface
> >> > as controller specific, because the client now has to know that it
> >> > must pass the PCC identifier instead of an index.
> >> >
> >> Yup. I hope you are aware that the "index" argument of
> >> pcc_mbox_request_channel() is just the same thing. The "index" there
> >> is actually the 'Type' value defined in ACPI for the client.
> >
> > The problem is that it's not an index relative to the client, but
> > into an array of the mailbox provide. I only today noticed that both
> > are called 'index' in the source code, which is highly confusing,
> > and the pcc driver should name it 'subspaceid' or similar instead,
> > to minimize the confusion.
> >
> OK.
> 
> Ashwin, would you fix the name and resubmit. Or I do
> s/index/subspace_id/ before committing?
> Arnd, Could I please have your Reviewed/Acked-by?

I'll wait for the new version to dynamically allocate the channels as
suggested by Sudeep.

	Arnd
