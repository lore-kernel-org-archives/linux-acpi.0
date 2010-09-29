From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 16/16] ACPI: add DMI entry to work around another insane
 Toshiba BIOS
Date: Wed, 29 Sep 2010 13:38:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009291330390.3855@localhost.localdomain>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
 <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
 <20100929115108.1c596067@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:57352 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab0I2RiU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 13:38:20 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9I00383RNQXQJ2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 29 Sep 2010 12:38:16 -0500 (CDT)
In-reply-to: <20100929115108.1c596067@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org

> If you prefer that I open tickets on bugzilla to process this kind of
> bug, please let me know.

e-mail is normally fastest, but it can be lossy for me,
particularly during summer vacation or when i'm traveling
to a conference for a week.  I fully intend to catch up
when i return, but rarely succeed in doing so.

bugzilla never forgets, and last night I scanned through
all the "RESOLVED" ACPI bugs (bugs with patches), which
is why I happened to see the other models before yours.

But I see it now, so you need do nothing more.
Acutally, if you can verify that if you modify the
entry to DMI_MATCH(DMI_PRODUCT_NAME, "Satellite");
that it still works on your Toshiba, that would be great.
Because that is the path forward that seems to make
most sense right now.

thanks,
Len Brown, Intel Open Source Technology Center

