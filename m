From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] add access to ACPI docking station UID
Date: Fri, 9 Mar 2007 21:41:00 -0500
Message-ID: <200703092141.00481.lenb@kernel.org>
References: <45DA3083.9080604@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57191 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993161AbXCJCmY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 21:42:24 -0500
In-Reply-To: <45DA3083.9080604@total-knowledge.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>, "Accardi, Kristen" <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org

Applied to acpi-test

thanks,
-Len

On Monday 19 February 2007 18:19, Ilya A. Volynets-Evenbakh wrote:
> It is useful to know whether your laptop is docked or not,
> but it is even more useful to know which docking station it's
> docked to. Attached patch adds "uid" file to sysfs.
> Tested on Dell Latitude D600 with D/Dock.
> Patch is against official 2.6.20 release.
> 
