From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Mon, 15 Dec 2008 17:56:37 +0000 (UTC)
Message-ID: <gi65ol$bnf$7@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <20081215155655.GA1535@ucw.cz>
	<gi62fj$bnf$5@ger.gmane.org> <494694F8.6080004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41228 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYLOR4v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 12:56:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCHgW-0001tA-PT
	for linux-acpi@vger.kernel.org; Mon, 15 Dec 2008 17:56:48 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2008 17:56:48 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2008 17:56:48 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2008 20:33:44 +0300, Alexey Starikovskiy wrote:

>> video                  25360  0
>>   
> this one ^^^^^

Ahhh.  Got it.

Unfortunately that was of no help.  Still only a single suspend/resume 
cycle worked.  I removed it before the first cycle, (and made sure it was 
not loaded before the second) for the record.

b.


