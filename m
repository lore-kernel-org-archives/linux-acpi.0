From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch for 2.6.34? 1/1] acpi: video: fix acpi_backlight=video
Date: Fri, 14 May 2010 15:34:37 +0200
Message-ID: <201005141534.37456.trenn@suse.de>
References: <201005122233.o4CMXvi7024758@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53605 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab0ENNeL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 May 2010 09:34:11 -0400
In-Reply-To: <201005122233.o4CMXvi7024758@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org

On Thursday 13 May 2010 00:33:57 akpm@linux-foundation.org wrote:
> From: Kamal Mostafa <kamal@canonical.com>
> 
> Make "acpi_backlight=video" param enable
> ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
> as intended, instead of incorrectly enabling video output switching.

This one is correct and absolutely safe.

Signed-off-by: Thomas Renninger <trenn@suse.de>

      Thomas
