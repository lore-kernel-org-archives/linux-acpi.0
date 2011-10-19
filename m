From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Wed, 19 Oct 2011 09:39:26 -0600
Message-ID: <CAErSpo6m07fAZOg-kEt9ORk6kRDVwC1ZTnEGykqWd3gScJ3efQ@mail.gmail.com>
References: <4E9E916A.4050007@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:39655 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab1JSPjs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Oct 2011 11:39:48 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p9JFdkI5003533
	for <linux-acpi@vger.kernel.org>; Wed, 19 Oct 2011 08:39:46 -0700
Received: from gyd8 (gyd8.prod.google.com [10.243.49.200])
	by wpaz5.hot.corp.google.com with ESMTP id p9JFYDX2029583
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 19 Oct 2011 08:39:46 -0700
Received: by gyd8 with SMTP id 8so2739545gyd.6
        for <linux-acpi@vger.kernel.org>; Wed, 19 Oct 2011 08:39:46 -0700 (PDT)
In-Reply-To: <4E9E916A.4050007@schinagl.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Schinagl <oliver@schinagl.nl>
Cc: linux-acpi@vger.kernel.org

On Wed, Oct 19, 2011 at 2:59 AM, Oliver Schinagl <oliver@schinagl.nl> wrote:
>
> I've updated the BIOS to the latest version supplied by the manufacturer and
> ran 2 new dmesges. I diffed them (stripped of timestamps) with the original
> ones. It did not solve or influence USB support on a 64bit kernel in any
> way. So still USB less on this specific board.
>
> I'd update the bugreport, but the bugzilla is still offline :(

Sorry that this hasn't gone anywhere.  I really miss the bugzilla to
keep track of things like this.

I did notice from your previous dmesg logs that your 32-bit kernel
includes the xhci_hcd driver, but the 64-bit one does not.  Is that
because you disabled USB 2 & 3 (sorry, I'm pretty USB-illiterate)?

I didn't see any IRQ-related differences between your 32-bit and 64-bit logs.

Let's back up to the beginning.  The 64-bit Ubuntu kernel boots fine
with no USB devices, but extremely slowly when any USB devices are
attached, right?  Can you collect those two dmesg logs?

Bjorn
