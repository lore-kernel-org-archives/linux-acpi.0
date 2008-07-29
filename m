From: Michel Lespinasse <walken@zoy.org>
Subject: DMI information for asus P1-AH2
Date: Mon, 28 Jul 2008 22:44:16 -0700
Message-ID: <20080729054416.GA10520@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:55798 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbYG2GC5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2008 02:02:57 -0400
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id 17F142FC42
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2008 22:44:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

The asus P1-AH2 systems need to use the old suspend ordering in order to
get suspend-to-ram to work.

I see that 2.6.27 RC1 added a DMI list to recognize such machines.
I believe the P1-AH2 should be added there. Please find the necessary
DMI information here:
http://lespinasse.org/dmidecode
http://lespinasse.org/dmidecode_u

Hope this helps,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
