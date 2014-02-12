From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm/i915/opregion: work around buggy
 firmware that provides 8+ output devices
Date: Wed, 12 Feb 2014 10:31:56 +0000
Message-ID: <20140212103156.GC5298@nuc-i3427.alporthouse.com>
References: <52FAE504.8020001@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <52FAE504.8020001@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2014 at 11:05:40AM +0800, Aaron Lu wrote:
> The ACPI table on ASUS UX302LA has more than 8 output devices under the
> graphics controller device node. The problem is, the real active output
> device, the LCD panel, is listed the last. The result is, the LCD's
> device id doesn't get recorded in the active device list CADL array and
> when the _DCS control method for the LCD device is executed, it returns
> 0x1d, meaning it is not active. This affects the hotkey delivery ASL
> code that will not deliver a notification if the output device is not
> active on backlight hotkey press.
> 
> I don't see a clean way to solve this problem since the operation region
> spec doesn't allow more than 8 output devices so we have no way of
> storing all these output devices. The fact that output devices that have
> _BCM control method usually means they have a higher possibility of being
> used than those who don't made me choose a simple way to work around
> the buggy firmware by replacing the last entry in CADL array with the one
> that has _BCM control method. There is no specific reason why the last
> entry is picked instead of others.

Another possibility is that the connector list is in rough priority
order so might be useful for sorting the CADL array.

Since the CADL should only be a list of currently active devices, we
could just bite the bullet and repopulate it correctly after every
setcrtc.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
