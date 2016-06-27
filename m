From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 3/3] acpi/pmic: Add support for PMIC regs operation region
Date: Mon, 27 Jun 2016 22:29:17 +0200
Message-ID: <2243573.eblG6iu6if@vostro.rjw.lan>
References: <20160624005253.GF83592@worksta> <CAJZ5v0hTvQL1ZdcNtMC24uRtbpavVFq4aqgoPtuEknjo+1QoPw@mail.gmail.com> <20160627143735.GC21398@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160627143735.GC21398@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bin Gao <bin.gao@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, June 27, 2016 05:37:35 PM Heikki Krogerus wrote:
> On Mon, Jun 27, 2016 at 03:25:11PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 27, 2016 at 11:26 AM, Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > Whoa! Hold on!
> > >
> > > On Thu, Jun 23, 2016 at 05:52:53PM -0700, Bin Gao wrote:
> > >> Broxton platform firmware has defined new customized operation regions
> > >> called regs for PMIC chip - regs op region is used to handle the
> > >> PMIC gpio mainly intended for the TYPE-C VBUS and Orientation.
> > >>
> > >> The intel_gpio_ctx  structure is created for the purpose of handling
> > >> the PMIC gpio register read and write.
> > >>
> > >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > >> Signed-off-by: Chandra Sekhar Anagani <chandra.sekhar.anagani@intel.com>
> > >> Signed-off-by: Bin Gao <bin.gao@intel.com>
> > >> ---
> > >> Changes in v4:
> > >>  - various fixes to address Aaron's comments.
> > >> Changes in v3: none
> > >> Changes in v2: none
> > >>  drivers/acpi/pmic/intel_pmic.c | 74 ++++++++++++++++++++++++++++++++++++++++--
> > >>  drivers/acpi/pmic/intel_pmic.h |  5 +++
> > >>  2 files changed, 76 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> > >> index 410e96f..e11d1e0 100644
> > >> --- a/drivers/acpi/pmic/intel_pmic.c
> > >> +++ b/drivers/acpi/pmic/intel_pmic.c
> > >> @@ -21,12 +21,14 @@
> > >>
> > >>  #define PMIC_POWER_OPREGION_ID               0x8d
> > >>  #define PMIC_THERMAL_OPREGION_ID     0x8c
> > >> +#define PMIC_REGS_OPREGION_ID                0x8f
> > >>
> > >>  struct intel_pmic_opregion {
> > >>       struct mutex lock;
> > >>       struct acpi_lpat_conversion_table *lpat_table;
> > >>       struct regmap *regmap;
> > >>       struct intel_pmic_opregion_data *data;
> > >> +     struct pmic_gpio_ctx    ctx;
> > >
> > > What gpio?
> > >
> > >>  };
> > >>
> > >>  static int pmic_get_reg_bit(int address, struct pmic_table *table,
> > >> @@ -204,6 +206,56 @@ static acpi_status intel_pmic_thermal_handler(u32 function,
> > >>       return AE_OK;
> > >>  }
> > >>
> > >> +static acpi_status intel_pmic_gpio_handler(u32 function,
> > >> +     acpi_physical_address address, u32 bits, u64 *value64,
> > >> +             void *handler_context, void *region_context)
> > >
> > > What the heck is this? Why is this suddenly a gpio handler?
> > >
> > > This is handler for an operation region, not some gpio!
> > 
> > OK
> > 
> > What about if I replaced this one with the original one from Felipe you sent?
> 
> That works for me.

OK, let's do that, then.

Thanks,
Rafael
