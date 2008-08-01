From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Debug interface used for error message cleanups
Date: Fri, 1 Aug 2008 08:45:40 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3C3D2CE@orsmsx415.amr.corp.intel.com>
References: <1217449342-20312-1-git-send-email-trenn@suse.de> <200807311159.11276.trenn@suse.de> <1217554944.2969.166.camel@rzhang-dt> <200808011101.29590.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22128 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbYHAPqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Aug 2008 11:46:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200808011101.29590.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

There is currently no corresponding ACPI_DB_EVENTS to go with
ACPI_LV_EVENTS, I will add it.

Meaning, of course, that ACPI_LV_EVENTS is currently unused.


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Friday, August 01, 2008 2:01 AM
>To: Zhang, Rui
>Cc: Moore, Robert; ak@linux.intel.com; lenb@kernel.org; linux-
>acpi@vger.kernel.org
>Subject: Re: Debug interface used for error message cleanups
>
>On Friday 01 August 2008 03:42:24 Zhang Rui wrote:
>> On Thu, 2008-07-31 at 17:59 +0800, Thomas Renninger wrote:
>> > On Wednesday 30 July 2008 22:29:19 Moore, Robert wrote:
>> > > I'm going to go ahead and remove these from ACPICA.
>> > >
>> > > We added an "obsolete" warning in the header file some time ago,
and
>> >
>> > I
>> >
>> > > think the time has come to remove them, especially in light of
these
>> > > patches to Linux.
>> >
>> > Great thanks.
>> > If you are at that, do you think it makes sense to intruduce a GPE
>> > bit?
>> > Just leaving it unused for now?
>> >
>> >
>> > I didn't play with these much yet, Rui, do you think this makes
sense?
>> > The
>> > fact there were several sever problems recently and GPEs possibly
>> > must get debugged by people writting other device drivers who do
not
>> > know
>> > and do not want to know about the output of the other debug flags I
>> > thought
>> > this could make sense.
>>
>> We used to get the GPE debug info by doing this,
>> set debug_layer=0x44, debug_level=0x8800001f
>> We can get the content of GPE Block Register once a GPE is fired.
>> and it's the same for PM1 Event Register and Fixed Events.
>> Is this what you want?
>Ahh yes:
>ACPI_LV_INTERRUPTS              0x08000000
>ACPI_LV_EVENTS                  0x80000000
>
>I think this is what I am looking for.
>Thanks,
>
>        Thomas
