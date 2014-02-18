From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] ACPI / video: Add systems that should
	favour native backlight interface
Date: Tue, 18 Feb 2014 16:22:27 +0100
Message-ID: <1903167.TtlOFgMB6X@vostro.rjw.lan>
References: <5302F58C.1080001@intel.com> <20140218103442.GS5018@intel.com>
	<s5hfvngy2bh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hfvngy2bh.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Aaron Lu <aaron.lu@intel.com>, Theodore Tso <tytso@mit.edu>, Kevin Smith <thirdwiggin@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Peter Weber <bugs@ttyhoney.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Vladimir Sherenkov <a_12300@mail.ru>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Christensen <christensenthomas@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Lennart Poettering <lennart@poettering.net>, sov.info@mail.ru, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, February 18, 2014 02:31:46 PM Takashi Iwai wrote:
> At Tue, 18 Feb 2014 12:34:42 +0200,
> Mika Westerberg wrote:
> > 
> > On Tue, Feb 18, 2014 at 01:54:20PM +0800, Aaron Lu wrote:
> > > +	{
> > > +	.callback = video_set_use_native_backlight,
> > > +	.ident = "HP EliteBook 2013 models",
> > > +	.matches = {
> > > +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > > +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
> > > +		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
> > > +		},
> > > +	},
> > 
> > I see my device is listed here but the above doesn't really use native
> > backlight because it is still in acpi_osi blacklist. Tried this and I can
> > see both acpi_video0 and intel_backlight listed under /sys/class/backlight.
> > Was this the intention?
> 
> The acpi_osi blacklist commit (2d4054d84224) has to be reverted, as I
> mentioned earlier.  But the revert can be done individually after
> merging this patch.  Rafael, could you care?

Done.  Please check the result in linux-pm.git/linux-next.

Thanks,
Rafael
