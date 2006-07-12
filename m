From: Andrew Morton <akpm@osdl.org>
Subject: evxfevnt glitch
Date: Wed, 12 Jul 2006 00:52:57 -0700
Message-ID: <20060712005257.9e5421ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:34764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750788AbWGLHw6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 03:52:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C7qvnW030153
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2006 00:52:58 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k6C7qvNI031015
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2006 00:52:57 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I have an old machine which doesn't use ACPI.  During a reboot (sysrq-B)
I get

ACPI Warning (evxfevnt-0115): No FADT information present! [20060707]

It shouldn't print that if ACPI has disabled itself.
