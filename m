From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/8] [RFC/RFT] Implement sparse keymap library
Date: Wed, 02 Dec 2009 01:24:02 -0800
Message-ID: <20091202091056.30409.50455.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:63864 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZLBJ3j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 04:29:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>

Hi,

It seems that almost everty platform driver out there copied the keymap
implementation from wistron button driver... That's a lot of duplicated code
and I think it is high time we split it into a library module that can be
shared between all these drivers.

The code is only compile-tested since I don't have boxes that would run these
drivers.

Thanks.

-- 
Dmitry
