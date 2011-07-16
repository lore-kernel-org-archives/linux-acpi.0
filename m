From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for July 16 (acpi/apei)
Date: Sat, 16 Jul 2011 12:03:04 -0700
Message-ID: <20110716120304.83d79985.rdunlap@xenotime.net>
References: <20110717000815.c83755be9598d34ac8431908@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:33949 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753130Ab1GPTDI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jul 2011 15:03:08 -0400
In-Reply-To: <20110717000815.c83755be9598d34ac8431908@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, 17 Jul 2011 00:08:15 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20110707:


When # CONFIG_ACPI_APEI_GHES is not set:

(.init.text+0x4c22): undefined reference to `ghes_disable'

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
