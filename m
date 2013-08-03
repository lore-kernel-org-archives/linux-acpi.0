From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: video: improve quirk check
Date: Sat, 03 Aug 2013 23:40:40 +0200
Message-ID: <2483450.yz2brWbP8X@vostro.rjw.lan>
References: <1375472229-1563-1-git-send-email-felipe.contreras@gmail.com> <13505759.IqzsRNCUnN@vostro.rjw.lan> <CAMP44s1SobAmSwth+=-pHYN77u-yEumqMfes1w3Bj-8sLTpWng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54220 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3HCVaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Aug 2013 17:30:30 -0400
In-Reply-To: <CAMP44s1SobAmSwth+=-pHYN77u-yEumqMfes1w3Bj-8sLTpWng@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Saturday, August 03, 2013 03:24:16 PM Felipe Contreras wrote:
> On Sat, Aug 3, 2013 at 6:34 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, August 03, 2013 04:14:04 PM Aaron Lu wrote:
> 
> >> Yes, the patch is correct, but I still prefer my own version :-)
> >> https://github.com/aaronlu/linux/commit/0a3d2c5b59caf80ae5bb1ca1fda0f7bf448b38c9
> >>
> >> In case you want to take mine and mine needs refresh, please let me know
> >> and I can do the re-base, thanks.
> >
> > Well, I prefer simpler, unless there's a good reason to use more complicated.
> 
> Note that these are not exclusionary; his patch can be applied on top
> of mine. I don't think his patch is needed though.

OK

Do we still need to revert commit efaa14c if this patch is applied?

Rafael

