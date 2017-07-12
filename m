From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 12 Jul 2017 23:21:30 +0200
Message-ID: <2256250.NXlXG0Wxqi@aspire.rjw.lan>
References: <1495221578-10612-1-git-send-email-pprakash@codeaurora.org> <CAJZ5v0is=AjNUfMdD4MgoSttgZh_jU80Cm9FPJBo8QqryOdKJw@mail.gmail.com> <9ab90c21-6bae-c586-8755-88714f0339f7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47290 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752363AbdGLV3N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jul 2017 17:29:13 -0400
In-Reply-To: <9ab90c21-6bae-c586-8755-88714f0339f7@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Monday, July 10, 2017 04:47:00 PM Prakash, Prashanth wrote:
> Hi Rafael,
> 
> On 6/27/2017 5:59 PM, Rafael J. Wysocki wrote:
> > On Fri, May 19, 2017 at 9:19 PM, Prashanth Prakash
> > <pprakash@codeaurora.org> wrote:
> >> Add support to expose idle statistics maintained by platform to
> >> userspace via sysfs in addition to other data of interest from
> >> each LPI(Low Power Idle) state.
> >>
> >> LPI described in section 8.4.4 of ACPI spec 6.1 provides different
> >> methods to obtain idle statistics maintained by the platform. These
> >> show a granular view of how each of the LPI state is being used at
> >> different level of hierarchy. sysfs data is exposed at each level in
> >> the hierarchy by creating a directory named 'lpi' at each level and
> >> the LPI state information is presented under it. Below is the
> >> representation of LPI information at one such level in the hierarchy
> >>
> >> .../ACPI00XX: XX/lpi
> >>         |-> state0
> >>         |       |-> desc
> >>         |       |-> time
> >>         |       |-> usage
> >>         |       |-> latency
> >>         |       |-> min_residency
> >>         |
> >>         <<more states>>
> >>
> >> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
> >>
> >> stateX contains information related to a specific LPI state defined
> >> in the LPI ACPI tables.
> > That needs to be documented under Documentation/ABI/.
> Sure, I will create a patch updating the ABI documentation.

No, please update the documentation in this patch.

> >> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> >> index c1ba00f..b99b84b 100644
> >> --- a/include/acpi/processor.h
> >> +++ b/include/acpi/processor.h
> >> @@ -79,6 +79,19 @@ struct acpi_lpi_state {
> >>         u8 index;
> >>         u8 entry_method;
> >>         char desc[ACPI_CX_DESC_LEN];
> >> +       struct acpi_generic_address res_cntr;
> >> +       struct acpi_generic_address usage_cntr;
> > Is there any reason why these two cannot be of type struct acpi_power_register?
> acpi_read() API required reference to acpi_generic_address (our only use case is to read the
> register), so keeping this data in acpi_generic_address makes the code little simpler.

OK, fair enough.

Thanks,
Rafael

