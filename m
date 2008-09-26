From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 09:06:39 +0800
Message-ID: <1222391199.4023.125.camel@yakui_zhao.sh.intel.com>
References: <20080925170030.15311.27823.stgit@thinkpad>
	 <48DBCFE0.8050905@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbYIZBBz (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 21:01:55 -0400
In-Reply-To: <48DBCFE0.8050905@yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Thu, 2008-09-25 at 18:52 +0100, Sitsofe Wheeler wrote:
> Alexey Starikovskiy wrote:
> > It is easier and faster to do transaction directly from interrupt context
> > rather than waking control thread.
> > Also, cleaner GPE storm avoidance is implemented.
Hi, Sitsofe
    I think that the problem on the asus-EEEPC can't be resolved really
by the Alexey's patch. IMO it is only lucky.
   In fact the main problem on Asus-EEEPC is related with the broken EC.
Before an EC notification event is processed, another EC notification
event arrives again.
   If EC driver check whether the SCI_EVT bit is set after processing
one EC notification event, the problem will be resolved. 
    http://bugzilla.kernel.org/show_bug.cgi?id=11089
    Alan Jenkins already sent a patch about how to fix the issue on the
Asus-EEEPC.
   
   But if the above patch is merged , maybe it will break some laptops.
On my laptop when issuing the query command, a non-zero query event is
returned but it can't be processed.(There is no corresponding ACPI _Qxx
object). At the same time the SCI_EVT bit won't be cleared. In such case
OS can't exit the function of acpi_ec_query_handler, which causes that
the acpid kernel thread can't work well.
   
   
> References: 	http://bugzilla.kernel.org/show_bug.cgi?id=9998
> > 		http://bugzilla.kernel.org/show_bug.cgi?id=10724
> > 		http://bugzilla.kernel.org/show_bug.cgi?id=10919
> > 		http://bugzilla.kernel.org/show_bug.cgi?id=11309
> > 		http://bugzilla.kernel.org/show_bug.cgi?id=11549
> > Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > ---
> 
> This resolves the slow hotkeys (e.g. brightness keys) that I see on my 
> EeePC 900.
> 
> Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
> 

