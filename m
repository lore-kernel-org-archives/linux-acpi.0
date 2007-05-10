From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22 - part 2
Date: Thu, 10 May 2007 13:31:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705101330320.3986@woody.linux-foundation.org>
References: <200705100411.32349.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:36507 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755479AbXEJUdB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 16:33:01 -0400
In-Reply-To: <200705100411.32349.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 10 May 2007, Len Brown wrote:
> 
> Please test this on your Evo before pushing it upstream.

Seems to work for me. My evo correctly started the fan, and stopped it 
when the temperature went down again.

I forget if there were other issues on that machine that some other ACPI 
updates have triggered, but at least there isn't anything *obviously* 
broken on it.

		Linus
