From: "Dave Young" <hidave.darkstar@gmail.com>
Subject: pnpacpi : exceeded the max number of IO resources
Date: Thu, 29 Nov 2007 17:11:52 +0800
Message-ID: <a8e1da0711290111m65b071cft90b4361ec0155096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:34850 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755837AbXK2JLy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Nov 2007 04:11:54 -0500
Received: by rn-out-0102.google.com with SMTP id i6so1427988rng
        for <linux-acpi@vger.kernel.org>; Thu, 29 Nov 2007 01:11:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,
The pnpacpi rsparser.c report warnings of:
exceeded the max number of IO resources: 24

dmesg|grep exceeded|wc
    66     594    3564

Regards
dave
