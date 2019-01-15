From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred Machine Check subtable
Date: Tue, 15 Jan 2019 19:44:00 +0100
Message-ID: <2404865.SsYJIrglaT@aspire.rjw.lan>
References: <20181112190029.41760-1-Yazen.Ghannam@amd.com> <20190114104350.GH2773@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114104350.GH2773@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "keescook@chromium.org" <keescook@chromium.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, January 14, 2019 11:43:50 AM CET Borislav Petkov wrote:
> On Mon, Nov 12, 2018 at 07:00:55PM +0000, Ghannam, Yazen wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > ACPI 6.2 includes a new definition for a Deferred Machine Check "DMC"
> > subtable.
> > 
> > The definition of this subtable was included in following commit:
> > 
> > c042933df2b1 ("ACPICA: Add support for new HEST subtable")
> > 
> > However, the HEST parsing function was not updated to include this new
> > subtable. Therefore, Linux will fail to parse the HEST on systems that
> > include a DMC entry.
> > 
> > Add the length check for the new DMC subtable so that HEST parsing
> > doesn't fail on systems that include it.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/acpi/apei/hest.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> > index b1e9f81ebeea..0935a0ef37e5 100644
> > --- a/drivers/acpi/apei/hest.c
> > +++ b/drivers/acpi/apei/hest.c
> > @@ -53,6 +53,7 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >  	[ACPI_HEST_TYPE_AER_BRIDGE] = sizeof(struct acpi_hest_aer_bridge),
> >  	[ACPI_HEST_TYPE_GENERIC_ERROR] = sizeof(struct acpi_hest_generic),
> >  	[ACPI_HEST_TYPE_GENERIC_ERROR_V2] = sizeof(struct acpi_hest_generic_v2),
> > +	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
> >  };
> >  
> >  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> > @@ -75,6 +76,11 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> >  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
> >  		len = sizeof(*mc) + mc->num_hardware_banks *
> >  			sizeof(struct acpi_hest_ia_error_bank);
> > +	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
> > +		struct acpi_hest_ia_deferred_check *mc;
> > +		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
> > +		len = sizeof(*mc) + mc->num_hardware_banks *
> > +			sizeof(struct acpi_hest_ia_error_bank);
> >  	}
> >  	BUG_ON(len == -1);
> >  
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Patch applied, thanks!
