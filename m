From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: New Surface 3 (atom x7) having problems with ACPI regions
Date: Wed, 9 Sep 2015 09:51:26 -0400
Message-ID: <CAN+gG=FMjShOWf6LXwDd5Fps-ME4cDCtN2h6bTZRvOifhAMRtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35230 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbIINv2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2015 09:51:28 -0400
Received: by wicge5 with SMTP id ge5so156124674wic.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2015 06:51:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bastien Nocera <hadess@hadess.net>

Hey,

Bastien (CC-ed) has troubles having the touchscreen of the new Surface
3 (atom based) showing up.
He raised a kernel bugzilla [1] and the dmesg shows:
ACPI Error: Region GeneralPurposeIo (ID=8) has no handler (20150619/exfldio-297)

Which seems to interrupt the parsing of the DSDT.

I am not sure about the status of ACPI regions in the latest acpi tree
so I prefer asking here. Does this error actually prevents the
touchscreen to be loaded by i2c-hid or is there something else
preventing the enumeration?

Cheers,
Benjamin

[1] https://bugzilla.kernel.org/show_bug.cgi?id=104291
