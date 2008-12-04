From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 2/2 update] misc: Add dell-laptop driver
Date: Thu, 04 Dec 2008 11:00:44 +0000
Message-ID: <4937B85C.5050808@tuffmail.co.uk>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org> <20081202201645.GB31620@srcf.ucam.org> <alpine.LFD.2.00.0812031414150.3255@localhost.localdomain> <20081203195238.GA22560@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:21947 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737AbYLDLAw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 06:00:52 -0500
Received: by nf-out-0910.google.com with SMTP id d3so2078584nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 04 Dec 2008 03:00:50 -0800 (PST)
In-Reply-To: <20081203195238.GA22560@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

I still think you need to initialise wifi_rfkill->state before you call
rfkill_register().

It seems an easy mistake, probably the rfkill core should test for it.

Alan

(Sorry about the insane From: header in my previous mail)

