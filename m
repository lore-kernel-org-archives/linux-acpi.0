From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 1/2] ACPI: Save/Restore NVS area on
 suspend/resume too
Date: Mon, 21 Jun 2010 17:53:15 +0200
Message-ID: <20100621155313.GA1447@ucw.cz>
References: <1275077971.20606.20.camel@maxim-laptop>
 <1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:49436 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755485Ab0FVLJQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jun 2010 07:09:16 -0400
Content-Disposition: inline
In-Reply-To: <1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>

On Fri 2010-05-28 23:22:16, Maxim Levitsky wrote:
> Although this is clear violation of ACPI spec. the other OS does that...
>

So you are adding bugs... what about having them optional, probably
quirk-driven?
									Pavel
 
> Since other OS restores this region some BIOSes rely on this,
> and won't resume the system second time
> 
> see: https://bugzilla.kernel.org/show_bug.cgi?id=13931

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
