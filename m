From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
	for suspend/resume
Date: Tue, 26 Oct 2004 10:42:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1098780150.2789.19.camel@laptop.fenrus.org>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026051100.GA5844@wotan.suse.de>  <417DEA8D.4080307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262180AbUJZIms@vger.kernel.org>
In-Reply-To: <417DEA8D.4080307@intel.com>
To: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Li, Shaohua" <shaohua.li@intel.com>, ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-10-26 at 02:11 -0400, Len Brown wrote:
> What this comes down to is that extended config space is device-specific.
> Generic solutions will fail.  Only device drivers will work.
> 
> If there are no drivers for PCI bridges to properly save/restore
> their config space, then should create them, even if this is all the 
> drivers do.

note that by default, if there is no driver, the first 64 bytes of
config space are saved/restored.
-- 
