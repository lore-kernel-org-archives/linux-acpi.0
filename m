From: Florian Echtler <floe@butterbrot.org>
Subject: Fan running continuously after kernel switch
Date: Thu, 15 Jan 2009 09:42:21 +0100
Message-ID: <1232008941.24218.6.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:50889
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758263AbZAOIsL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2009 03:48:11 -0500
Received: from [131.159.10.70] (unknown [131.159.10.70])
	(using SSLv3 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id 9B047154100
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2009 09:44:10 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone,

yesterday, I switched from kernel 2.6.25-gentoo-r8 to 2.6.27-gentoo-r7
on my Thinkpad T60. Since then, the fan has been running continuously. I
have loaded the thinkpad_acpi module and could, of course, switch to
some userspace fan controller, but I'm always a bit reluctant about
those. I've reviewed the Gentoo patches, and none of them seem to have
to do anything with ACPI. So now I'm looking for suggestions on how to
debug this..

Many thanks, Yours, Florian
-- 
0666 - Filemode of the Beast

