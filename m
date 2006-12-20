From: "Balaji Rao" <balajirrao@gmail.com>
Subject: Power States
Date: Thu, 21 Dec 2006 00:03:41 +0530
Message-ID: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:18911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030269AbWLTSdm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 13:33:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2319652uga
        for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2006 10:33:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

Are the various power levels supported by the processor provided only
through the DSDT? Or is there any other table for this purpose?
When i disassembled my DSDT, i could not find any _PSS Packages.

>From where does the kernel read values into the frequency table?

Also, which is the mechanism that decides to load the appropriate
cpufreq driver?

warm regards

Balaji Rao
