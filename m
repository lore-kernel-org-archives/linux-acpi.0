From: Len Brown <lenb@kernel.org>
Subject: Re: [1/2] 2.6.23-rc3: known regressions with patches
Date: Fri, 31 Aug 2007 17:41:22 -0400
Message-ID: <200708311741.22863.lenb@kernel.org>
References: <46D59081.2040605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <46D59081.2040605@googlemail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriel C <nix.or.die@googlemail.com>, Satyam Sharma <satyam.sharma@gmail.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Tony Luck <tony.luck@intel.com>, John Stultz <johnstul@us.ibm.com>, Paolo Ornati <ornati@fastwebnet.it>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, Stephen Ziemba <sziemba@ecn.purdue.edu>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 29 August 2007 11:28, Michal Piotrowski wrote:

> ACPI
> 
> Subject         : the fan doesn't work any more
> References      : http://lkml.org/lkml/2007/8/28/359
> Last known good : ?
> Submitter       : Daniel Ritz <daniel.ritz-ml@swissonline.ch>
> Caused-By       : Alexey Starikovskiy <astarikovskiy@suse.de>
>                   commit cd8c93a4e04dce8f00d1ef3a476aac8bd65ae40b
> Handled-By      : Alexey Starikovskiy <astarikovskiy@suse.de>
> Patch           : http://lkml.org/lkml/2007/8/29/15
> Status          : patch was suggested

I believe that this is gone as of 2.6.23-rc4-git3

http://bugzilla.kernel.org/show_bug.cgi?id=8958

thanks,
-Len
