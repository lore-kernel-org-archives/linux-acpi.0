From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 3/3] dell-laptop: fix rfkill memory leak on unload
Date: Mon, 14 Sep 2009 12:02:39 +0100
Message-ID: <4AAE22CF.1020609@tuffmail.co.uk>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net> <1252925033-29696-2-git-send-email-corentincj@iksaif.net> <1252925033-29696-3-git-send-email-corentincj@iksaif.net> <1252925033-29696-4-git-send-email-corentincj@iksaif.net> <20090914104616.GA6170@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:64386 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZINLDP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 07:03:15 -0400
In-Reply-To: <20090914104616.GA6170@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Johannes Berg <johannes@sipsolutions.net>

Matthew Garrett wrote:
> On Mon, Sep 14, 2009 at 12:43:53PM +0200, Corentin Chary wrote:
>   
>> rfkill_unregister() should always be followed by rfkill_destroy()
>>
>> Cc: Matthew Garrett <mjg@redhat.com>
>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>>     
>
> Acked-by: Matthew Garrett <mjg@redhat.com>
>
>   

I can endorse this as I already submitted something similar :-). 
<http://patchwork.kernel.org/patch/42699/> (with a disclaimer that it
was not tested on dell hardware).
