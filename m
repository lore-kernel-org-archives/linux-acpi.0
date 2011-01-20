From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [PATCH 2/5] i915: Add native backlight control
Date: Thu, 20 Jan 2011 15:13:49 -0800
Message-ID: <20110120151349.49cf3ebb.akpm@linux-foundation.org>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-2-git-send-email-mjg@redhat.com>
	<20112101000015@lilem.mirepesht> <20112101004346@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20112101004346@lilem.mirepesht>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Ali Gholami Rudi <aliqrudi@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 21 Jan 2011 00:43:46 +0330
Ali Gholami Rudi <aliqrudi@gmail.com> wrote:

> Ali Gholami Rudi <aliqrudi@gmail.com> wrote:
> > I tried to apply this patch but I get:
> > 
> > 	drivers/gpu/drm/i915/intel_panel.c: In function 'intel_panel_setup_backlight':
> > 	drivers/gpu/drm/i915/intel_panel.c:319: error: 'struct backlight_properties' has no member named 'type'
> > 	drivers/gpu/drm/i915/intel_panel.c:319: error: 'BACKLIGHT_RAW' undeclared (first use in this function)
> > 	drivers/gpu/drm/i915/intel_panel.c:319: error: (Each undeclared identifier is reported only once
> > 	drivers/gpu/drm/i915/intel_panel.c:319: error: for each function it appears in.)
> 
> After applying patch 1/5, the patch applied cleanly.
> Now I can change the brightness using
> /sys/class/backlight/intel_backlight/brightness.
> So it does fix my issue.
> 

So we have a patch ordering issue and the
radeon-expose-backlight-class-device-for-legacy-lvds-encoder.patch
build error.

Matthew, I'll drop 'em all for now.
