From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI video: fix a poor error message
Date: Tue, 17 Aug 2010 08:46:13 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AE61F4BA@orsmsx503.amr.corp.intel.com>
References: <1282012975.5181.16.camel@rui>
 <20100817133458.GA22699@srcf.ucam.org>
 <4911F71203A09E4D9981D27F9D830858AE61F464@orsmsx503.amr.corp.intel.com>
 <20100817152755.GA25805@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6553 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab0HQPqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Aug 2010 11:46:25 -0400
In-Reply-To: <20100817152755.GA25805@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>

I like this much better. Probably should drop the colon, so it looks something like:

[Firmware Bug]: ACPI: No _BQC method, cannot determine initial brightness

I leave the question as to whether this is an actual firmware bug to you guys.

Bob

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg59@srcf.ucam.org]
>Sent: Tuesday, August 17, 2010 8:28 AM
>To: Moore, Robert
>Cc: Zhang, Rui; Brown, Len; linux-acpi@vger.kernel.org; Thomas Renninger
>Subject: Re: [PATCH] ACPI video: fix a poor error message
>
>On Tue, Aug 17, 2010 at 08:24:25AM -0700, Moore, Robert wrote:
>> Do we agree that the original message is unclear?
>>
>> I'm not even sure that ACPI requires this method.
>
>Indeed, it's not actually on the list of required methods.
>
>> Perhaps the message should describe what won't happen because of the
>missing _BQC method.
>
>Perhaps just "No _BQC method: Unable to determine initial brightness"?
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
