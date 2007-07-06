From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 12/16] INPUT: add a new EV_SW SW_RADIO event, for radio switches on laptops
Date: Thu, 5 Jul 2007 23:46:31 -0400
Message-ID: <200707052346.32047.dtor@insightbb.com>
References: <11836897482509-git-send-email-hmh@hmh.eng.br> <11836897491378-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:32175 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbXGFDqd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jul 2007 23:46:33 -0400
In-Reply-To: <11836897491378-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Ivo van Doorn <ivdoorn@gmail.com>, Richard Hughes <hughsient@gmail.com>

On Thursday 05 July 2007 22:42, Henrique de Moraes Holschuh wrote:
> Many laptops have rf-kill physical switches that are not keys, but slider
> or rocker switches.  Often (like in all ThinkPads with a radio kill slider
> switch), they have both a slider/rocker switch and a hot key.

Linus just merged this one with the last round of input updates.

-- 
Dmitry
