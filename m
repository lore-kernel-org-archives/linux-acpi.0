From: Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH] ACPI: DMI init_set_sci_en_on_resume for multiple
 Lenovo ThinkPads
Date: Wed, 5 May 2010 16:42:28 -0600
Message-ID: <20100505224228.GA3682@canonical.com>
References: <20100420140314.GA5573@canonical.com>
 <alpine.LFD.2.00.1005051634180.23230@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:41487 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab0EEWmd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2010 18:42:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005051634180.23230@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: colin.king@canonical.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org

* Len Brown <lenb@kernel.org>:
> applied for 2.6.34 (and acked for .stable)

Whoops, you picked up the v1, not the v2 version.

The v2 version is a little shorter; it elides the X201S entry
because the X201 entry will catch it.

Doesn't affect functionality / correctness. It's just a little
superfluous to have the 2nd entry.

fyi,
/ac

