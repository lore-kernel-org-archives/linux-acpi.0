From: Alex Bihlmaier <alex@kallisti.de>
Subject: IBM Thinkpad T23 Problems: no battery information
Date: Tue, 19 Jun 2007 11:48:13 +0200
Message-ID: <20070619114813.73bbddf9@stef>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kallisti.de ([85.88.6.169]:35344 "EHLO lemma.kallisti.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682AbXFSKMO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 06:12:14 -0400
Received: from stef (static-87-79-237-133.netcologne.de [87.79.237.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: thalunil)
	by lemma.kallisti.de (Postfix) with ESMTP id 71ED472937
	for <linux-acpi@vger.kernel.org>; Tue, 19 Jun 2007 09:48:08 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hiya guys,

since 2.6.21.1 i don't have *any* files in /proc/acpi/battery/ anymore
and no tool is able to show me the battery status of my IBM thinkpad
T23.

i tried 2.6.21.1: no acpi-battery
then i tried 2.6.20.14: it works.

the config is the same and i applied the config for 2.6.21.1 with "make
oldconfig"

what can i debug/trace/use?

greetings,
-- 
        Alex Bihlmaier <thalunil@kallisti.de>, GPG KeyID: 0x1097029B
                     Jabber: thalunil@jabber.ccc.de
	                 Phone: +49 2227 9090075
