From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: 2.6.28-rc1: rapid hotkeys break on eeepc again :(
Date: Tue, 28 Oct 2008 23:49:37 +0000
Message-ID: <4907A511.3040603@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:53582 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYJ1Xts (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 19:49:48 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1161903eyi.37
        for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2008 16:49:47 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Similar but different to the original symptoms of bugzilla #11089 (which
is closed, fixed by the specific patch I tested).  Hotkeys give up the
ghost after being held down for a while, or pressed rapidly.  However
they don't get "out of sync" as in that bug.  I've already tried the
acpi-test tree, but that didn't fix it.

Bad: v2.6.28-rc1
Good: v2.6.27-89-g3156d1e

I can't see any non-trivial changes to the EC or eeepc-laptop drivers in
that range, so it looks like I have to do this the hard way.

Bisecting: 3857 revisions left to test after this

Ow.

Alan
