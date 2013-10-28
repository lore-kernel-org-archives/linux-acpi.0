From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Mon, 28 Oct 2013 10:09:11 +0200
Message-ID: <87fvrl7r6g.fsf@intel.com>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<2140073.U60XyxRqVZ@vostro.rjw.lan> <5268D6BB.3010207@intel.com>
	<1382682925.3328.4.camel@ThinkPad-X230.localdomain>
	<526DCFD7.7060002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <526DCFD7.7060002@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: James Hogan <james@albanarts.com>, Mike Galbraith <bitbucket@online.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, linux-acpi@vger.kernel.org, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, Martin Steigerwald <Martin@lichtvoll.de>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?utf-8?Q?J=C3=B6rg?= Otte <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Kevin Smith <thirdwiggin@gmail.com>, Peter Weber <bugs@ttyhoney.com>, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Lennart Poettering <lennart@poettering.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Theodore Tso <tytso@mit.edu>, Ra
List-Id: linux-acpi@vger.kernel.org

On Mon, 28 Oct 2013, Aaron Lu <aaron.lu@intel.com> wrote:
> On 10/25/2013 02:35 PM, Igor Gnatenko wrote:
>> Aaron, add this notebook to list. I've CC'ed owner.
>> And I've tested this patch on my TP X230 (add as Reported-and-Tested me
>> please)
>> +	{
>> +	 .callback = video_set_use_native_backlight,
>> +	 .ident = "Dell Inspiron 7520",
>> +	 .matches = {
>> +		 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +		 DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
>> +		},
>> +	},
>
> Thanks Igor, updated patch follows:
>
> From: Aaron Lu <aaron.lu@intel.com>
> Subject: [PATCH] ACPI / video: Add systems that should favour native backlight
>  interface
>
> Some system's ACPI video backlight control interface is broken and the
> native backlight control interface should be used by default. This patch
> sets the use_native_backlight parameter to true for those systems so
> that video backlight control interface will not be created. To be
> specific, the ThinkPad T430s/X230, Lenovo Yoga 13 and Dell Inspiron 7520
> are added here.
>
> Thinkpad T430s:
> Reported-by: Theodore Tso <tytso@mit.edu>
> Reported-and-tested-by: Peter Weber <bugs@ttyhoney.com>
> Thinkpad X230:
> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Lenovo Yoga 13:
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reported-and-tested-by: Kevin Smith <thirdwiggin@gmail.com>
> Dell Inspiron 7520:
> Reported-by: Renat Ibragimov <ibragimovrinat@mail.ru>
>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/acpi/video.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index d020df5..0a1b030 100644
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

Hi Aaron, it might be beneficial to make use_native_backlight support
three values: force true, force false, and use platform default based on
DMI.

BR,
Jani.


> +
>  static struct dmi_system_id video_dmi_table[] __initdata = {
>  	/*
>  	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
> @@ -504,6 +510,38 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
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
> +	{
> +	 .callback = video_set_use_native_backlight,
> +	 .ident = "Dell Inspiron 7520",
> +	 .matches = {
> +		 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		 DMI_MATCH(DMI_PRODUCT_VERSION, "Inspiron 7520"),
> +		},
> +	},
>  	{}
>  };
>  
> -- 
> 1.8.4.39.ga0d3f10
>

-- 
Jani Nikula, Intel Open Source Technology Center
