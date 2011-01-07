From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
Date: Fri, 7 Jan 2011 22:14:14 +0100
Message-ID: <201101072214.14702.rjw@sisk.pl>
References: <1293403143-11922-1-git-send-email-lenb@kernel.org> <201012272116.23678.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858BFD9B12E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40465 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab1AGVOg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jan 2011 16:14:36 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BFD9B12E@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Friday, January 07, 2011, Moore, Robert wrote:
> Rafael,

Hi,

> Rather than disabling GPE bits one-by-one, I'd like to disable all GPE bits
> in all GPE registers within the block at the time the block is installed,
> by clearing/disabling entire registers with a single write. This would cover
> all the weird hardware and BIOS possibilities in one fell swoop. I believe
> that this was the original behavior of ACPICA.

That's fine by me.  We needed an emergency fix for 2.6.37, hence my patch.

Thanks,
Rafael


> >-----Original Message-----
> >From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >Sent: Monday, December 27, 2010 12:16 PM
> >To: Lin, Ming M; Moore, Robert
> >Cc: Len Brown; linux-acpi@vger.kernel.org; Brown, Len
> >Subject: Re: [PATCH 3/3] ACPI / ACPICA: Disable GPEs during initialization
> >
> >Hi,
> >
> >The patch below is needed in the ACPICA core.
> >
> >On Sunday, December 26, 2010, Len Brown wrote:
> >> From: Rafael J. Wysocki <rjw@sisk.pl>
> >>
> >> GPEs with corresponding _Lxx/_Exx control methods need to be disabled
> >> during initialization in case they have been enabled by the BIOS, so
> >> that they don't fire up until they are enabled by acpi_update_gpes().
> >>
> >> References: https://bugzilla.kernel.org/show_bug.cgi?id=25412
> >> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >> Signed-off-by: Len Brown <len.brown@intel.com>
> >> ---
> >>  drivers/acpi/acpica/evgpeinit.c |    3 +++
> >>  1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/evgpeinit.c
> >b/drivers/acpi/acpica/evgpeinit.c
> >> index 2c7def9..4c8dea5 100644
> >> --- a/drivers/acpi/acpica/evgpeinit.c
> >> +++ b/drivers/acpi/acpica/evgpeinit.c
> >> @@ -408,6 +408,9 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >>  		return_ACPI_STATUS(AE_OK);
> >>  	}
> >>
> >> +	/* Disable the GPE in case it's been enabled already. */
> >> +	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
> >> +
> >>  	/*
> >>  	 * Add the GPE information from above to the gpe_event_info block for
> >>  	 * use during dispatch of this GPE.
> >>
> 
> 
> 

