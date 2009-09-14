From: Corentin Chary <corentincj@iksaif.net>
Subject: Re: [PATCH 3/3] dell-laptop: fix rfkill memory leak on unload
Date: Mon, 14 Sep 2009 14:01:58 +0200
Message-ID: <200909141401.58428.corentincj@iksaif.net>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net> <20090914104616.GA6170@srcf.ucam.org> <4AAE22CF.1020609@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38047 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZINMBv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 08:01:51 -0400
In-Reply-To: <4AAE22CF.1020609@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Johannes Berg <johannes@sipsolutions.net>

On Monday 14 September 2009 13:02:39 Alan Jenkins wrote:
> Matthew Garrett wrote:
> > On Mon, Sep 14, 2009 at 12:43:53PM +0200, Corentin Chary wrote:
> >> rfkill_unregister() should always be followed by rfkill_destroy()
> >>
> >> Cc: Matthew Garrett <mjg@redhat.com>
> >> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> >
> > Acked-by: Matthew Garrett <mjg@redhat.com>
> 
> I can endorse this as I already submitted something similar :-).
> <http://patchwork.kernel.org/patch/42699/> (with a disclaimer that it
> was not tested on dell hardware).

I haven't seen your patch, sorry :/

It also conflicts with http://patchwork.kernel.org/patch/42705/ (I set 
wlan_rfkill to NULL to avoid use-after-free).

Let's drop this patch and merge your series

-- 
Corentin Chary
http://xf.iksaif.net
