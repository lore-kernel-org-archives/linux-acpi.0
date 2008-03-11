From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/4] ACPI PCI slot detection driver
Date: Tue, 11 Mar 2008 09:56:37 -0700
Message-ID: <200803110956.37619.jbarnes@virtuousgeek.org>
References: <20080229002341.GA21420@ldl.fc.hp.com> <47D684D0.6060200@jp.fujitsu.com> <20080311132800.GC21482@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-06.bluehost.com ([69.89.17.206]:43136 "HELO
	outbound-mail-06.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751747AbYCKQ5K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 12:57:10 -0400
In-Reply-To: <20080311132800.GC21482@parisc-linux.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Matthew Wilcox <matthew@wil.cx>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, warthog19@eaglescrag.net, kristen.c.accardi@intel.com, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, March 11, 2008 6:28 am Matthew Wilcox wrote:
> On Tue, Mar 11, 2008 at 10:10:40PM +0900, Kenji Kaneshige wrote:
> > 1) I checked ACPI spec again and again, but I could not find any
> >    reason to add Fujitsu servers to quirks list. So I'd like you to
> >    add HP servers to the quirks list. I'll send the following patches
> >    followed by this e-mail.
>
> Alex pointed out that IBM interprets the spec the same way that HP does.
> Are there any other machines that follow the spec the same way that
> Fujitsu does?

So Kenji is arguing that _STA should be called before _SUN (iow that the _SUN 
value is bogus unless _STA indicates that the slot is powered)?  That seems 
harder for the user; often times you want to find a slot even if it's powered 
down & empty (say to add a new card)...  It looks like the current code won't 
provide a slot name on Fujitsu machines in this case, or am I missing 
something?

Thanks,
Jesse
