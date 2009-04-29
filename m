From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Wed, 29 Apr 2009 17:57:29 +0100
Message-ID: <20090429165729.GB32619@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47660 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759631AbZD2Q5b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 12:57:31 -0400
Content-Disposition: inline
In-Reply-To: <49EE09D9.2060209@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Taking another look at this, you've got:

-       {KE_KEY, 0xe045, KEY_PROG1},
+    {KE_KEY, 0xe045, KEY_NUMLOCK},

The hardware I have here uses 0xe045 for the power profile (or whatever 
it is) button above the keyboard. How do we differentiate these?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
