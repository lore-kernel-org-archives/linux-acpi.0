From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [origin tree build failure] [PATCH] thinkpad-acpi: Fix build
 on !CONFIG_THINKPAD_ACPI_HOTKEY_POLL
Date: Sun, 27 Sep 2009 09:28:28 -0300
Message-ID: <20090927122828.GA24783@khazad-dum.debian.net>
References: <200909260519.n8Q5JrB6016778@hera.kernel.org>
 <20090927075254.GA20847@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46740 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753894AbZI0M22 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Sep 2009 08:28:28 -0400
Content-Disposition: inline
In-Reply-To: <20090927075254.GA20847@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@hera.kernel.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 27 Sep 2009, Ingo Molnar wrote:
> >  drivers/platform/x86/thinkpad_acpi.c    |  632 +++++++++++++++++++---------
> 
> -tip testing found that these changes caused a build failure 
> in drivers/platform/x86/thinkpad_acpi.c when 
> !CONFIG_THINKPAD_ACPI_HOTKEY_POLL - the fix is attached 
> below.

Fixed by a different patch, which will hit mainline soon.  Len already
merged the fix in acpi-test.

BTW, the function _is_ used even when CONFIG_THINKPAD_ACPI_HOTKEY_POLL is
undefined...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
