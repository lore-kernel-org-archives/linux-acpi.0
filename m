From: Corentin Chary <corentincj@iksaif.net>
Subject: Re: [PATCH 0/3] rfkill_unregister() should always be followed by rfkill_destroy()
Date: Mon, 14 Sep 2009 19:47:22 +0200
Message-ID: <200909141947.22170.corentincj@iksaif.net>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net> <20090914170717.GA13452@khazad-dum.debian.net> <20090914171056.GB13452@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:59054 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZINRrN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 13:47:13 -0400
In-Reply-To: <20090914171056.GB13452@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Johannes Berg <johannes@sipsolutions.net>

On Monday 14 September 2009 19:10:56 Henrique de Moraes Holschuh wrote:
> On Mon, 14 Sep 2009, Henrique de Moraes Holschuh wrote:
> > I don't know about the fix for dell-laptop since it is a lot larger.
> 
> But looking at it, it seems to meet the -stable criteria as well.  However,
> it looks like you're fixing two bugs there (set pointers to NULL, call
> _destroy()), so it would be better to have two (smaller) patches, maybe?
> 

The dell-laptop patch is superseded by:
http://patchwork.kernel.org/patch/42705/
http://patchwork.kernel.org/patch/42699/

I didn't check patchwork before working on this patch :/

-- 
Corentin Chary
http://xf.iksaif.net
