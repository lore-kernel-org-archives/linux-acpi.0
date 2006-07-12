From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPICA regression checker
Date: Wed, 12 Jul 2006 19:01:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F76389@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12439 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932424AbWGLXB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 19:01:29 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: trenn@suse.de, "Moore, Robert" <robert.moore@intel.com>, "Yu, Ling L" <ling.l.yu@intel.com>, linux-acpi@vger.kernel.org


>On Tue, Jul 11, 2006 at 10:01:30PM -0400, Brown, Len wrote:
>
>> Platform ACPI compliance Test
>> This is sorely needed by the community to replace WHQL as the test
>> that vendors run to make sure they got their ACPI 
>> implementation right.
>> It would be a turn-key test that runs on a platform and gives
>> a yes/no on compliance, and diagnostics on failures.
>
>Based on our previous conversations, would this require that platforms 
>reinitialise video themselves?

That is a good example of what should be verified, though I don't
know of an automatic way to test it.

Note that Intel already tells the BIOS vendors this when we tell them
what we think they should do, and we do this in our example designs.
(though 18 months ago that was not the case).

On systems where the vendor cares about Linux enough
to try to get a Centrino Mobile Technology brand, there is a simple
compliance test (not fancy like WHQL) and they will fail if they
don't re-initialize video on resume from S3.

Of course the population of vendors who ship Linux on their laptops
is small, and the subset of them that go for a CMT logo is even smaller.
But those are the ones for us to focus on, it is futile to try to
get a Windows-only vendor to lift a finger to support Linux.

>And, what's probably a harder question, 
>is there any real chance of there being sufficient political will in 
>Intel to make passing this a requirement for claiming ACPI compliance?

My view is that it is impossible for anybody to claim ACPI compliance
because there is no ACPI compliance test to certify it.

I doubt that a test based on Linux would fly in the committee that
defines
the ACPI spec -- particularly since the Linux distributors have not even
bothered to join the commmitte and get a vote at the table.

However, what we really do care about here are the vendors that _do_
care about Linux.  They would be interested in running a Linux based
test if they were available.

-Len

