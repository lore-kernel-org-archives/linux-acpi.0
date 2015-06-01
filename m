From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of
 acpi_video_unregister in platfrom backlight drivers
Date: Mon, 1 Jun 2015 19:41:03 +0200
Message-ID: <20150601174103.GC87111@vmdeb7>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 01, 2015 at 11:25:05AM +0200, Hans de Goede wrote:
> Hi All,
> 
> I'm working on cleaning up the currently somewhat convoluted logic to
> select which backlight interfaces to register on x86 systems, see:
> http://lists.freedesktop.org/archives/dri-devel/2014-December/074687.html
> 
> For a rought outline (details will change in the actual patch-set).
> 
> These 3 patches are a preparation for that work, as the behavior of the
> current code is not always consistent (it changes depending on module
> loading order in some cases). These 3 patches remove this inconsistency
> which in some cases may result in a behavior change.
> 
> This way the cleanup can have a consistent base to build upon, and I can
> ensure that the cleanup itself does not cause any functional changes.
> 
> I hope to post a v1 of the actual cleanup patch-set in 1-2 weeks.

That will likely mean we miss the 4.2 merge window and will target this for 4.3
(which is fine by me, but just so you know).

-- 
Darren Hart
Intel Open Source Technology Center
