From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PATCH] backlight event support enhancements
Date: Mon, 21 Sep 2009 00:41:42 +0100
Message-ID: <1253490102.564.3.camel@ted>
References: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:54271 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbZITX7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 19:59:04 -0400
In-Reply-To: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sun, 2009-09-20 at 14:44 -0300, Henrique de Moraes Holschuh wrote:
> This two-patch patchset adds poll() support to Matthew's backlight event
> work, and also adds backlight event support for thinkpad-acpi.
> 
> The thinkpad-acpi changes depend on a patchset I just sent to Len Brown
> for merging in acpi-test.
> 
> Is there any timeframe for the backlight event support to be sent to
> mainline?

I'm going to try and get the event patches in this merge window if I
can. I'm going to have intermittent internet access for a few days but I
will send a pull request for the backlight tree over that time period. 

Whats the timeframe for acpi-test merging?

Cheers,

Richard


-- 
Richard Purdie
Intel Open Source Technology Centre

