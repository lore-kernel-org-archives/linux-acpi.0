From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Tue, 27 Nov 2007 00:14:17 +0100
Message-ID: <474B5349.2070500@gmail.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>	<4743CC0B.9000508@linux.vnet.ibm.com>	<20071120221839.faab108e.akpm@linux-foundation.org>	<20071126143943.0a01665b@cuia.boston.redhat.com>	<20071126123319.7483e57f.akpm@linux-foundation.org>	<20071126204540.GA19874@elte.hu>	<474B43E1.9080407@gmail.com> <20071126141713.3dcd492b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:28457 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbXKZXOX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2007 18:14:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1072610ugc
        for <linux-acpi@vger.kernel.org>; Mon, 26 Nov 2007 15:14:21 -0800 (PST)
In-Reply-To: <20071126141713.3dcd492b.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@elte.hu, riel@redhat.com, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org, balbir@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, tglx@linutronix.de, clameter@sgi.com

On 11/26/2007 11:17 PM, Andrew Morton wrote:
>> Maybe if you can emit a broken-out with the fresh pull to test?
> 
> http://userweb.kernel.org/~akpm/mmotm/ is current.  But it probably won't
> compile. 

Yes it did :). And it worked. Both in qemu and on my desktop...

qemu output at:
http://www.fi.muni.cz/~xslaby/sklad/qemu-output.txt

thanks,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
