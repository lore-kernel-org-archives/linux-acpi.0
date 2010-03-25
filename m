From: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Subject: how to debug a kernel that does not power off?
Date: Wed, 24 Mar 2010 22:32:21 -0600
Message-ID: <4BAAE755.9090509@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perec.tyrell.hu ([66.197.149.104]:41115 "EHLO perec.tyrell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204Ab0CYFL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Mar 2010 01:11:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by perec.tyrell.hu (Postfix) with ESMTP id 7ACAA300D5
	for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2010 00:32:34 -0400 (EDT)
Received: from perec.tyrell.hu ([127.0.0.1])
	by localhost (perec.tyrell.hu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8nrvcg03g6cG for <linux-acpi@vger.kernel.org>;
	Thu, 25 Mar 2010 00:32:30 -0400 (EDT)
Received: from [10.128.226.215] (unknown [189.140.25.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: akos@maroy.hu)
	by perec.tyrell.hu (Postfix) with ESMTPSA id 872DA300D4
	for <linux-acpi@vger.kernel.org>; Thu, 25 Mar 2010 00:32:30 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

This might be a lame question, but: how would I debug a kernel that
simply does not power off a machine? When powering off, on the console I
get to the message: [...] Poweroff.

but then, the machine actually does not power off. This is an HP Envy 15
laptop using an intel i7 CPU, and kernel 2.6.32.8..10.

I tried to read up on all sorts of documentation, but could not get more
debug info out of the kernel :(

any pointers would be welcome..


Akos

