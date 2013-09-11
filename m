From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI
	backlight if firmware expects Windows 8
Date: Wed, 11 Sep 2013 11:45:19 +0300
Message-ID: <87hadrycf4.fsf@intel.com>
References: <522D88C3.7000808@intel.com> <5155010.Y1gov7SKhP@vostro.rjw.lan>
	<87eh8wail7.fsf@intel.com> <1889567.vxI8heiC3B@vostro.rjw.lan>
	<20130911013206.GA556@mint-spring.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130911013206.GA556@mint-spring.sh.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Aaron Lu <aaron.lu@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Lee,
	Chun-Yi" <joeyli.kernel@gmail.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Sep 2013, Aaron Lu <aaron.lu@intel.com> wrote:
> It is possible the i915 driver decides not to register a backlight
> interface for the graphics card for some reason(memory allocation failed
> or it knows the native control does not work on this card or whatever),
> so I would prefer let i915 tell ACPI video that it has registered a
> native backlight control interface as Jani has said.
>
> Then together with the video.use_native_backlight, we can register or
> not register ACPI video backlight interface accordingly. Or rather, we
> can simply not register ACPI video backlight interface for Win8 systems
> as long as i915 indicates that it has native backlight control(if the
> native control is broken, i915 should fix it or blacklist it so that
> i915 will not indicate it has native backlight control and ACPI video
> will continue to register its own).
>
> How does this sound?

Sounds good to me.

Before plunging forward, have you observed any difference between the
boot modes? We have reports [1] that the backlight behaviour is
different with UEFI vs. UEFI+CSM or legacy boot. So I'm wondering if the
acpi_gbl_osi_data >= ACPI_OSI_WIN_8 check in patch 2/2 is the whole
story.

Further, if we tell the BIOS we're Windows 8 to use the tested BIOS code
paths, what guarantees do we have of UEFI+CSM or legacy boots working?

BR,
Jani.


[1] https://bugzilla.kernel.org/show_bug.cgi?id=47941#c96


-- 
Jani Nikula, Intel Open Source Technology Center
