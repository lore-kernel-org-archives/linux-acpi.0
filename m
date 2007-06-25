From: Richard Hughes <hughsient@gmail.com>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Mon, 25 Jun 2007 10:52:36 +0100
Message-ID: <1182765156.2519.0.camel@work>
References: <1180614979.2693.26.camel@localhost.localdomain>
	 <200706231656.39597.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:58266 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbXFYJxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jun 2007 05:53:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1249307ugf
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jun 2007 02:53:18 -0700 (PDT)
In-Reply-To: <200706231656.39597.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>

On Sat, 2007-06-23 at 16:56 +0200, Rolf Eike Beer wrote:
> None of the above keys generated a key event. Neither does "Brightness down", 
> but it still works. "Brightness up" generates an event and works. Kpowersave 
> tells me it can't do brightness switching in software (which works in 
> WinXtraPain).

Do you know how windows does this? Do you have to load a special
system-try thing to make the keys work?

Richard.


