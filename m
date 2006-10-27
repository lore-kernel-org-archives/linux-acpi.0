From: "David Gorst" <dgorst@gmail.com>
Subject: Unsupported Asus laptop - model A6T
Date: Fri, 27 Oct 2006 14:18:23 +1000
Message-ID: <f6ab3b80610262118v42de330dub50db7a83c42fbc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:287 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932274AbWJ0ESY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 00:18:24 -0400
Received: by wx-out-0506.google.com with SMTP id s14so660071wxc
        for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2006 21:18:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've bought a laptop recently which is having problems with ACPI  - it
requires "acpi=off" or "noapic nolapic" in order to avoid hanging
while booting the (version 2.6.18) kernel. Scanning through
/var/log/messages I've come a message indicating that this is an an
unsupported model and I should extract and submit my DSDT to the
developers. So I've done the former and I'm wondering where I should
submit the latter? Apologies if this is the wrong place to do this - I
had a search about on the SourceForge site and couldn't find an
answer.

Regards,
Dave.
