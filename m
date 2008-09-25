From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Thu, 25 Sep 2008 18:52:32 +0100
Message-ID: <48DBCFE0.8050905@yahoo.com>
References: <20080925170030.15311.27823.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ptb-relay01.plus.net ([212.159.14.145]:59811 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbYIYRw2 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 13:52:28 -0400
In-Reply-To: <20080925170030.15311.27823.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> It is easier and faster to do transaction directly from interrupt context
> rather than waking control thread.
> Also, cleaner GPE storm avoidance is implemented.
> References: 	http://bugzilla.kernel.org/show_bug.cgi?id=9998
> 		http://bugzilla.kernel.org/show_bug.cgi?id=10724
> 		http://bugzilla.kernel.org/show_bug.cgi?id=10919
> 		http://bugzilla.kernel.org/show_bug.cgi?id=11309
> 		http://bugzilla.kernel.org/show_bug.cgi?id=11549
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

This resolves the slow hotkeys (e.g. brightness keys) that I see on my 
EeePC 900.

Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

-- 
Sitsofe | http://sucs.org/~sits/
