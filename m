From: Matthias Welwarsky <matze@welwarsky.de>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Sun, 29 Mar 2009 13:52:42 +0200
Message-ID: <200903291352.43125.matze@welwarsky.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <6cc056bc31ea9910afb01adc0848bb6ae68e0205.1238214620.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:1314
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZC2Lws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 07:52:48 -0400
In-Reply-To: <6cc056bc31ea9910afb01adc0848bb6ae68e0205.1238214620.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 05:31:33 you wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> Newer Vaios provide a full featured rfkill implementation via their
> platform methods. Add support for enumerating the available devices and
> providing rfkill access to them. Support for the physical kill switch is
> added, with the devices moving into the HARD_BLOCKED state when toggled.

Bug: If you insert the module with hardware kill switch enabled, it cannot be 
disabled any more, i.e. despite operating the hardware kill switch, devices 
will not become enabled.

Any hint how I could debug this?

regards,
	matthias

PS: Len, sorry for the bogus message, hit the wrong reply button

