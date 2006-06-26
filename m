From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function
 `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to
 `is_dock_device'
Date: Tue, 27 Jun 2006 00:15:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0606270013220.17704@scrub.home>
References: <15233.1151302967@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:22253 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751105AbWFZWWY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Jun 2006 18:22:24 -0400
In-Reply-To: <15233.1151302967@kao2.melbourne.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>
Cc: Miles Lane <miles.lane@gmail.com>, Adrian Bunk <bunk@stusta.de>, Kristen Accardi <kristen.c.accardi@intel.com>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, len.brown@intel.com, linux-acpi@vger.kernel.org

Hi,

On Mon, 26 Jun 2006, Keith Owens wrote:

> and it turns out that this no longer works.  It used to work with the
> old config system, but Kconfig gets confused by choices if the input
> .config only has the selected choice and is missing the alternates.
> For example, Kconfig accepts this

Choices are not so much the problem, the problems are default. Once the 
setting is gone, it will fall back to the default, which is not always 
'n'.

bye, Roman
