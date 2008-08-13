From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Wed, 13 Aug 2008 11:21:10 +0100
Message-ID: <48A2B596.3050401@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk>	<487F58B6.5040309@suse.de>	<487F6D2E.2040501@tuffmail.co.uk>	<487F772C.1070806@suse.de>	<487F9592.1060003@tuffmail.co.uk>	<487F9677.4060001@suse.de> <20080812162854.d6907c95.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:58320 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbYHMKVS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2008 06:21:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1044405nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2008 03:21:15 -0700 (PDT)
In-Reply-To: <20080812162854.d6907c95.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hmh@hmh.eng.br, Maximilian Engelhardt <maxi@daemonizer.de>, linux-stable@vger.kernel.org

Andrew Morton wrote:
> Did this get fixed yet?
>
> I have an patch in -mm which I just restored (I had to tempdrop it
> because the acpi tree was busted for some time).  But it seems to be
> old.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=10919 is marked "resolved"
> but the reporter (Maximilian) seems to think otherwise.  2.6.26.x is,
> afaik, still unfixed, as is 2.6.27-rc.
>   
That's correct.  I think this specific patch should go in 2.6.27 and
2.6.26-stable.  No objections have been raised so far.

I still need this patch to make my brightness and volume control keys
usable in 2.6.27-rc3.  (They auto-repeat fast enough to trigger the
bug).  This is true even after applying the latest patches from bug
10919 (#25 + #27).

I think the 10919 fix makes it harder to reproduce, but it definitely
still happens.  I guess this is because the polling-driven EC
transactions add 1ms delays between each byte.  The slower timings leave
a window where the buggy behaviour of my EC can make a difference.  (It
has been seen to clear the "pending event" bit after a single event is
read, despite having more events pending).

There are more serious consequences of this bug.  After a while it can
confuse the EC enough to cause lockups or reboots during boot, or after
pressing a single hotkey.  This bad state is preserved over reboots,
even into known good kernels.  Fortunately the badness clears when power
is removed for a long enough period.  For a while I was worried that
something had physically burnt out.

Thanks
Alan
