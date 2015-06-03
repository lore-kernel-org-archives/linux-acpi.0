From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of
 acpi_video_unregister in platfrom backlight drivers
Date: Wed, 3 Jun 2015 08:31:00 +0800
Message-ID: <20150603003100.GA3562@aaronlu.sh.intel.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
 <87zj4ie8i9.fsf@intel.com>
 <556D8204.5030904@redhat.com>
 <20150602143350.GB367@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602143350.GB367@aaronlu.sh.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 02, 2015 at 10:33:50PM +0800, Aaron Lu wrote:
> On Tue, Jun 02, 2015 at 12:14:28PM +0200, Hans de Goede wrote:
> > 
> > If this makes sense (*) then the cooling device stuff should maybe moved
> > from the acpi/video.c code to the backlight core code.
> 
> It's just a specific driver that provides thermal capability, no need to
> move to the core code.

I didn't get this when replying and now I think it's doable.

Regards,
Aaron
