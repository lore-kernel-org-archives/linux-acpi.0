From: fanderay <fanderay4@googlemail.com>
Subject: 2.6.30: Periodic ACPI Exception and Error messages on Sony Vaio
	SR19VN
Date: Mon, 15 Jun 2009 11:21:10 +0100
Message-ID: <31c940650906150321t7fef7904g85eaf0e02d8cbff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:58525 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZFOK0r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2009 06:26:47 -0400
Received: by bwz9 with SMTP id 9so3215461bwz.37
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2009 03:26:48 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

In 2.6.30 running on a Vaio SR19VN I receive bursts of messages like
the following, consistently and periodically:

[282755.328562] ACPI: EC: input buffer is not empty, aborting transaction
[282755.328581] ACPI Exception (evregion-0422): AE_TIME, Returned by
Handler for [EmbeddedControl] [20090320]
[282755.328611] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.BAT0._BST] (Node ffff88013fa742d0), AE_TIME
[282755.328780] ACPI Exception (battery-0385): AE_TIME, Evaluating
_BST [20090320]
[282755.836522] ACPI: EC: input buffer is not empty, aborting transaction
[282756.336536] ACPI: EC: input buffer is not empty, aborting transaction
[282756.336555] ACPI Exception (evregion-0422): AE_TIME, Returned by
Handler for [EmbeddedControl] [20090320]
[282756.336585] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.BAT0._BST] (Node ffff88013fa742d0), AE_TIME
[282756.336757] ACPI Exception (battery-0385): AE_TIME, Evaluating
_BST [20090320]
[397784.536520] ACPI: EC: input buffer is not empty, aborting transaction
[397784.536530] ACPI Exception (evregion-0422): AE_TIME, Returned by
Handler for [EmbeddedControl] [20090320]
[397784.536543] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.BAT0._BST] (Node ffff88013fa742d0), AE_TIME
[397784.536607] ACPI Exception (battery-0385): AE_TIME, Evaluating
_BST [20090320]

This has actually been going on for a while now, at least since some
of the early .30 rc's.  It's not clear to me what it means or what the
impact is.  (All the hardware details for this system can be found in
Bug #13148.)
