From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] ACPI/EC: Cleanup coding style.
Date: Wed, 22 Oct 2014 16:10:02 +0200
Message-ID: <1841961.yVL2R73toT@vostro.rjw.lan>
References: <cover.1413267704.git.lv.zheng@intel.com> <1AE640813FDE7649BE1B193DEA596E8802685650@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E8802685679@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49629 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751483AbaJVNtf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2014 09:49:35 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802685679@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, October 22, 2014 05:59:59 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng, Lv
> > Sent: Wednesday, October 22, 2014 1:06 PM
> > 
> > Hi, Rafael
> > 
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > Sent: Tuesday, October 21, 2014 9:29 PM
> > >
> > > On Tuesday, October 14, 2014 02:24:01 PM Lv Zheng wrote:
> > > > This patch cleans up the following coding style issues that are detected by
> > > > scripts/checkpatch.pl:
> > > >  ERROR: code indent should use tabs where possible
> > > >  ERROR: "foo * bar" should be "foo *bar"
> > > >  WARNING: Missing a blank line after declarations
> > > >  WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > >  WARNING: void function return statements are not generally useful
> > > >  WARNING: else is not generally useful after a break or return
> > > >  WARNING: break is not useful after a goto or return
> > > >  WARNING: braces {} are not necessary for single statement blocks
> > > >  WARNING: line over 80 characters
> > > >  WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> > > > No functional changes.
> > > >
> > > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > > ---
> > > >  drivers/acpi/ec.c |   58 ++++++++++++++++++++++++++++-------------------------
> > > >  1 file changed, 31 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > > > index d993df6..5f4e6c6 100644
> > > > --- a/drivers/acpi/ec.c
> > > > +++ b/drivers/acpi/ec.c
> > > > @@ -128,12 +128,13 @@ static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
> > > >  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
> > > >
> > > >  /* --------------------------------------------------------------------------
> > > > -                             Transaction Management
> > > > -   -------------------------------------------------------------------------- */
> > > > + *                           Transaction Management
> > > > + * -------------------------------------------------------------------------- */
> > > >
> > > >  static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
> > > >  {
> > > >  	u8 x = inb(ec->command_addr);
> > > > +
> > > >  	pr_debug("EC_SC(R) = 0x%2.2x "
> > > >  		 "SCI_EVT=%d BURST=%d CMD=%d IBF=%d OBF=%d\n",
> > > >  		 x,
> > > > @@ -148,6 +149,7 @@ static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
> > > >  static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
> > > >  {
> > > >  	u8 x = inb(ec->data_addr);
> > > > +
> > > >  	pr_debug("EC_DATA(R) = 0x%2.2x\n", x);
> > > >  	return x;
> > > >  }
> > > > @@ -189,6 +191,7 @@ static int ec_transaction_completed(struct acpi_ec *ec)
> > > >  {
> > > >  	unsigned long flags;
> > > >  	int ret = 0;
> > > > +
> > > >  	spin_lock_irqsave(&ec->lock, flags);
> > > >  	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE))
> > > >  		ret = 1;
> > > > @@ -288,6 +291,7 @@ static int ec_poll(struct acpi_ec *ec)
> > > >  {
> > > >  	unsigned long flags;
> > > >  	int repeat = 5; /* number of command restarts */
> > > > +
> > > >  	while (repeat--) {
> > > >  		unsigned long delay = jiffies +
> > > >  			msecs_to_jiffies(ec_delay);
> > > > @@ -320,6 +324,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
> > > >  {
> > > >  	unsigned long tmp;
> > > >  	int ret = 0;
> > > > +
> > > >  	if (EC_FLAGS_MSI)
> > > >  		udelay(ACPI_EC_MSI_UDELAY);
> > > >  	/* start transaction */
> > > > @@ -347,6 +352,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
> > > >  {
> > > >  	int status;
> > > >  	u32 glk;
> > > > +
> > > >  	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
> > > >  		return -EINVAL;
> > > >  	if (t->rdata)
> > > > @@ -374,7 +380,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
> > > >  	/* check if we received SCI during transaction */
> > > >  	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
> > > >  	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> > > > -		msleep(1);
> > > > +		msleep(20);
> > >
> > > This is a functional change, so I've dropped it from the patch (it didn't apply for
> > > me anyway).  Please send it as a separate patch with an appropriate changelog if
> > > you want to make it.
> > 
> > OK. I'll split this as a separate patch.
> 
> I saw the rest of the diff blocks are merged.
> So since no strict requirement on doing this besides of the checkpatch.pl warning.
> I'll stop doing this.

OK, thanks.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
