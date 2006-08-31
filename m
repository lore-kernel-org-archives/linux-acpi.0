From: Len Brown <len.brown@intel.com>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Wed, 30 Aug 2006 23:03:37 -0400
Message-ID: <200608302303.38458.len.brown@intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com> <200608302253.43784.dtor@insightbb.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:13541 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932067AbWHaDB4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 23:01:56 -0400
In-Reply-To: <200608302253.43784.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Richard Hughes <hughsient@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, desktop_portables@lists.osdl.org

On Wednesday 30 August 2006 22:53, Dmitry Torokhov wrote:

> So... do you want me to make it work with !CONFIG_INPUT or shoudl I just
> add a dependency on INPUT in Kconfig for button driver?

If virtually everybody uses INPUT, then I'm fine with the ACPI button driver simply depending
on CONFIG_INPUT.

If nobody uses ACPI on a system without INPUT, then I don't see why we should
muck up the code to suport a case that nobody will test or use.

thanks,
-Len
