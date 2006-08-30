From: Jiri Kosina <jikos@jikos.cz>
Subject: RE: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Date: Wed, 30 Aug 2006 12:28:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608301228100.31711@twin.jikos.cz>
References: <EB12A50964762B4D8111D55B764A845480122D@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:28823 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750700AbWH3K31 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 06:29:27 -0400
In-Reply-To: <EB12A50964762B4D8111D55B764A845480122D@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Mon, 28 Aug 2006, Pallipadi, Venkatesh wrote:

> >http://www.jikos.cz/jikos/junk/ACPIDUMP
> >http://www.jikos.cz/jikos/junk/DMESG
> >http://www.jikos.cz/jikos/junk/PROC_ACPI
> Thanks Jiri for identifying the problem with this patch and reporting
> it. I was able to reproduce it on a system locally and I have tracked
> down the problem. I will send out the updated patch soon and cc it to
> you.

OK, thanks, as soon as you provide the updated patch, I will give it a try 
on my HW.

-- 
JiKos.
