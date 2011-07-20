From: amnesia@ownage4u.nl
Subject: Lenovo Thinkpad L512 bugs
Date: Wed, 20 Jul 2011 23:32:20 +0200
Message-ID: <bead060929c8bc109f644ab28f84ab0a@ownage4u.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from koppel-159.sshunet.nl ([145.107.2.159]:46735 "EHLO
	mail.ownage4u.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab1GTVuM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2011 17:50:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

I'm having the following problems with my lenovo thinkpad L512.

=< 2.6.35.13

https://bugzilla.kernel.org/show_bug.cgi?id=25542

An extreme amount of wake ups which causes a high load and battery 
drainage.

=> 2.6.36.4 causes:

https://bugzilla.kernel.org/show_bug.cgi?id=27792

Fan speed freezes, and hotkeys stop working.


