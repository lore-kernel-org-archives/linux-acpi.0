From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 0/2] acpi: video: Allow forcing native backlight on
 non win8 laptops
Date: Tue, 03 Mar 2015 16:25:48 +0800
Message-ID: <54F5700C.8050200@intel.com>
References: <1425368350-4028-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4108 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbbCCI1G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2015 03:27:06 -0500
In-Reply-To: <1425368350-4028-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On 03/03/2015 03:39 PM, Hans de Goede wrote:
> Hi All,
> 
> I've long wanted to have a way for users to force native-backlight behavior as
> that makes debugging backlight problems a bit easier.

I agree.

> 
> And now a laptop has shown up which needs native backlight behavior for things
> to work, has a non win8 ready bios, and I cannot use a quirk in the vendor
> backlight driver as it implements both the acer-wmi and ideapad-laptop vendor
> interfaces and putting the same quirk in 2 places is just wrong.
> 
> So I've finally written a small patch to allow forcing native-backlight
> behavior as well as a second patch using this to add a quirk for said laptop.
> 
> For now this is just a RFC series as I'm waiting for confirmation from the
> user that this actually fixes things, but I wanted to get the discussion going
> beforehand in case anyone has any objections against the solution I've come
> up with.

See my comments for patch 1.

Thanks,
Aaron

> 
> Regards,
> 
> Hans
> 

