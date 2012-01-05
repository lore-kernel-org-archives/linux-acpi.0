From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 4/4] toshiba_acpi: Add blacklist for models with
 hotkey problems
Date: Thu, 5 Jan 2012 20:09:26 +0000
Message-ID: <20120105200925.GA26877@srcf.ucam.org>
References: <1325617358-8286-1-git-send-email-seth.forshee@canonical.com>
 <1325617358-8286-5-git-send-email-seth.forshee@canonical.com>
 <20120105182627.GE24242@srcf.ucam.org>
 <20120105193228.GB25386@ubuntu-macmini>
 <20120105193431.GA26097@srcf.ucam.org>
 <20120105200432.GE25386@ubuntu-macmini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56912 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab2AEUJa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jan 2012 15:09:30 -0500
Content-Disposition: inline
In-Reply-To: <20120105200432.GE25386@ubuntu-macmini>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 05, 2012 at 02:04:32PM -0600, Seth Forshee wrote:
> On Thu, Jan 05, 2012 at 07:34:31PM +0000, Matthew Garrett wrote:
> > In that case, can you check for the presence of the WMI interface and 
> > then refuse to bind? That's seem far simpler than adding an unknown 
> > number of systems to the blacklist.
> 
> Hmm, I suppose I could look for the specific WMI event guid, although
> the relationship between the two seems tenuous at best. It would make
> sense to me if we were refusing to bind because there was a better
> interface available, but Toshiba is obviously treating hotkeys on the
> WMI interface as legacy since it's disabled in the BIOS for Vista or
> later. INFO seems to be the preferred interface.

...but doesn't work?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
