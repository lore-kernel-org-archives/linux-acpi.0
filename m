From: "Gene Lapointe" <gene@thelapointefamily.com>
Subject: DSDT issue Toshiba P105-S6197
Date: Tue, 17 Apr 2007 11:52:26 -0400 (EDT)
Message-ID: <27015.12.166.50.4.1176825146.squirrel@thelapointefamily.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpe-static-aglapointe-unk.cmts.sha.ptd.net ([24.229.60.172]:34231
	"EHLO mail.thelapointefamily.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030748AbXDQPsV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 11:48:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.thelapointefamily.com (Postfix) with ESMTP id 2043B140008C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Apr 2007 11:52:28 -0400 (EDT)
Received: from mail.thelapointefamily.com ([127.0.0.1])
	by localhost (mail.thelapointefamily.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1CicMMcYTtZ for <linux-acpi@vger.kernel.org>;
	Tue, 17 Apr 2007 11:52:27 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I'm trying to get my sound working on a new toshiba laptop, and have found
that i have a buggy dsdt file.  I followed some instructions on the gentoo
forums and the sound now works, and acpi appears to be running, but when I
try  to use the gnome battery manager I get an error message saying that
/cat/proc/acpi device or resource busy.  This only started after I changed
the DSDT.  Any ideas?

-- 
Gene Lapointe
gene@thelapointefamily.com



-- 
Gene Lapointe
gene@thelapointefamily.com
