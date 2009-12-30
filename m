From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Wed, 30 Dec 2009 13:28:11 -0200
Message-ID: <20091230152811.GA18722@khazad-dum.debian.net>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
 <20091224080222.11511.79737.stgit@localhost.localdomain>
 <20091224210146.GA2346@khazad-dum.debian.net>
 <20091225070138.GB19401@core.coreip.homeip.net>
 <20091225133812.GB5891@khazad-dum.debian.net>
 <20091230041227.GB2186@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56273 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123AbZL3P2S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Dec 2009 10:28:18 -0500
Content-Disposition: inline
In-Reply-To: <20091230041227.GB2186@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Tue, 29 Dec 2009, Dmitry Torokhov wrote:
> > That said, is KEY_RESERVED bit left set a common error?  If it is, maybe it
> > make sense to __clear_bit it inside of input_register_device() just in case?
> > 
> 
> Something like below?

Exactly.  Although it looks like you have some unrelated atomic versus
non-atomic set/clear_bit cleanups in it that might be better off in a comit
of their own?

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
