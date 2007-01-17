From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Wed, 17 Jan 2007 02:56:36 +0000
Message-ID: <1169002596.29755.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:56121 "EHLO
	ppsw-3.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXAQC4n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2007 21:56:43 -0500
Received: from acc9f2d9.ipt.aol.com ([172.201.242.217]:49391 helo=[192.168.1.71])
	by ppsw-3.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.153]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1H70yb-0000It-Ac (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Wed, 17 Jan 2007 02:56:37 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, I've got an issue with my HP Compaq nc6320, where it won't boot off
its battery without softlocking on CPU#0. I remember it booting ok off
battery occasionally in the past, but once I've seen the fault - the
only way I can get it to boot is off AC. (I usually boot off AC anyway).

I'm presuming ACPI as a good starting point, since that is an area where
AC / Battery may make a difference.

Can anyone suggest a debugging procedure to identify the cause of a
softlock, and where would be appropriate (which category) to file a
kernel bug for this?

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

