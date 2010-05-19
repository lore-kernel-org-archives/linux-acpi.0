From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] ACPI: Ignore the upper bits of SystemIO addresses
Date: Wed, 19 May 2010 09:31:46 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308587088CD24@orsmsx503.amr.corp.intel.com>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com>
 <201005191018.46799.bjorn.helgaas@hp.com>
 <20100519162702.GB25719@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57372 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab0ESQcG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 12:32:06 -0400
In-Reply-To: <20100519162702.GB25719@srcf.ucam.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

No, ACPICA does not have a WARN_ONCE. In some places, we implement something similar by marking a namespace node, but that's all.

>-----Original Message-----
>From: Matthew Garrett [mailto:mjg@redhat.com]
>Sent: Wednesday, May 19, 2010 9:27 AM
>To: Bjorn Helgaas
>Cc: linux-acpi@vger.kernel.org; Moore, Robert; lenb@kernel.org
>Subject: Re: [PATCH 1/3] ACPI: Ignore the upper bits of SystemIO addresses
>
>On Wed, May 19, 2010 at 10:18:46AM -0600, Bjorn Helgaas wrote:
>
>> I think this is a good idea.  But it makes me a little bit nervous
>> to change addresses supplied by the firmware without any user-visible
>> indication at all.  Is it worth doing a WARN_ONCE() sort of thing
>> when we truncate?
>
>That doesn't seem unreasonable, but do we have anything equivalent to
>that in the acpica code right now?
>
>> I know you experimented quite a bit to confirm that Windows does this
>> sort of masking.  Do you have any notes about that experimentation
>> that would be useful to add to the bugzilla?
>
>Sure. I'll do that.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
