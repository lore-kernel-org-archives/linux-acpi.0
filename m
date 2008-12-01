From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch][rfc] acpi: do not use kmem caches
Date: Mon, 01 Dec 2008 20:49:27 +0300
Message-ID: <493423A7.6050907@gmail.com>
References: <20081201083128.GB2529@wotan.suse.de> <84144f020812010318v205579ean57edecf7992ec7ef@mail.gmail.com> <20081201120002.GB10790@wotan.suse.de> <4933E2C3.4020400@gmail.com> <1228138641.14439.18.camel@penberg-laptop> <4933EE8A.2010007@gmail.com> <20081201161404.GE10790@wotan.suse.de> <4934149A.4020604@gmail.com> <20081201172044.GB14074@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51975 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYLARtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 12:49:32 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2742755ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2008 09:49:30 -0800 (PST)
In-Reply-To: <20081201172044.GB14074@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux Memory Management List <linux-mm@kvack.org>, linux-acpi@vger.kernel.org, lenb@kernel.org

Christoph Hellwig wrote:
> On Mon, Dec 01, 2008 at 07:45:14PM +0300, Alexey Starikovskiy wrote:
>   
>> You would laugh, this is due to Windows userspace debug library -- it  
>> checks for
>> memory leaks by default, and it takes ages to do this.
>> And ACPICA maintainer is sitting on Windows, so he _cares_.
>>     
>
> So what about getting a non-moronic maintainer instead?  Really this
> whole ACPI code is a piece of turd exactly because of shit like this.
> Can't Intel get their act together and do a proper ACPI implementation
> for Linux instead of this junk?
>
> Or at least stop arguing and throwing bureaucratic stones in the way of
> those wanting to sort out this mess.
>
>   
Christoph, please, I don't work for Intel :)
How long will it take for _you_ to write another ACPICA ?
I assume it will be shining diamond?

Regards,
Alex.


