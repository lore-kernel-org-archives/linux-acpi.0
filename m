From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI paches for 2.6.24-rc0
Date: Wed, 10 Oct 2007 00:42:04 -0700
Message-ID: <20071010004204.3ae1f7c0.akpm@linux-foundation.org>
References: <200710092310.48143.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45407 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbXJJHmV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 03:42:21 -0400
In-Reply-To: <200710092310.48143.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 9 Oct 2007 23:10:47 -0400 Len Brown <lenb@kernel.org> wrote:

> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> ...
>
>  drivers/acpi/battery.c             | 1038 +++++--------

Does this introduce the problem which Zan Lynx reported in his
unresponded-to email titled "2.6.23-rc8-mm2 ACPI Battery Info in /sys but
not /proc/acpi"?


