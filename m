From: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Thu, 30 Apr 2009 20:12:03 +0200
Message-ID: <20090430181203.GC15491@gamma.logic.tuwien.ac.at>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain> <20090423164642.GF495@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain> <20090430180730.GB15491@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:52813 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbZD3SML (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2009 14:12:11 -0400
Content-Disposition: inline
In-Reply-To: <20090430180730.GB15491@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, rui.zhang@intel.com, Keith Packard <keithp@keithp.com>, linux-acpi@vger.kernel.org

On Do, 30 Apr 2009, Norbert Preining wrote:
> So I tried to activate the backlight device to =y but calling make
> config always ended with
> 	CONFIG_BACKLIGHT_CLASS_DEVICE=m

Ok, I guess it needs a 
	select CONFIG_BACKLIGHT_LCD_SUPPORT
	select CONFIG_LCD_CLASS_DEVICE
	select CONFIG_BACKLIGHT_CLASS_DEVICE
or something similar.

Then it compiles.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SAFFRON WALDEN (n.)
To spray the person you are talking to with half-chewed breadcrumbs or
small pieces of whitebait.
			--- Douglas Adams, The Meaning of Liff
