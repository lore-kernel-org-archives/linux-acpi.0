From: "Jeff.Wu" <chping@gmail.com>
Subject: ZPODD ACPI _PRW method support
Date: Wed, 28 Nov 2012 16:52:17 +0800
Message-ID: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34442 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab2K1IwS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2012 03:52:18 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so9907372vcm.19
        for <linux-acpi@vger.kernel.org>; Wed, 28 Nov 2012 00:52:17 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, minggr@gmail.com, aaron.lwe@gmail.com

Hi aaron,ming,linux-acpi

 Is it  whether need support ACPI _PRW method for ZPODD device ?
 If BIOS had implemented _PRW method for ZPODD ,
but Linux kernel doesn't support  ZPODD _PRW method,ZPODD will can't
run into suspend state.

Is there any stories for ZPODD Linux _PRW method ?

Thanks
chping
