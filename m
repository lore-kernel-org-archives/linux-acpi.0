From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Patch Thinkpad X201T backlight
Date: Fri, 3 Jun 2016 14:16:59 +0800
Message-ID: <20160603061655.GB8618@aaronlu.sh.intel.com>
References: <8737p8aq7k.fsf@quengel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34076 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbcFCGRC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Jun 2016 02:17:02 -0400
Content-Disposition: inline
In-Reply-To: <8737p8aq7k.fsf@quengel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ralf Gerbig <rge@quengel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Sun, May 22, 2016 at 07:23:59PM +0200, Ralf Gerbig wrote:
> Hi,
> 
> the X201 Tablet needs the same treatmant as the X201s,
> otherwise you can't change levels.

I guess /sys/class/backlight/intel_backlight interface doesn't work?

> 
> The patch is against 4.5.5 stable, but should apply to all recent
> kernels.
> 
> Please be gentle, I am neither a programmer nor a developer.
> 
> If you have questions, feel free to ask, but don't expect an answer in
> the next 10 to 20 days (going to hospital).

Hope you are well.
Can you please, when you have time, attach your acpidump?
Perhaps file a new bug @https://bugzilla.kernel.org under
ACPI/Power-Video category and put the acpidump there, thanks.

Regards,
Aaron
