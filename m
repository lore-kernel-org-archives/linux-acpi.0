From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: RFC: fast transactions in EC [was: a problem about the two patches
 in bug 10724 & 11428]
Date: Mon, 08 Sep 2008 12:30:38 +0400
Message-ID: <48C4E2AE.8080600@suse.de>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	<20080901122158.GB21970@khazad-dum.debian.net>	<48BC522D.60905@suse.de>	<48BC57C9.2040409@suse.de>	<1220421722.4007.4.camel@yakui_zhao.sh.intel.com>	<48BE32AF.0@suse.de>	<1220429030.4007.22.camel@yakui_zhao.sh.intel.com>	<48BE427C.3070204@suse.de>	<1220430856.4007.38.camel@yakui_zhao.sh.intel.com>	<48BF07E1.8080304@suse.de>	<1220497095.4007.76.camel@yakui_zhao.sh.intel.com>	<48BF6969.2040602@suse.de>	<20080905130741.5a67bfdf.akpm@linux-foundation.org>	<48C4E014.1030002@suse.de> <20080908012812.1a332ec1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:59576 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751945AbYIHIal (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 04:30:41 -0400
In-Reply-To: <20080908012812.1a332ec1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yakui.zhao@intel.com, hmh@hmh.eng.br, linux-acpi@vger.kernel.org, lenb@kernel.org

Andrew Morton wrote:
> On Mon, 08 Sep 2008 12:19:32 +0400 Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> 
>> yes to both questions. This patch hopefully solves the problem better.
>>
> 
> I locally reverted "ACPI: EC: do transaction from interrupt context"
> because of the regression which Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> reported :(
Could you please forward his message to me?
It seems I don't have it...

Thanks,
Alex.
