From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for July 20 (acpi/apei/ghes)
Date: Wed, 20 Jul 2011 09:36:33 -0700
Message-ID: <20110720093633.ca9cf794.rdunlap@xenotime.net>
References: <20110720180041.5774ca335e6697c17374dca5@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:45705 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751376Ab1GTQgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2011 12:36:35 -0400
In-Reply-To: <20110720180041.5774ca335e6697c17374dca5@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 20 Jul 2011 18:00:41 +1000 Stephen Rothwell wrote:

> Hi all,

On i386 (X86_32):

drivers/acpi/apei/ghes.c:542: warning: integer overflow in expression
drivers/acpi/apei/ghes.c:619: warning: integer overflow in expression

ghes.c:(.text+0x46289): undefined reference to `__udivdi3'
  in function ghes_estatus_cache_add().

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
