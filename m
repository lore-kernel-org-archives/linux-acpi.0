From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v2 3/7] ACPI: Add _OST support for sysfs eject
Date: Thu, 10 May 2012 11:41:05 -0600
Message-ID: <1336671665.16730.228.camel@misato.fc.hp.com>
References: <1336507944-10219-1-git-send-email-toshi.kani@hp.com>
	 <1336507944-10219-4-git-send-email-toshi.kani@hp.com>
	 <1336581973.2498.15.camel@lorien2>
	 <1336587377.16730.150.camel@misato.fc.hp.com>
	 <1336664428.2581.21.camel@lorien2>
	 <1336667664.16730.201.camel@misato.fc.hp.com>
	 <1336668931.2581.27.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336668931.2581.27.camel@lorien2>
Sender: linux-kernel-owner@vger.kernel.org
To: shuahkhan@gmail.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2012-05-10 at 10:55 -0600, Shuah Khan wrote:
> On Thu, 2012-05-10 at 10:34 -0600, Toshi Kani wrote:
> 
> > _OST is the ACPI standard method for the platform to receive the status
> > of hotplug operations.  Some platforms may require the OS to support
> > _OST in order to support ACPI hotplug operations.  For instance, if the
> > platform has the management console where user can request a hotplug
> > operation from, this _OST support would be required for the management
> > console to show the result of a hotplug request to user.  
> > 
> 
> This will be a good information capture in the change log.

Sounds good.  I will add this information to patch 0/1 and 1/1.


> Thanks Toshi. It is interesting to have platforms require optional
> methods. Guess  you can never rule out weirdness in how these Specs.
> actually get implemented :)

It is optional for platforms to implement it.  But when some platforms
start implementing it, it is necessary for the OS to support it. :) 


Thanks,
-Toshi
