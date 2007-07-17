From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Tue, 17 Jul 2007 11:37:33 +0100
Message-ID: <1184668653.2443.2.camel@work>
References: <1184520879452-git-send-email-malattia@linux.it>
	 <1184520879991-git-send-email-malattia@linux.it>
	 <11845208793336-git-send-email-malattia@linux.it>
	 <11845208793678-git-send-email-malattia@linux.it>
	 <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org> <1184605565.2228.57.camel@work>
	 <20070716180928.GA21211@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbXGQKl1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 06:41:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so126731ugf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 03:41:26 -0700 (PDT)
In-Reply-To: <20070716180928.GA21211@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 2007-07-16 at 19:09 +0100, Matthew Garrett wrote:
> 
> That's fine, we have information that lets us distinguish between 
> models. 

Yes, but the consensus I seemed to get from previous mails was that the
matching quirks should be done in userspace where possible. The current
FDI thing lets a user edit a simple text xml file and stuff just works.
I'm not sure asking user to compile custom kernel modules to test out
new keymaps is feasible, at least for the majority of linux users.

Richard.


