From: Thomas Renninger <trenn@suse.de>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPIdrivers - version 4
Date: Tue, 5 Aug 2008 11:13:42 +0200
Message-ID: <200808051113.44533.trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <20080805000151.GJ24927@khazad-dum.debian.net> <1217915753.8381.9.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53489 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758980AbYHEJNs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Aug 2008 05:13:48 -0400
In-Reply-To: <1217915753.8381.9.camel@hidalgo>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Tuesday 05 August 2008 07:55:53 Yves-Alexis Perez wrote:
...
> Anyway, I wasn't yet able to test Matthew's patches, they're not yet in
> drm-2.6/master.
This should definitely be the next step.
If this fails we should still try to dig there why it is not working.

I agree, that only if we heavily get stuck there it would make sense
to look at thinkpad_acpi to enable/workaround backlight switching with
IGD devices.

     Thomas




