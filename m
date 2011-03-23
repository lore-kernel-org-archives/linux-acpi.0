From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Handle multiple button devices with the same name
Date: Wed, 23 Mar 2011 00:56:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103230055200.10549@x980>
References: <1299876888-6239-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:57355 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab1CWE5S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 00:57:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LIH00MF2V32NMW0@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 22 Mar 2011 23:57:08 -0500 (CDT)
In-reply-to: <1299876888-6239-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org

> It's valid for ACPI to have multiple devices with the same name. It's not
> valid for us to create multiple identical directories in /proc. Let's
> put some effort into uniqueness.

I chose the patch that deletes this code instead.

thanks,
Len Brown, Intel Open Source Technology Center

