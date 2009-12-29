From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] dell-wmi - properly handle errors returned by
 wmi_install_notify_handler()
Date: Tue, 29 Dec 2009 00:56:22 -0800
Message-ID: <20091229085622.GA7805@core.coreip.homeip.net>
References: <20091229083226.13097.22110.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:46593 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbZL2I41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 03:56:27 -0500
Received: by pxi27 with SMTP id 27so6089699pxi.4
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 00:56:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091229083226.13097.22110.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Paul Rolland <rol@as2917.net>

On Tue, Dec 29, 2009 at 12:34:14AM -0800, Dmitry Torokhov wrote:
> wmi_install_notify_handler() retruns ACPI error codes instead of standard
> Exxxx error codes and they should not be propagated unchanged to the upper
> layers.
> 

Ah, ignore me, I see both already fixed in acpi-test...

-- 
Dmitry
