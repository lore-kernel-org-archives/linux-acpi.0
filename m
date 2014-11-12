From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] dell-wireless: new driver for dell wireless button for
 Windows 8
Date: Wed, 12 Nov 2014 14:49:45 +0800
Message-ID: <CAJ=jquZU7PiW1+JuVCCcWriLS6+RyBxEb2t==0K2S_ec+_v09w@mail.gmail.com>
References: <1415685685-16953-1-git-send-email-alex.hung@canonical.com>
	<20141111061242.GD56947@vmdeb7>
	<20141111193556.GA18229@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141111193556.GA18229@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Darren Hart <dvhart@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Darren,

Thanks for the comments. I will send a new version with more information.

I believe it is better to have a new driver as it seems OEM can
depreciate and (probably is depreciating) old features and existing
IDs. Especially, a lot of BIOS features are moving to be handled by OS
and userspace applications. I expect to see more simple ACPI devices
to be handled by simple drivers. Combining devices with different
purposes into a single complex driver can be misleading.

Hi Matthew,

Thanks for clarifying it for me.

Cheers,
Alex Hung

On Wed, Nov 12, 2014 at 3:35 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Nov 10, 2014 at 10:12:42PM -0800, Darren Hart wrote:
>
>> As this is ACPI enumerated, does it belong in drivers/platform and not in
>> drivers/acpi?
>
> Yeah, it's still a platform driver rather than a core ACPI driver.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Cheers,
Alex Hung
