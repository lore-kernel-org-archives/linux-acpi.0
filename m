From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 4/4] sony-laptop: enumerate rfkill devices using SN06
Date: Fri, 18 Dec 2009 07:48:54 +0900
Message-ID: <20091217224854.GC13295@kamineko.org>
References: <1260976116-6369-1-git-send-email-malattia@linux.it>
 <1260976116-6369-2-git-send-email-malattia@linux.it>
 <1260976116-6369-3-git-send-email-malattia@linux.it>
 <1260976116-6369-4-git-send-email-malattia@linux.it>
 <1260976116-6369-5-git-send-email-malattia@linux.it>
 <alpine.LFD.2.00.0912162221030.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:57402
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760111AbZLQWs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2009 17:48:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912162221030.10371@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Wed, Dec 16, 2009 at 10:30:04PM -0500, Len Brown wrote:
> Mattia,
> The mystery is (partially) solved.
> 
> This one wouldn't merge b/c in my mailbox it has a copy of the
> 1st patch appended to it.  I don't know how that happened,
> maybe the the formail processing I use to delete
> duplicates in my mailbox got confused, as the message
> does not have this issue in the list archives.

I slightly changed the subject of one of them (the private workqueue
one), could that be the reason?

> Anyway, with that repaired, this 4th patch joins
> the previous 3 in the acpi-test tree.

Thanks!
-- 
mattia
:wq!
