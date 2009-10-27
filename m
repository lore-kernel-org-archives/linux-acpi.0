From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Tue, 27 Oct 2009 16:53:45 -0700
Message-ID: <20091027165345.3237d3df@infradead.org>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47403 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbZJ0Xwf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 19:52:35 -0400
In-Reply-To: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, 27 Oct 2009 16:40:03 -0700
"Luis R. Rodriguez" <mcgrof@gmail.com> wrote:

> I get this when modprobing some module I am working on. I figured it
> was the module's fault but the EIP points to something else so I am
> not sure. I get the following repeating about 4 times on 2.6.32-rc5:


you can get this if your own code leaves interrupts disabled in a
kernel thread and then lets the cpu go idle...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
