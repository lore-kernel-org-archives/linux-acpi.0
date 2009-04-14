From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: drivers for Lenovo 3000 series?
Date: Tue, 14 Apr 2009 20:33:40 +0100
Message-ID: <20090414193340.GA8304@srcf.ucam.org>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com> <1239586069.5564.9.camel@localhost.localdomain> <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44844 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZDNTdp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2009 15:33:45 -0400
Content-Disposition: inline
In-Reply-To: <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@startrek.or.id>
Cc: yakui_zhao <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Apr 15, 2009 at 02:31:35AM +0700, Andika Triwidada wrote:

>  /sys/class/backlight/acpi_video0/brightness exist, I can write and
> the value kept,
> but no effect on display brightness.

Is this an Intel graphics machine? Is the i915 driver loaded?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
