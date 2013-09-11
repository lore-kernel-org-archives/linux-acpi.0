From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 2/2] ACPI / video / i915: Remove ACPI
 backlight if firmware expects Windows 8
Date: Wed, 11 Sep 2013 10:30:17 +0000
Message-ID: <1378895417.945.2.camel@x230.lan>
References: <522D88C3.7000808@intel.com> <5155010.Y1gov7SKhP@vostro.rjw.lan>
	<87eh8wail7.fsf@intel.com> <1889567.vxI8heiC3B@vostro.rjw.lan>
	<20130911013206.GA556@mint-spring.sh.intel.com>
	<87hadrycf4.fsf@intel.com>
	<1378889140.945.0.camel@x230.lan> <87d2ofy7li.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <87d2ofy7li.fsf@intel.com>
Content-Language: en-US
Content-ID: <4847B66A956DC249A340F90BA1CD9519@namprd05.prod.outlook.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Seth Forshee <seth.forshee@canonical.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Lee,
	Chun-Yi" <joeyli.kernel@gmail.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Lee Chun-Yi <jlee@novell.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-09-11 at 13:29 +0300, Jani Nikula wrote:
> On Wed, 11 Sep 2013, Matthew Garrett <matthew.garrett@nebula.com> wrote:
> > On Wed, 2013-09-11 at 11:45 +0300, Jani Nikula wrote:
> >
> >> Before plunging forward, have you observed any difference between the
> >> boot modes? We have reports [1] that the backlight behaviour is
> >> different with UEFI vs. UEFI+CSM or legacy boot. So I'm wondering if the
> >> acpi_gbl_osi_data >= ACPI_OSI_WIN_8 check in patch 2/2 is the whole
> >> story.
> >> 
> >> Further, if we tell the BIOS we're Windows 8 to use the tested BIOS code
> >> paths, what guarantees do we have of UEFI+CSM or legacy boots working?
> >
> > We have no evidence of Windows behaving differently based on the exposed
> > firmware type.
> 
> By "behaving differently", do you mean internally adapting to the boot
> mode, or exhibiting different behaviour to the user?

As far as backlight control goes, both.

> We have evidence of the firmware behaving differently (VBT, backlight)
> based on the boot mode, all else being equal. We don't adapt to that,
> and we fail. I don't know if we should adapt, or do things differently
> altogether. I don't even know if Windows 8 works on all boot modes on
> the machines in question.

Sure, but Windows knows nothing about VBT or opregion-backed backlight
control. That's up to the Intel driver.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
