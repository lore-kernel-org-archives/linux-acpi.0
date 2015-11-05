From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: video: Add a quirk to force acpi-video backlight on Dell XPS L421X
Date: Fri, 06 Nov 2015 00:43:42 +0100
Message-ID: <2224799.bXtIJ7TFRp@vostro.rjw.lan>
References: <1445869246-29276-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1445869246-29276-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, October 26, 2015 03:20:46 PM Hans de Goede wrote:
> Just like the Dell XPS 15 (L521X) the Dell XPS 14 (L421X) needs to use
> the acpi-video backlight interface rather then the native one for backlight
> control to work, add a quirk for this.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1272633
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

Rafael
