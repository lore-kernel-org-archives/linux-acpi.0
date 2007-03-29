From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.21-rc5-mm2 -- ACPI problems (lid switch broken, always shows running from AC, plugging in AC hangs machine)
Date: Thu, 29 Mar 2007 14:49:14 -0700
Message-ID: <a44ae5cd0703291449p1e8f75a2i68e9874362cef061@mail.gmail.com>
References: <a44ae5cd0703281355h13f1bd70s9eb94092bfa9c3e@mail.gmail.com>
	 <a44ae5cd0703290100q1bb80390ke66333407bbeecfd@mail.gmail.com>
	 <20070329011503.00c89cb8.akpm@linux-foundation.org>
	 <200703291311.09893.lenb@kernel.org>
	 <a44ae5cd0703291314i6cd6cbaeo8ed0d7037b746cd5@mail.gmail.com>
	 <a44ae5cd0703291335q1eff6661hf398dfca1db8e491@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:42727 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934346AbXC2VtQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2007 17:49:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so638599uga
        for <linux-acpi@vger.kernel.org>; Thu, 29 Mar 2007 14:49:15 -0700 (PDT)
In-Reply-To: <a44ae5cd0703291335q1eff6661hf398dfca1db8e491@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hmm.   I've reproduced these problems with vanilla 2.6.21-rc5, so the
latest acpi-git changes are off the hook.  I am currently trying to
reproduce the problems with 2.6.21-rc4.  I'll let you know how it
turns out.

       Miles
