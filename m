From: Andy Lutomirski <luto@amacapital.net>
Subject: ACPICA serialized objects?
Date: Wed, 2 Dec 2015 16:37:57 -0800
Message-ID: <CALCETrWFSs0Ornr9airzqL=9ph06WDghOUaKmA_8cAorrw1Kpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35840 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbbLCAiR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 19:38:17 -0500
Received: by oiww189 with SMTP id w189so37011798oiw.3
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2015 16:38:17 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>

[resend as plain text]

I want to bundle up an arbitrary ACPI_OBJECT into a copyable stream of
bytes, is there some standard way to do this?

I'm asking because I want to try to upstream something resembling the
rusty old acpi_call module to allow users with debugfs access who are
willing to taint their kernel to evaluate ACPI objects from userspace.
Presumably there would be a user tool to get object info and to
evaluate methods, and we could handle translation to/from strings in
userspace, but I still need some way to shove the data back and forth.

Thanks,
Andy
