From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] radeon: Expose backlight class device for legacy
	LVDS encoder
Date: Wed, 19 Jan 2011 18:12:13 -0800
Message-ID: <20110119181213.8e301c33.akpm@linux-foundation.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1295033065-13450-3-git-send-email-mjg@redhat.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@vmware.com>, intel-gfx@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 14 Jan 2011 14:24:23 -0500
Matthew Garrett <mjg@redhat.com> wrote:

> From: Michel D__nzer <michel@daenzer.net>
> 
> Allows e.g. power management daemons to control the backlight level. Inspired
> by the corresponding code in radeonfb.
> 
> (Updated to add backlight type and make the connector the parent device - mjg)
> 

x86_64 allmodconfig:

drivers/gpu/drm/radeon/radeon_legacy_encoders.c: In function 'radeon_legacy_lvds_update':
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:64: error: 'struct radeon_encoder_atom_dig' has no member named 'bl_dev'
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:65: error: 'struct radeon_encoder_atom_dig' has no member named 'backlight_level'
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:69: error: 'struct radeon_encoder_lvds' has no member named 'bl_dev'
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:70: error: 'struct radeon_encoder_lvds' has no member named 'backlight_level'
drivers/gpu/drm/radeon/radeon_legacy_encoders.c: In function 'radeon_legacy_lvds_dpms':
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:144: error: 'struct radeon_encoder_atom_dig' has no member named 'dpms_mode'
drivers/gpu/drm/radeon/radeon_legacy_encoders.c:147: error: 'struct radeon_encoder_lvds' has no member named 'dpms_mode'
