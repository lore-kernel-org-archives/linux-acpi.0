From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] ACPI: Leave Bus Master Arbitration enabled for suspend/resume
Date: Sun, 8 Jul 2012 22:48:44 +0200
Message-ID: <201207082248.44600.rjw@sisk.pl>
References: <op.wg3en6ij6g6bxc@localhost.localdomain> <201207082208.19664.rjw@sisk.pl> <94F2FBAB4432B54E8AACC7DFDE6C92E346B0A51E@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:58402 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab2GHUnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Jul 2012 16:43:14 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E346B0A51E@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Octavio Alvarez <alvarezp@alvarezp.com>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, Shaohua Li <shli@kernel.org>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Sunday, July 08, 2012, Moore, Robert wrote:
> > Bob, I think we should incorporate this into ACPICA, shouldn't we?
> > 
> > Rafael
> 
> We are looking at it. Probably one of the Linux/ACPICA divergences that end
> up causing us grief.

Well, in this particular case it seems that what Linux did before commit
2feec47d4c5f (ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl
registers) was actually correct, though.

Thanks,
Rafael


> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Sunday, July 08, 2012 1:08 PM
> > To: Jonathan Nieder; Moore, Robert
> > Cc: Octavio Alvarez; Adrian Knoth; Shaohua Li; Brown, Len; linux-
> > acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] ACPI: Leave Bus Master Arbitration enabled for
> > suspend/resume
> > 
> > On Sunday, July 08, 2012, Jonathan Nieder wrote:
> > > This is an old suspend/resume lockup fix:
> > >
> > > 	commit 2780cc4660e1
> > > 	Author: Len Brown <len.brown@intel.com>
> > > 	Date:   Thu Dec 23 13:43:30 2004 -0500
> > >
> > > 	    [ACPI] Fix suspend/resume lockup issue
> > > 	    by leaving Bus Master Arbitration enabled.
> > > 	    The ACPI spec mandates it be disabled only for C3.
> > >
> > > 	    http://bugzilla.kernel.org/show_bug.cgi?id=3599
> > >
> > > 	    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
> > > 	    Signed-off-by: Len Brown <len.brown@intel.com>
> > >
> > > The bug snuck back in in commit 2feec47d4c5f (ACPICA: ACPI 5: Support
> > > for new FADT SleepStatus, SleepControl registers, 2012-02-14),
> > > presumably by copy/pasting a copy of the code without that fix for
> > the
> > > legacy case.
> > >
> > > On affected machines, after that commit, the machine locks up hard on
> > > resume from suspend.  The same fix as seven years ago still works.
> > >
> > > Addresses <https://bugzilla.kernel.org/show_bug.cgi?id=43641>.
> > >
> > > Reported-bisected-and-tested-by: Octavio Alvarez
> > > <alvarezp@alvarezp.com>
> > > Reported-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> > > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > > Cc: <stable@vger.kernel.org> # 3.4
> > > ---
> > > Rafael J. Wysocki wrote:
> > >
> > > > Can you please repost it with _both_ the changelog and the patch?
> > >
> > > Here you go.  Sorry about that.
> > 
> > Thanks!
> > 
> > Applied to the linux-next branch of the linux-pm.git tree.
> > 
> > I think I'll push it for v3.6, since the bug is serious and is a
> > regression.
> > 
> > Bob, I think we should incorporate this into ACPICA, shouldn't we?
> > 
> > Rafael
> > 
> > 
> > >  drivers/acpi/acpica/hwsleep.c |   22 ----------------------
> > >  1 file changed, 22 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/hwsleep.c
> > > b/drivers/acpi/acpica/hwsleep.c index 0ed85cac3231..615996a36bed
> > > 100644
> > > --- a/drivers/acpi/acpica/hwsleep.c
> > > +++ b/drivers/acpi/acpica/hwsleep.c
> > > @@ -95,18 +95,6 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state,
> > u8 flags)
> > >  		return_ACPI_STATUS(status);
> > >  	}
> > >
> > > -	if (sleep_state != ACPI_STATE_S5) {
> > > -		/*
> > > -		 * Disable BM arbitration. This feature is contained within
> > an
> > > -		 * optional register (PM2 Control), so ignore a BAD_ADDRESS
> > > -		 * exception.
> > > -		 */
> > > -		status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE,
> > 1);
> > > -		if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
> > > -			return_ACPI_STATUS(status);
> > > -		}
> > > -	}
> > > -
> > >  	/*
> > >  	 * 1) Disable/Clear all GPEs
> > >  	 * 2) Enable all wakeup GPEs
> > > @@ -364,16 +352,6 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state,
> > u8 flags)
> > >  				    [ACPI_EVENT_POWER_BUTTON].
> > >  				    status_register_id, ACPI_CLEAR_STATUS);
> > >
> > > -	/*
> > > -	 * Enable BM arbitration. This feature is contained within an
> > > -	 * optional register (PM2 Control), so ignore a BAD_ADDRESS
> > > -	 * exception.
> > > -	 */
> > > -	status = acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
> > > -	if (ACPI_FAILURE(status) && (status != AE_BAD_ADDRESS)) {
> > > -		return_ACPI_STATUS(status);
> > > -	}
> > > -
> > >  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST,
> > ACPI_SST_WORKING);
> > >  	return_ACPI_STATUS(status);
> > >  }
> > >
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 

