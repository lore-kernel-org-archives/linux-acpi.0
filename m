From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Regression in module wmi since 2.6.32 (bisected to commit
	1caab3c)
Date: Wed, 6 Jan 2010 15:27:24 +0000
Message-ID: <20100106152724.GA15664@srcf.ucam.org>
References: <4B352513.90302@lwfinger.net> <200912252056.08436.carlos@strangeworlds.co.uk> <4B353035.4050208@lwfinger.net> <200912252158.31127.carlos@strangeworlds.co.uk> <4B353818.1020308@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755149Ab0AFP1q@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B353818.1020308@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hm. I think this is an artifact of the way we're treating WMI right now. 
The assumption is that the interfaces are defined in namespace by their 
GUID, whereas in fact they're defined by their ACPI namespace. Can we 
avoid this by just setting the parent to the ACPI device's corresponding 
Linux device (if present) and including the WMI device's name in the 
dev_set_name call?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
