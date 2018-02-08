From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels 4.13+
Date: Thu, 08 Feb 2018 20:12:06 +0100
Message-ID: <4333304.2V78SBapX3@aspire.rjw.lan>
References: <bug-197863-190391@https.bugzilla.kernel.org/> <a662d85c-e226-223e-3467-90b651dd291b@intel.com> <CAJZ5v0jN2cQUmwWRQ=Rvb+dQpMg+Q+GuaDtt-X-tXWNThUx-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:45437 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeBHTNu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 14:13:50 -0500
In-Reply-To: <CAJZ5v0jN2cQUmwWRQ=Rvb+dQpMg+Q+GuaDtt-X-tXWNThUx-NQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Markus Demleitner <m@tfiu.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andreas Lindhe <andreas@lindhe.io>, Gjorgji Jankovski <j.gjorgji@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Fernando Chaves <nanochaves@gmail.com>, Tomislav Ivek <tomislav.ivek@gmail.com>, "Denis P." <theoriginal.skullburner@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, February 7, 2018 11:44:15 PM CET Rafael J. Wysocki wrote:
> On Mon, Feb 5, 2018 at 6:06 PM, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
> > On 2/5/2018 3:14 PM, Bjørn Mork wrote:
> >>
> >> "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> writes:
> >>>
> >>> On 2/4/2018 9:28 PM, Bjørn Mork wrote:
> >>>
> >>>> But I do wonder if the attached (completely untested!!) patch makes
> >>>> things any better?
> >>>
> >>> I don't think so, the macro is needed too.
> >>
> >> Doh! Obviously.  Don't know how I managed to miss that.
> >>
> >>> I'll queue up a full revert of 662591461c4b9a1e3b.
> >>
> >> Still with the additional exception for "ec == first_ec"?
> >>
> >
> > No, just a full revert for now.
> 
> That doesn't work, because we made some changes on top of this commit.
> 
> I'll send a patch to try tomorrow.

Below is a patch for the mainline (should be applicable to 4.15.y) to test.
Please let me know if it improves things for you.

The corresponding fix for -stable would still be a full revert of
662591461c4b9a1e3b, but it needs to be fixed in the mainline first.

---
 drivers/acpi/ec.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1927,6 +1927,9 @@ static int acpi_ec_suspend_noirq(struct
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_enter_noirq(ec);
+
 	return 0;
 }
 
@@ -1934,6 +1937,9 @@ static int acpi_ec_resume_noirq(struct d
 {
 	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
 
+	if (acpi_sleep_no_ec_events())
+		acpi_ec_leave_noirq(ec);
+
 	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 	    ec->reference_count >= 1)
 		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);

