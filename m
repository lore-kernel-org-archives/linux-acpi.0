From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Fri, 13 Oct 2006 13:31:25 +0200
Message-ID: <200610131331.26191.rjw@sisk.pl>
References: <1160663160.13196.273175261@webmail.messagingengine.com> <20061013045339.GA534@srcf.ucam.org> <1160715418.20153.273234357@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:31424 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751345AbWJMLbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 07:31:09 -0400
In-Reply-To: <1160715418.20153.273234357@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Friday, 13 October 2006 06:56, Mathew Brown wrote:
> Thanks.  But is 80C safe for a CPU?  As I mentioned, 70C is considered
> dangerous for an Opteron chip.  What type of temperatures can the
> Turions and the C2D support?

I think HP would force the fan at lower temperatures if 80C were considered
as dangerous ....

Greetings,
Rafael


> On Fri, 13 Oct 2006 05:53:39 +0100, "Matthew Garrett"
> <mjg59@srcf.ucam.org> said:
> > On Thu, Oct 12, 2006 at 09:41:15PM -0700, Mathew Brown wrote:
> > > Thanks Matthew.  Just out of curiosity, how did you find out about this
> > > feature (forcing the fan at 80C)?  Also, is this specific to HP or do
> > > other vendors also support this?  Finally, is 80C safe for the CPU
> > > (Intel or AMD?)?  I read that Opteron chips could be damaged if their
> > > temperature reaches 70C.  Thanks for your help.
> > 
> > A certain amount of reverse engineering of HP hardware while I was 
> > trying to diagnose some fan problems before. The fan control chip that 
> > HP use is pretty standard, so I think there are docs around somewhere.
> > 
> > -- 
> > Matthew Garrett | mjg59@srcf.ucam.org
> -- 
>   Mathew Brown
>   mathewbrown@fastmail.fm
> 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
