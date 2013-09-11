From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI
 backlight if firmware expects Windows 8
Date: Wed, 11 Sep 2013 11:09:25 +0200
Message-ID: <1378890565.4179.2.camel@oban>
References: <522D88C3.7000808@intel.com> <5155010.Y1gov7SKhP@vostro.rjw.lan>
	<87eh8wail7.fsf@intel.com> <1889567.vxI8heiC3B@vostro.rjw.lan>
	<20130911013206.GA556@mint-spring.sh.intel.com>
	<87hadrycf4.fsf@intel.com> <1378889140.945.0.camel@x230.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1378889140.945.0.camel@x230.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Seth Forshee <seth.forshee@canonical.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Lee,
	Chun-Yi" <joeyli.kernel@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On mer., 2013-09-11 at 08:45 +0000, Matthew Garrett wrote:
> On Wed, 2013-09-11 at 11:45 +0300, Jani Nikula wrote:
> 
> > Before plunging forward, have you observed any difference between the
> > boot modes? We have reports [1] that the backlight behaviour is
> > different with UEFI vs. UEFI+CSM or legacy boot. So I'm wondering if the
> > acpi_gbl_osi_data >= ACPI_OSI_WIN_8 check in patch 2/2 is the whole
> > story.
> > 
> > Further, if we tell the BIOS we're Windows 8 to use the tested BIOS code
> > paths, what guarantees do we have of UEFI+CSM or legacy boots working?
> 
> We have no evidence of Windows behaving differently based on the exposed
> firmware type.
> 
I do have an X230 which boots fine using pure UEFI or UEFI+CSM (and I
guess I can try booting it with a grml for pure legacy), so I can do
tests if needed.

Regards,
-- 
Yves-Alexis
