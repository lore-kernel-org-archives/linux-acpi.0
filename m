From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] PNPACPI: Enable PNPACPI _PSx Support, v3
Date: Tue, 28 Jul 2009 12:15:41 -0700
Message-ID: <20090728191541.GB25665@kroah.com>
References: <49D101DA.50201@gmx.net>
 <200904021510.37517.trenn@suse.de>
 <20090630230314.GD2634@kroah.com>
 <4A53AAD1.1050308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753422AbZG1TTn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A53AAD1.1050308@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: Thomas Renninger <trenn@suse.de>, stable@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, abelay@mit.edu, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 07, 2009 at 10:06:41PM +0200, Witold Szczeponik wrote:
> Greg KH wrote:
> 
> [snip]
> 
> > 
> > What specific git commit id in Linus's tree is this?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> the git commit id of this patch would be 
> 6328a57401dc5f5cf9931738eb7268fcd8058c49, but the patch triggered a 
> regression which is described in 
> http://bugzilla.kernel.org/show_bug.cgi?id=13243 and which was fixed in 
> 19bde778c1fd2574cc020a618d7d576f260271ca.

Ok, I've queued up both of these for the next .27 stable release.

thanks,

greg k-h
