From: tytso@mit.edu
Subject: Re: [PATCH 5/5] thinkpad-acpi: improve Kconfig help text
Date: Mon, 28 Dec 2009 08:30:06 -0500
Message-ID: <20091228133006.GD4429@thunk.org>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
 <1261875137-27565-6-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:59547 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbZL1NaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 08:30:15 -0500
Content-Disposition: inline
In-Reply-To: <1261875137-27565-6-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sat, Dec 26, 2009 at 10:52:17PM -0200, Henrique de Moraes Holschuh wrote:
> +	  Extra functionality will be available if the rfkill (CONFIG_RFKILL)
> +	  and/or ALSA (CONFIG_SND) subsystems are available in the kernel.
> +	  Note that if you want ThinkPad-ACPI to be built-in instead of
> +	  modular, ALSA and rfkill will also have to be built-in.

By the way, just as a point of information, Ubuntu Karmic seems to
have some kind of bug with their sound system (I suspect their
Pulseaudio integration) which cases sound to be completely
non-functional if ALSA is built in.  I had to build ALSA as modules in
order for Ubuntu to work correctly.

						- Ted
