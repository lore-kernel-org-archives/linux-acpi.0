From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
 for suspend/resume
Date: Tue, 26 Oct 2004 02:11:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <417DEA8D.4080307@intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com> <20041026051100.GA5844@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261918AbUJZGMF@vger.kernel.org>
In-Reply-To: <20041026051100.GA5844@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

What this comes down to is that extended config space is device-specific.
Generic solutions will fail.  Only device drivers will work.

If there are no drivers for PCI bridges to properly save/restore
their config space, then should create them, even if this is all the 
drivers do.

-Len
