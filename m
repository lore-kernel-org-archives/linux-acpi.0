From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-mm2: ACPI exception on resume
Date: Mon, 21 May 2007 20:03:49 -0300
Message-ID: <20070521230349.GA645@khazad-dum.debian.net>
References: <20070519165738.GK11115@waste.org> <20070519204504.GA24704@khazad-dum.debian.net> <20070519223843.GN11115@waste.org> <20070520035259.GA13224@khazad-dum.debian.net> <20070521222339.GF11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41966 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757137AbXEUXEA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 19:04:00 -0400
Content-Disposition: inline
In-Reply-To: <20070521222339.GF11115@waste.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Mon, 21 May 2007, Matt Mackall wrote:
> BIOS Information
>         Vendor: IBM
>         Version: 1RETDHWW (3.13 )
>         Release Date: 10/29/2004
> 
> No sign of any EC version in the output.

This is a buggy, ancient version of the BIOS, which probably means you have
an old and slightly buggy EC firmware.  I recommend you to upgrade to BIOS
3.21 and EC 3.04.  See http://thinkwiki.org/wiki/BIOS_Upgrade for more
details.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
