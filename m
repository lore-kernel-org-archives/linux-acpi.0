From: Richard Hughes <hughsient@gmail.com>
Subject: Reporting the lid status using INPUT
Date: Fri, 15 Jun 2007 13:29:27 +0100
Message-ID: <1181910567.4819.7.camel@work>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:25166 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbXFOMa3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 08:30:29 -0400
Received: by wx-out-0506.google.com with SMTP id t15so850939wxc
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jun 2007 05:30:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>

Guys,

I'm getting a few bugreports where:

* user shuts lid, initiates suspend
{lid is reported down}
* user opens lid, resume completes

But I'm not getting any lid INPUT up event. This works if you don't
initiate suspend when you shut the lid (blank screen for instance) -- so
I know my hardware is okay.

I see:

input_report_switch(input, SW_LID, !state);

in response to an event, but I'm thinking in a resume hook we should
probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
send an event, just so userspace is aware of what the state of the panel
is.

Does this sound sane?

Richard.


