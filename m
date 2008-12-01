From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [intel/acpi] backlight
Date: Mon, 1 Dec 2008 08:38:55 +0000
Message-ID: <20081201083855.GB7380@srcf.ucam.org>
References: <1227854824.3477.9.camel@hidalgo> <1228093715.4035.87.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0811302220060.3314@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37299 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYLAIjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 03:39:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811302220060.3314@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, jbarnes@virtuousgeek.org

On Sun, Nov 30, 2008 at 10:28:30PM -0500, Len Brown wrote:

(Cc:ing Jesse)

> in single user mode, i915 is not loaded,
> /sys/class/backlight/acpi_video0 does NOT work
> 
> modprobe of i915 does not change this.

Jesse, are IRQs being delivered to the drm code when X isn't the 
foreground VT? If not, this would seem to need fixing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
