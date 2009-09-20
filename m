From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
	generate events on changes
Date: Sun, 20 Sep 2009 05:15:54 +0100
Message-ID: <20090920041554.GA9229@srcf.ucam.org>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com> <20090919232424.GA15200@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50986 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZITEQH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Sep 2009 00:16:07 -0400
Content-Disposition: inline
In-Reply-To: <20090919232424.GA15200@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Sat, Sep 19, 2009 at 08:24:24PM -0300, Henrique de Moraes Holschuh wrote:

> Should the driver notify of *any* changes, even when the user is hitting the
> "ceiling" or the "floor" and the backlight value didn't really change?

I'd say yes - the user will expect the UI to appear whenever they hit 
the button.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
