From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [BUGFIX] ACPI, APEI, EINJ Param support is disabled by default
Date: Wed, 20 Jul 2011 09:22:31 -0600
Message-ID: <CAErSpo5-PrZ-do7HqM=2zV8cGibj0bkpFaHtmeRUJmMRZGfTWw@mail.gmail.com>
References: <1311149369-20624-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:30631 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab1GTPWy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2011 11:22:54 -0400
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p6KFMqvU014099
	for <linux-acpi@vger.kernel.org>; Wed, 20 Jul 2011 08:22:53 -0700
Received: from yia13 (yia13.prod.google.com [10.243.65.13])
	by kpbe16.cbf.corp.google.com with ESMTP id p6KFMp5b012054
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 20 Jul 2011 08:22:51 -0700
Received: by yia13 with SMTP id 13so153582yia.28
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jul 2011 08:22:51 -0700 (PDT)
In-Reply-To: <1311149369-20624-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

On Wed, Jul 20, 2011 at 2:09 AM, Huang Ying <ying.huang@intel.com> wrot=
e:
> EINJ parameter support is only usable for some specific BIOS.
> Originally, it is expected to have no harm for BIOS does not support
> it. =A0But now, we found it will cause issue (memory overwriting) for
> some BIOS. =A0So param support is disabled by default and only enable=
d
> when newly added module parameter named "param_extension" is
> explicitly specified.

Adding parameters always makes things harder for users.  Is there any
way this could be done with a whitelist or other automatic mechanism?

Per 6e320ec1d98 (which added EINJ parameter support), parameters are
an unpublished extension and are not part of the ACPI spec.  So if we
pick up an MMIO address from a SET_ERROR_TYPE WRITE_REGISTER
instruction and blindly fill in a structure (undefined by the spec)
presumed to be at that address, it doesn't seem surprising that things
will blow up on BIOSes that don't expect that behavior.  After all,
the spec says to write to a generic address structure (not an
einj_parameter structure) when we interpret the WRITE_REGISTER
instruction (not at the magic time between SET_ERROR_TYPE and
EXECUTE_OPERATION).

If EINJ parameter support is ever added to the ACPI spec, I would
expect a new EINJ flag bit or similar indication to be added at the
same time, so the OS would know when to use it.

Can you add a whitelist of BIOSes that do support this extension?
Maybe you could define a GUID that future platforms could supply so
you wouldn't have to update the whitelist for every new platform that
supports it?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
