From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: IBM Thinkpad T23 Problems: no battery information
Date: Tue, 19 Jun 2007 14:30:35 +0400
Message-ID: <4677B04B.9080104@gmail.com>
References: <20070619114813.73bbddf9@stef>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:62030 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305AbXFSKai (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jun 2007 06:30:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so70354ugf
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jun 2007 03:30:36 -0700 (PDT)
In-Reply-To: <20070619114813.73bbddf9@stef>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Bihlmaier <alex@kallisti.de>
Cc: linux-acpi@vger.kernel.org

Alex Bihlmaier ?????:
> hiya guys,
> 
> since 2.6.21.1 i don't have *any* files in /proc/acpi/battery/ anymore
> and no tool is able to show me the battery status of my IBM thinkpad
> T23.
> 
> i tried 2.6.21.1: no acpi-battery
> then i tried 2.6.20.14: it works.
> 
> the config is the same and i applied the config for 2.6.21.1 with "make
> oldconfig"
> 
> what can i debug/trace/use?
acpidump helps a lot, dmesg helps somewhat... Open a bug in bugzilla.kernel.org and attach their outputs...

Regards,
Alex.
> 
> greetings,

