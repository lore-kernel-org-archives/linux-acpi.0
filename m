From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: aer_inject vs. apei/einj
Date: Wed, 17 Feb 2016 11:03:31 -0600
Message-ID: <CAErSpo5s9JnjaPfsQreWeXTeu7_j-hY0+jVJvyzFYhVeJyazsw@mail.gmail.com>
References: <20160217143306.6340c6cf@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36192 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030207AbcBQRDw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 12:03:52 -0500
Received: by mail-yk0-f179.google.com with SMTP id z7so9328850yka.3
        for <linux-acpi@vger.kernel.org>; Wed, 17 Feb 2016 09:03:51 -0800 (PST)
In-Reply-To: <20160217143306.6340c6cf@endymion>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

[+cc Huang, author of both aer_inject and apei/einj]

On Wed, Feb 17, 2016 at 7:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi all,
>
> I am looking for some guidance regarding AER testing. I see that we
> have two different drivers for error injection in the kernel:
> aer_inject and apei/einj. The user-space aer-inject tool seems to only
> care about the former.
>
> How does one know which driver should be used on a given system? I
> suppose that only one of them will work on a given system?
>
> My impression is that aer_inject is for "native" AER handling while
> apei/einj is for ACPI-driven AER. Is it correct? If not I would
> appreciate some pointers explaining when aer_inject should be used and
> when apei/einj should be used.

My understanding is that:

  - aer_inject does not actually write to any hardware registers
itself (though I do see it writes to some masks).  It works by
replacing the PCI config accessors with new ones that make it look
like the AER registers have errors logged.

  - apei/einj runs ACPI methods that apparently seed errors.  These
might use hardware support for seeding errors, which would of course
be platform-dependent.

So aer_inject should work on any system at all.  I think apei/einj
will only work if the platform supplies an EINJ table, and even when
it does, I suspect different platforms probably have different
injection capabilities.

Huang probably can give a much better response.

Bjorn
