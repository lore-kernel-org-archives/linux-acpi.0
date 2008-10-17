From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] whitespace and comment cleanup for asus_acpi.c
Date: Fri, 17 Oct 2008 16:52:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810171435230.3006@localhost.localdomain>
References: <b85328460810171100o28004af7v5b07db58258706e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:40280 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYJQUwg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 16:52:36 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172069.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8W00BMLHZCW398@vms172069.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Oct 2008 15:52:24 -0500 (CDT)
In-reply-to: <b85328460810171100o28004af7v5b07db58258706e9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Dahlgren <dahlgren@gmail.com>
Cc: linux-acpi@vger.kernel.org, corentincj@iksaif.net


> This patch fixes 100 errors and 8 warnings found by checkpatch against
> the asus_acpi.c file.
> 
> It should apply cleanly to 2.6.27 and should not affect any code functionality.

Hi Mike,
Welcome!

I've applied your patch to the acpi-test tree.

A couple of things to note for your next patch...

This particular driver has a sub-maintainer, Corentin Chary,
as indicated in MAINTAINERS.  Chary will probably either Ack or Nak
this patch in response to this note, but ideally you'd have sent
the patch to Chary in the first round.

Note that this particular driver is suffering bit rot
b/c the plan is to eventually delete it in favor of
drivers/misc/asus-laptop.c.  But I agree that as long
as it is still in the tree, it should undergo basic
maintenace, even if it never gets any new features.

Also, best to avoid sending attachments if you can, because people
read comment and reply to plain text, and often don't open attachments.
>From a patch application point of view, I can handle either, but
prefer plain text because I'm also a reviwer...

ref: Documentation/SubmittingPatches

thanks!
-Len



