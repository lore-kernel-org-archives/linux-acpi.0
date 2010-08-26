From: Yedidia Klein <yedidia@atarplpl.co.il>
Subject: getting new hardware (arbor M1526) buttons to work w/ acpi
Date: Thu, 26 Aug 2010 08:56:24 +0300
Message-ID: <AANLkTinTLAhRL48sP=B86RMEahx2dg_aczuwS+vn78js@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62981 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0HZF4p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2010 01:56:45 -0400
Received: by vws3 with SMTP id 3so1383763vws.19
        for <linux-acpi@vger.kernel.org>; Wed, 25 Aug 2010 22:56:44 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello list,

I've a kiosk computer named arbor m1526
(http://www.arbor.com.tw/products/detail.aspx?Product_Name=M1526.)
this hardware has some functions key (F1-F8) that are connected to
Embedded Controller.

The company do not provide Linux support to these buttons but provided
information on addresses as follows:
EC RAM Address 0x0501

Bit0 = 1 indicative F1 Button be pressed
Bit1 = 1 indicative F2 Button be pressed
Bit2 = 1 indicative F3 Button be pressed
Bit3 = 1 indicative F4 Button be pressed
Bit4 = 1 indicative F5 Button be pressed
Bit5 = 1 indicative F6 Button be pressed
Bit6 = 1 indicative F7 Button be pressed
Bit7 = 1 indicative F8 Button be pressed
P.S. If read finish please clear EC ram bit flag.

I would like to write a new acpi patch/file to the linux kernel for
supporting these buttons.
seems to me that the right place is writing a new file at drivers/platform/x86

I'm looking for some good doc. or template for writing a new hardware
acpi support.

any help will be appreciate,

tnx,

--Y
