From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Thu, 9 Feb 2006 15:43:25 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E044F0914@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-ia64-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The next thing that would be useful is to know what method(s) are
executing when the message pops out.


> -----Original Message-----
> From: Luck, Tony
> Sent: Thursday, February 09, 2006 1:16 PM
> To: Moore, Robert; 'linux-acpi@vger.kernel.org'
> Cc: 'linux-ia64@vger.kernel.org'
> Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
> 
> But I goofed and muddled up my two problems.  I tried
> booting on my zx1 ... which was broken altogether by
> recent acpi changes.
> 
> Getting back to the rx2620 ... deleting those lines makes
> no difference.  I still boot ok, I still see the unaligned
> access messages.
> 
> /proc/acpi/dsdt for that system attached.
> 
> -Tony
