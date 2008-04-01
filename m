From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 00/37] PNP resource_table cleanups
Date: Tue, 1 Apr 2008 08:52:22 -0600
Message-ID: <200804010852.22785.bjorn.helgaas@hp.com>
References: <20080326171058.099442579@ldl.fc.hp.com> <47F159BE.7050201@keyaccess.nl> <47F20B6A.1000609@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758988AbYDAOwj@vger.kernel.org>
In-Reply-To: <47F20B6A.1000609@keyaccess.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 01 April 2008 04:16:10 am Rene Herman wrote:
> On 31-03-08 23:38, Rene Herman wrote:
> > On 31-03-08 22:51, Bjorn Helgaas wrote:
> > 
> >> Ah, right.  Thanks for tracking that down.  I forgot to factor out
> >> isapnp_to_pnpid() and pnpid32_to_pnpid() (and acpi_ex_eisa_id_to_string()
> >> for that matter, though that's buried in the ACPI CA)-- they're really
> >> doing the same thing and we should only need one copy (plus the CA
> >> one).
> > 
> > I'll wait for another round then, before reviewing this further.
> 
> There's actually a hex_asc() helper in kernel.h, so before you overlook it 
> as well, this is a somewhat nicer ID fix.

Thanks, I didn't know about hex_asc()!  I'll post v2 of the series today.
And thanks a lot for finding those typos in resource.c.  I never would
have found those...

Bjorn
