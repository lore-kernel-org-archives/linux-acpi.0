From: Franklin Marmon <marmon@montana.com>
Subject: function keys
Date: Wed, 15 Mar 2006 22:56:43 -0700
Message-ID: <200603152256.43735.marmon@montana.com>
Reply-To: marmon@montana.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jollyroger.montana.com ([66.109.128.82]:48364 "EHLO
	jollyroger.montana.com") by vger.kernel.org with ESMTP
	id S932673AbWCPF4k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Mar 2006 00:56:40 -0500
Received: from laptop.hydeco.com (marmon.montana.com [66.109.143.72])
	(authenticated bits=0)
	by jollyroger.montana.com (8.12.11/8.12.11) with ESMTP id k2G5tpWk008104
	for <linux-acpi@vger.kernel.org>; Wed, 15 Mar 2006 22:55:52 -0700
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I am currently using an acpi driver for sony laptops (sony_acpi.c) which 
provides an interface for reading that last pressed function key by means of 
a /proc interface file. When read this file will show either 0 or the last 
function key combination that was typed. It provides this value by using the 
acpi_evaluate_object() function to obtain the value of "GHKE". A user space 
program is currently used to read this value every N seconds and check for 
events.

Is there an interrupt generated when one of these function keys is pressed and 
is this interrupt currently handled by the acpi subsystem? If so, is there a 
way to add this acpi device driver into a wait queue for this type of event 
so that a proper char device may be created and polled, rather than reading 
the /proc file system every N seconds?

Is there a better way to handle this type of thing in the kernel already that 
I've missed?

Thank you,

frm

--
Franklin Marmon
freenode nic: Agathezol
