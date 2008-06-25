From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: don't walk tables if ACPI was disabled
Date: Tue, 24 Jun 2008 23:07:41 -0400
Message-ID: <1214363265-7103-1-git-send-email-lenb@kernel.org>
References: <20080620135639.GA5073@damson.getinternet.no>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:54583 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbYFYDHs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:07:48 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K30003C70OYOIK7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 22:07:47 -0500 (CDT)
In-reply-to: <20080620135639.GA5073@damson.getinternet.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernrel@vger.kernrel.org

Lets see if this set of little patches will prevent
the acpi=off issues we know about, and expose and
prevent this type of failure in the future.

we can delete the rtc tweak if bjorn makes it unnecessary.

thanks,
-Len


