From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Fri, 25 Oct 2013 10:35:25 +0400
Message-ID: <1382682925.3328.4.camel@ThinkPad-X230.localdomain>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<2140073.U60XyxRqVZ@vostro.rjw.lan> <5268D6BB.3010207@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <5268D6BB.3010207@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: James Hogan <james@albanarts.com>, Mike Galbraith <bitbucket@online.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, linux-acpi@vger.kernel.org, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, Martin Steigerwald <Martin@lichtvoll.de>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Peter Weber <bugs@ttyhoney.com>, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Lennart Poettering <lennart@poettering.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2013-10-24 at 16:13 +0800, Aaron Lu wrote:
> On 10/16/2013 07:33 AM, Rafael J. Wysocki wrote:
> > On Friday, October 11, 2013 09:27:42 PM Aaron Lu wrote:
> >> v5:
> >> 1 Introduce video.use_native_backlight module parameter and set its
> >>   value to false by default as suggested by Rafael. For Win8 systems
> >>   which have broken ACPI video backlight control, the parameter can be
> >>   set to 1 in kernel cmdline to skip registering ACPI video's backlight
> >>   interface. Due to this change, the acpi_video_verify_backlight_support
> >>   is moved from video_detect.c to video.c - patch 3/4;
> >> 2 Rename bd_list_head and bd_list_mutex in backlight.c to
> >>   backlight_dev_list and backlight_dev_list_mutex as suggested by Rafael
> >>   - patch 1/4.
> >>
> >> v4:
> >> Remove decleration and stub for acpi_video_unregister_backlight in
> >> video.h of patch 2/4 since that function doesn't exist anymore in v3.
> >>
> >> v3:
> >> 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi module;
> >> 2 Remove unnecessary function acpi_video_unregister_backlight introduced
> >>   in patch 2/4 as pointed out by Jani Nikula.
> >>
> >> v2:
> >> v1 has the subject of "Rework ACPI video driver" and is posted here:
> >> http://lkml.org/lkml/2013/9/9/74
> >> Since the objective is really to fix Win8 backlight issues, I changed
> >> the subject in this version, sorry about that.
> >>
> >> This patchset has four patches, the first introduced a new API named
> >> backlight_device_registered in backlight layer that can be used for
> >> backlight interface provider module to check if a specific type backlight
> >> interface has been registered, see changelog for patch 1/4 for details.
> >> Then patch 2/4 does the cleanup to sepeate the backlight control and
> >> event delivery functionality in the ACPI video module and patch 3/4
> >> solves some Win8 backlight control problems by avoiding register ACPI
> >> video's backlight interface if:
> >> 1 Kernel cmdline option acpi_backlight=video is not given;
> >> 2 This is a Win8 system;
> >> 3 Native backlight control interface exists.
> >> Patch 4/4 fixes some problems in thinkpad-acpi module.
> >>
> >> Technically, patch 2/4 is not required to fix the issue here. So if you
> >> think it is not necessary, I can remove it from the series.
> >>
> >> Aaron Lu (4):
> >>   backlight: introduce backlight_device_registered
> >>   ACPI / video: seperate backlight control and event interface
> >>   ACPI / video: Do not register backlight if win8 and native interface
> >>     exists
> >>   thinkpad-acpi: fix handle locate for video and query of _BCL
> >>
> >>  drivers/acpi/internal.h              |   4 +-
> >>  drivers/acpi/video.c                 | 457 ++++++++++++++++++++---------------
> >>  drivers/acpi/video_detect.c          |   4 +-
> >>  drivers/platform/x86/thinkpad_acpi.c |  31 ++-
> >>  drivers/video/backlight/backlight.c  |  31 +++
> >>  include/linux/backlight.h            |   4 +
> >>  6 files changed, 326 insertions(+), 205 deletions(-)
> > 
> > I've added this series to my queue for 3.13.
> > 
> > Since the next step will be to introduce a list of systems that need
> > video.use_native_backlight=1 *and* don't break in that configuration, I don't
> > see much point adding another Kconfig option for the default.
> > 
> > Hopefully, in the future we'll be able to fix the problems causing
> > video.use_native_backlight=1 to fail of the systems where it fails and then
> > we'll be able to make that the default behavior and drop the option altogether.
> 
> I've prepared a patch(at the end of the mail) to set use_native_backlight
> by default for some systems. There are 3 systems currently that I'm
> kind of sure that should be added:
> 
> The ThinkPad T430s and X230 is:
> Reported-by: Theodore Tso <tytso@mit.edu>
> Reported-and-tested-by: Peter Weber <bugs@ttyhoney.com>
> Reported-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> 
> The Lenovo Yoga is:
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reference: https://lkml.org/lkml/2013/10/13/178
> 
> From: Aaron Lu <aaron.lu@intel.com>
> Subject: [PATCH] ACPI / video: Add systems that should favor native backlight
>  interface
> 
> Some system's ACPI video backlight control interface is broken and the
> native backlight control interface should be used by default. This patch
> sets the use_native_backlight parameter to true for those systems so
> that video backlight control interface will not be created. To be
> clear, the ThinkPad T430s/X230 and Lenovo Yoga 13 are added here.
> 
> Reported-by: Theodore Tso <tytso@mit.edu>
> Reported-and-tested-by: Peter Weber <bugs@ttyhoney.com>
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reported-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/acpi/video.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index d020df5..9a80a94 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -412,6 +412,12 @@ static int video_ignore_initial_backlight(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init video_set_use_native_backlight(const struct dmi_system_id *d)
> +{
> +	use_native_backlight = true;
> +	return 0;
> +}
> +
>  static struct dmi_system_id video_dmi_table[] __initdata = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -504,6 +510,30 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion m4 Notebook PC"),
>  		},
>  	},
> +	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "ThinkPad T430s",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
> +		},
> +	},
> +	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "ThinkPad X230",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
> +		},
> +	},
> +	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "Lenovo Yoga 13",
> +	 .matches = {
> +		 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		 DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo IdeaPad Yoga 13"),
> +		},
> +	},
>  	{}
>  };
>  
Aaron, add this notebook to list. I've CC'ed owner.
And I've tested this patch on my TP X230 (add as Reported-and-Tested me
please)
+	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "Dell Inspiron 7520",
+	 .matches = {
+		 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		 DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
+		},
+	},

-- 
Igor Gnatenko
Fedora release 20 (Heisenbug)
Linux 3.11.6-300.fc20.x86_64
