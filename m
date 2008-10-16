From: Len Brown <lenb@kernel.org>
Subject: Re: WDRT based watchdog timer
Date: Thu, 16 Oct 2008 18:23:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161821050.3026@localhost.localdomain>
References: <20080926232752.GA6061@cosmic.amd.com>
 <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain>
 <20081008204422.GA2932@cosmic.amd.com>
 <20081014204034.GF30246@infomag.infomag.iguana.be>
 <20081015133350.GA6822@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:39901 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYJPWXT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 18:23:19 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K8U00G7DRIOPN28@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 17:23:13 -0500 (CDT)
In-reply-to: <20081015133350.GA6822@infomag.infomag.iguana.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>

Jordan,
just to clarify, Wim is in charge of the watchdog drivers,
and so this one would go upstream via Wim.

Re: ACPI-ness, I'm find with Wim's edited version,
except for this remaining bit:

+L:     linux-acpi@vger.kernel.org
+W:     http://www.lesswatts.org/projects/acpi/

otherwise...
Acked-by: Len Brown <len.brown@intel.com>

thanks,
-Len


