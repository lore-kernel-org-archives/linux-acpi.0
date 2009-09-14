From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/3] rfkill_unregister() should always be followed by
 rfkill_destroy()
Date: Mon, 14 Sep 2009 10:24:01 -0300
Message-ID: <20090914132401.GC32253@khazad-dum.debian.net>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39328 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900AbZINNYA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Sep 2009 09:24:00 -0400
Content-Disposition: inline
In-Reply-To: <1252925033-29696-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>

On Mon, 14 Sep 2009, Corentin Chary wrote:
>  drivers/platform/x86/dell-laptop.c   |   36 ++++++++++++++++++++++-----------
>  drivers/platform/x86/hp-wmi.c        |    2 +-
>  drivers/platform/x86/thinkpad_acpi.c |    1 +

These are also likely needed in 2.6.31, please add appropriate Cc: lines to
stable@kernel.org while adding the Acked-By's.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
