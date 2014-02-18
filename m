From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] ACPI / video: Add systems that should
 favour native backlight interface
Date: Tue, 18 Feb 2014 12:34:42 +0200
Message-ID: <20140218103442.GS5018@intel.com>
References: <5302F58C.1080001@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <5302F58C.1080001@intel.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Theodore Tso <tytso@mit.edu>, Kevin Smith <thirdwiggin@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Peter Weber <bugs@ttyhoney.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vladimir Sherenkov <a_12300@mail.ru>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Christensen <christensenthomas@gmail.com>, Lennart Poettering <lennart@poettering.net>, sov.info@mail.ru, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 18, 2014 at 01:54:20PM +0800, Aaron Lu wrote:
> +	{
> +	.callback = video_set_use_native_backlight,
> +	.ident = "HP EliteBook 2013 models",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
> +		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
> +		},
> +	},

I see my device is listed here but the above doesn't really use native
backlight because it is still in acpi_osi blacklist. Tried this and I can
see both acpi_video0 and intel_backlight listed under /sys/class/backlight.
Was this the intention?
