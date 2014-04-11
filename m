From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] Default to using the native backlight control
 on Windows 8 systems
Date: Fri, 11 Apr 2014 19:31:02 +0800
Message-ID: <5347D276.4070107@intel.com>
References: <1397160803-24297-1-git-send-email-matthew.garrett@nebula.com> <534759CD.20405@intel.com> <87ppko6sjy.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11200 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbaDKLaV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2014 07:30:21 -0400
In-Reply-To: <87ppko6sjy.fsf@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, dri-devel@lists.freedesktop.org
Cc: linux-acpi@vger.kernel.org

On 04/11/2014 06:58 PM, Jani Nikula wrote:
> On Fri, 11 Apr 2014, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 04/11/2014 04:13 AM, Matthew Garrett wrote:
>>> The list of machines in the "Use native backlight" table is getting longer
>>> and longer, which is a solid indication that we're doing something wrong.
>>> Disable the ACPI backlight interface if the system claims to be Windows 8
>>> or later.
>>
>> And has a native backlight control interface.
> 
> This. One thing we were doing wrong in i915 was unconditionally
> registering a native backlight interface even when it was not
> functional. We can't really know whether that is the case except by
> trusting the VBT, and although we've been let down in the past, trusting
> the VBT on this one is probably a better approximation of the reality
> than assuming it always works. Thus we've queued [1] and [2] for 3.15
> which should help.
> 
> [1] http://cgit.freedesktop.org/drm-intel/commit/?id=39fbc9c8f6765959b55e0b127dd5c57df5a47d67
> [2] http://cgit.freedesktop.org/drm-intel/commit/?id=c675949ec58ca50d5a3ae3c757892f1560f6e896

That's pretty cool :-)

Regards,
Aaron
