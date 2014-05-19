From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] acpi-video: Don't register acpi_video_resume notifier without backlight devices
Date: Tue, 20 May 2014 00:59:53 +0200
Message-ID: <2307360.DSLu5vT7ji@vostro.rjw.lan>
References: <1400152956-9053-1-git-send-email-hdegoede@redhat.com> <1400152956-9053-2-git-send-email-hdegoede@redhat.com> <53757730.4080101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <53757730.4080101@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Massimiliano <massi.ergosum@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, May 16, 2014 10:25:52 AM Aaron Lu wrote:
> On 05/15/2014 07:22 PM, Hans de Goede wrote:
> > If we're not going to be registering any backlight devices then
> > acpi_video_resume is always nop, so don't register it in that case.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Queued up for 3.16, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
