From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Linus 2.6.23-rc1
Date: Mon, 23 Jul 2007 19:57:00 +0300
Message-ID: <200707231957.00794.ismail@pardus.org.tr>
References: <alpine.LFD.0.999.0707221351030.3607@woody.linux-foundation.org> <46A4DACC.3090007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:59639 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755672AbXGWQ4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 12:56:54 -0400
In-Reply-To: <46A4DACC.3090007@googlemail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, len.brown@intel.com

On Monday 23 July 2007 19:43:56 Gabriel C wrote:
> I get some ACPI Exception.
>
> ...
>
> [   33.075429] ACPI Exception (processor_throttling-0084): AE_NOT_FOUND,
> Evaluating _PTC [20070126] [   33.075437] ACPI Exception
> (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126] [  
> 33.075490] ACPI Exception (processor_throttling-0084): AE_NOT_FOUND,
> Evaluating _PTC [20070126] [   33.075497] ACPI Exception
> (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126] [  
> 33.075529] ACPI Exception (processor_throttling-0084): AE_NOT_FOUND,
> Evaluating _PTC [20070126] [   33.075536] ACPI Exception
> (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126] [  
> 33.075563] ACPI Exception (processor_throttling-0084): AE_NOT_FOUND,
> Evaluating _PTC [20070126] [   33.075570] ACPI Exception
> (processor_throttling-0147): AE_NOT_FOUND, Evaluating _TSS [20070126]
>

Same here, I was about to blame my holy Vaio, but latest ACPI merge is to 
blame instead.

Regards,
ismail

-- 
Perfect is the enemy of good
