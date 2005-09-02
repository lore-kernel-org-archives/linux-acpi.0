From: Greg KH <greg@kroah.com>
Subject: Re: ACPI problem with PCI Express Native Hot-plug driver
Date: Fri, 2 Sep 2005 01:12:52 -0700
Message-ID: <20050902081252.GA11567@kroah.com>
References: <b115cb5f0509020057741365dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b115cb5f0509020057741365dc@mail.gmail.com>
Sender: linux-newbie-owner@vger.kernel.org
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 02, 2005 at 04:57:33PM +0900, Rajat Jain wrote:
> Hi,
> 
> I'm using RHEL4 kernel (2.6.9), and am trying to make PCI Express
> Native Hot-plug driver (pciehp) work on my system (My system has two
> hot-pluggable PCI Express slots). I am facing following problem, and
> would really appreciate if any one can provide any info regarding this
> problem.

Can you try 2.6.13?  It is much improved in the pciehp area than 2.6.9.

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
