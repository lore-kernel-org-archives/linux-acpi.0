From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 0/3] Dock patches
Date: Thu, 7 Dec 2006 17:50:23 -0500
Message-ID: <200612071750.24523.len.brown@intel.com>
References: <20061204144930.ee923959.kristen.c.accardi@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57750 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163470AbWLGWrW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Dec 2006 17:47:22 -0500
In-Reply-To: <20061204144930.ee923959.kristen.c.accardi@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday 04 December 2006 17:49, Kristen Carlson Accardi wrote:
> Hi Len,
> Here are a set of patches for the dock station driver (drivers/acpi/dock).
> One makes the dock station driver also a platform driver.  The second
> adds sysfs entries which will be created under /sys/devices/platform/dock.0
> to allow the user to read the status of the dock station (1 for docked, 0
> undocked) and to initiate an undock request via software by writing to
> the "undock" entry.  The third patch fixes a bug that would prevent
> acpiphp from loading if the dock station was not able to load (on systems
> with no _DCK in the dsdt).

1,2,3 applied.

thanks,
-Len
