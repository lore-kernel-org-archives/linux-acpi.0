From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2 4/4] toshiba_acpi: Add blacklist for models with
 hotkey problems
Date: Thu, 5 Jan 2012 14:04:32 -0600
Message-ID: <20120105200432.GE25386@ubuntu-macmini>
References: <1325617358-8286-1-git-send-email-seth.forshee@canonical.com>
 <1325617358-8286-5-git-send-email-seth.forshee@canonical.com>
 <20120105182627.GE24242@srcf.ucam.org>
 <20120105193228.GB25386@ubuntu-macmini>
 <20120105193431.GA26097@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120105193431.GA26097@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 05, 2012 at 07:34:31PM +0000, Matthew Garrett wrote:
> On Thu, Jan 05, 2012 at 01:32:28PM -0600, Seth Forshee wrote:
> 
> > Also a side note of interest: The machines that suffer from this all
> > also have a WMI interface with code to support hotkeys, and that code
> > shouldn't suffer from this problem. Unfortunately these models are the
> > only ones I've seen with this WMI interface, and the code to generate
> > the hotkey events isn't executed if the OS reports itself as Vista or
> > newer.
> 
> In that case, can you check for the presence of the WMI interface and 
> then refuse to bind? That's seem far simpler than adding an unknown 
> number of systems to the blacklist.

Hmm, I suppose I could look for the specific WMI event guid, although
the relationship between the two seems tenuous at best. It would make
sense to me if we were refusing to bind because there was a better
interface available, but Toshiba is obviously treating hotkeys on the
WMI interface as legacy since it's disabled in the BIOS for Vista or
later. INFO seems to be the preferred interface.
