From: "Kurt H Maier" <karmaflux@gmail.com>
Subject: Notifying userspace of ACPI events
Date: Wed, 31 Oct 2007 11:21:23 -0500
Message-ID: <1aa1410a0710310921xad50692p5281640e0a6994e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:17306 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbXJaQV3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 12:21:29 -0400
Received: by el-out-1112.google.com with SMTP id j27so49094elf
        for <linux-acpi@vger.kernel.org>; Wed, 31 Oct 2007 09:21:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

What's the proper method of notifying userpace processes that an ACPI
event has triggered?  I'm working on scripts and programs for laptops,
and I'm trying to avoid simply polling the acpid logs, which the users
may not even have permissions to access.

-- 
# Kurt H Maier
