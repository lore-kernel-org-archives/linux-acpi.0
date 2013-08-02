From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: i915 backlight
Date: Fri, 02 Aug 2013 14:00:42 +0800
Message-ID: <51FB4B0A.7060706@intel.com>
References: <20130731162252.GC4724@pd.tnic> <20130731163623.GD4724@pd.tnic> <1419236.138PcnXVBh@vostro.rjw.lan> <20130801080724.GA3448@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:9382 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab3HBGAE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Aug 2013 02:00:04 -0400
In-Reply-To: <20130801080724.GA3448@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 08/01/2013 04:07 PM, Borislav Petkov wrote:
> On Wed, Jul 31, 2013 at 11:16:52PM +0200, Rafael J. Wysocki wrote:
>> Does reverting efaa14c help?
> 
> Nope.
> 
> But see my other reply to Aaron.

Assume you have specified to use intel_backlight in xorg.conf, does
booting with video.brightness_switch_enabled=0 help?

Thanks,
Aaron
