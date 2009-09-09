From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH v3] topstar-laptop: add new driver for hotkeys support on
	Topstar N01
Date: Wed, 9 Sep 2009 21:46:55 +0200
Message-ID: <71cd59b00909091246m22c12081oe8f10018cee6be78@mail.gmail.com>
References: <200909091441.09355.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39732 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZIITqx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 15:46:53 -0400
Received: by bwz19 with SMTP id 19so686232bwz.37
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2009 12:46:55 -0700 (PDT)
In-Reply-To: <200909091441.09355.herton@mandriva.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <sourcejedi.lkml@googlemail.com>

On Wed, Sep 9, 2009 at 7:41 PM, Herton Ronaldo
Krzesinski<herton@mandriva.com.br> wrote:
> This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> functionality with Topstar N01 netbook. Besides hotkeys there are
> other functions exposed by its ACPI firmware, but for now only
> hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> manufacturer, its website can be currently reached at
> http://www.topstardigital.cn/
>
> Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

Seems good,
Maybe you'll want to make a patch to add yourself to the MAINTAINERS file.
You should also CC Len Brown, so he will add your patch in the linux-acpi tree.

-- 
Corentin Chary
http://xf.iksaif.net
