From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/9] ACPI: thinkpad-acpi: fix a fan watchdog invocation
Date: Thu, 03 May 2007 19:00:21 +0200
Message-ID: <1178211621.1231.818.camel@queen.suse.de>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
	 <11777220173445-git-send-email-hmh@hmh.eng.br>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:55895 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031348AbXECRAY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 13:00:24 -0400
In-Reply-To: <11777220173445-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Fri, 2007-04-27 at 22:00 -0300, Henrique de Moraes Holschuh wrote:
> The fan control watchdog was being called in one place even when the fan
> control operation had failed.  Fix it.

I didn't have a closer look to the fan watchdog, but it looks like a
ThinkPad specific thing?

IMO we could need some general fan watchdog as fans are breaking away
here and there.
Latest reports came from HPs and FSC models ...

A check whether the fan/power resource is still in the assumed state
or whether something changed it behind the back is a general good idea?

     Thomas


