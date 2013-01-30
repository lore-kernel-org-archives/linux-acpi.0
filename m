From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Wed, 30 Jan 2013 21:23:39 +0100
Message-ID: <8501010.gC0S6gjEMf@netbook>
References: <CA+icZUXCObXMqVMNLFL58fZCBzo8dv+mqa7Ue_+jVfAdaYG45A@mail.gmail.com> <CA+icZUUUjQTVunewhv+wEsrvyD4FsG9riHa8MRrZdMufyttA4w@mail.gmail.com> <50F31CB9.4010905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:59898 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab3A3UXz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2013 15:23:55 -0500
In-Reply-To: <50F31CB9.4010905@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: sedat.dilek@gmail.com, Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Am Sonntag, 13. Januar 2013, 21:44:41 schrieb Daniel Lezcano:
> On 01/13/2013 09:36 PM, Sedat Dilek wrote:
> > 0001: Refreshed 1-2 as v3 against Linux v3.8-rc3.
> > 0002: v2 of 2-2 applied cleanly after 1-2 was refreshed!
> 
> Hi Sedat,
> 
> for the moment, you should use only the 1/2 because 2/2 (which is an
> optimization) is wrong.

Hi Daniel,

thanks again for this patch, this together with my patch finally fix the bug.
Now I recognized that only my patch was also sent to stable (thanks Rafael), 
yours not. So the bug is not completely fixed in 3.4 and 3.7.

Is there a reason for not sending this to stable, too?

Kind regards,
  Thomas
