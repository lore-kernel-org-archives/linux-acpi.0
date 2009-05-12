From: Bob Copeland <me@bobcopeland.com>
Subject: Re: acpi/suspend - irq 9: nobody cared
Date: Tue, 12 May 2009 15:26:50 -0400
Message-ID: <b6c5339f0905121226n5e1bd058v3220196728024e55@mail.gmail.com>
References: <20090507105821.GA5864@hash.localnet>
	 <1241747634.3773.129.camel@localhost.localdomain>
	 <200905121301.08524.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:26020 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZELT0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 15:26:49 -0400
In-Reply-To: <200905121301.08524.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: yakui_zhao <yakui.zhao@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, May 12, 2009 at 3:01 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> w=
rote:
> Even if you can't bisect this, can you please open a bugzilla at
> http://bugzilla.kernel.org ? =A0Also, if you can verify that it is
> really a regression since 2.6.29, please drop a note to Rafael,
> who tracks regressions. =A0Plus, he knows all about suspend/resume,
> so maybe he can even fix it :)

Yeah, I'll open a bug report for it.  I'm in the process of bisecting
but there's a boot hang somewhere in the window (2.6.29 <-> .30-rc2)
so it's taking some time.

--=20
Bob Copeland %% www.bobcopeland.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
