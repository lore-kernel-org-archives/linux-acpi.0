From: Nick Nobody <me@nikosapi.org>
Subject: ACPI support for Gateway LT3108
Date: Tue, 20 Oct 2009 10:08:39 -0400
Message-ID: <1256047719.3526.31.camel@nikosapi-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nikosapi.org ([209.123.162.110]:40535 "EHLO nikosapi.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbZJTOs7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2009 10:48:59 -0400
Received: from 76-10-183-81.dsl.teksavvy.com ([76.10.183.81] helo=[192.168.0.68])
	by nikosapi.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <nikosapi@nikosapi.org>)
	id 1N0FOU-0004PM-DY
	for linux-acpi@vger.kernel.org; Tue, 20 Oct 2009 10:08:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I just got a netbook and I can't use frequency scaling unless I
recompile the kernel (2.6.31.4) with a patch for powernow-k8 [1] and a
custom DSDT [2]. I read that using custom DSDTs are frowned upon so I
was wondering how I can help getting the laptop working without one.

I also noticed that it doesn't always wake up from sleep: it'll just
hang with a black screen. This is with both a 2.6.28.15 (ubuntu kernel)
and 2.6.31.4 (vanilla from kernel.org). How would I go about debugging
this?

The laptop in question is a Gateway LT3108. It's all AMD/ATI chips with
a Phoenix BIOS (I checked for updates, there are none). Please let me
know whatever information you need, I'll send it right along.

nick

[1] http://www.pow.za.net/powernow-k8-git.diff
[2] http://www.pow.za.net/dsdt.hex.txt

