From: David Binderman <linuxdev.baldrick@gmail.com>
Subject: linux-4.7-rc1/drivers/acpi/acpica/dbinput.c:484]: (style) Redundant condition
Date: Mon, 30 May 2016 08:49:45 +0100
Message-ID: <CAMzoamZr2MuHx6bXWwf-J5HQK4Gt1_xAuW+JShd=S5sSD=gS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35030 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcE3Htq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 May 2016 03:49:46 -0400
Received: by mail-it0-f67.google.com with SMTP id z123so5165024itg.2
        for <linux-acpi@vger.kernel.org>; Mon, 30 May 2016 00:49:46 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org

Hello there,

linux-4.7-rc1/drivers/acpi/acpica/dbinput.c:484]: (style) Redundant
condition: If 'EXPR == ' '', the comparison 'EXPR' is always true.

Source code is

       while (*string && (*string == ' ')) {

Maybe better code

       while (*string == ' ') {


Regards

David Binderman
