From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] [PATCH 1/2] ACPI: Save/Restore NVS area on
 suspend/resume too
Date: Tue, 22 Jun 2010 18:19:52 +0300
Message-ID: <1277219992.4867.2.camel@maxim-laptop>
References: <1275077971.20606.20.camel@maxim-laptop>
	 <1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
	 <20100621155313.GA1447@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:43677 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0FVPT7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2010 11:19:59 -0400
Received: by fg-out-1718.google.com with SMTP id l26so67277fgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2010 08:19:56 -0700 (PDT)
In-Reply-To: <20100621155313.GA1447@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>

On Mon, 2010-06-21 at 17:53 +0200, Pavel Machek wrote: 
> On Fri 2010-05-28 23:22:16, Maxim Levitsky wrote:
> > Although this is clear violation of ACPI spec. the other OS does that...
> >
> 
> So you are adding bugs... what about having them optional, probably
> quirk-driven?

Because like someone (Linus?) said, specs are just paper, nothing more.

The real spec is what windows does.
This is sad but true.


Best regards,
Maxim Levitsky


