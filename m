From: Len Brown <len.brown@intel.com>
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support
 for userspace access to acpi)
Date: Thu, 28 Oct 2004 01:37:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <418085B0.30208@intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262783AbUJ1FiJ@vger.kernel.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Moore, Robert" <robert.moore@intel.com>, Alex Williamson <alex.williamson@hp.com>, linux-kernel <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

One way to experiment with a user-mode ACPI interpreter would be to 
continue to use the kernel-mode interpreter for boot up , and cut over 
to the user-mode interpreter at /sbin/init.  The kernel-mode interpreter 
could be sent the way of free_initmem() which is called just before 
/sbin/init is invoked.

-Len
