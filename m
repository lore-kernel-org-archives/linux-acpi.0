From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 0/4] ipmi: remove SPMI and update core driver with
 dev_printk
Date: Tue, 09 Mar 2010 16:16:22 -0700
Message-ID: <1268176582.2462.1.camel@zim>
References: <20100304033146.30205.68689.stgit@bob.kio>
	 <4B8FBE8F.3030203@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:2439 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab0CIXQo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2010 18:16:44 -0500
In-Reply-To: <4B8FBE8F.3030203@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

On Thu, 2010-03-04 at 08:07 -0600, Corey Minyard wrote: 
> Myron Stowe wrote:
> > These patches remove the SPMI based IPMI device discovery mechanism and
> > update the driver's core to use dev_printk() and its constructs.
> >
snip 
> 
> > Ultimately, I would like to see if it is possible to also remove IPMI's
> > SMBIOS based device discovery mechanism.
> >   
> Maybe in an ideal world, but I don't know where an ideal world is, so I 
> have to live in the one I'm in.  There's plenty of systems that only 
> document this in SMBIOS tables, there's plenty of systems with broken 
> ACPI, etc.  So SMBIOS and SPMI are going to have to stay.
> 
Discussions concerning this patch series seem to have ceased and I have
not heard back from anyone that can definitively state that the SPMI
table is actively being used in the field.

At this point, it seems that the most logical ways to proceed are: 
      * Take the patch series as it is with the possible risk that we
        will encounter a system in the field that relies on SPMI.
        
      * Or, I can rework the patch series, basically splitting it into
        two.  The first series would include 
                ipmi: Raise precedence of PNP based discovery mechanisms (ACPI, PCI),
                ipmi: Convert tracking of the ACPI device pointer to a PNP device,
                ipmi: Update driver to use 'dev_printk()' and its constructs,
        with the second series including 
                ipmi: Remove SPMI table based device discovery method,
                ipmi: Further 'dev_printk()' conversion that is dependent on SPMI removal.
The idea being that the more contentious second series, now isolated,
could be easily retracted if necessary.
        

I do understand that it is possible that we will encounter a system that
relies on SPMI.  The most likely scenario would seem to be with respect
to embedded systems.  However, I think it is unlikely for the following
reasons (as always, please respond to any and all concerns as it is this
community that are the subject matter experts) and would still like to
consider removing such:

        The IPMI related SMBIOS and SPMI tables are static, the idea
        being that such tables can be referenced by the OS very early in
        its boot related processing; well before the OS has progressed
        to the point of ACPI namespace based control method
        availability.  A couple of points concerning such are: they seem
        relatively redundant with respect to each other, and, the
        current IPMI driver is not truly capable of taking advantage of
        such "static" capability[1].
        
        IPMI's SPMI table discovery mechanism was championed by HP.
        This was mainly for HP's proprietary HP-UX OS as it did want to
        take advantage of the early reference capability that static
        tables provide (I do not know if SMBIOS was considered, or if
        so, why it was not considered viable - perhaps someone on this
        list has that history).  As such, we seriously question whether
        other vendors have even included SPMI into their BIOS'.
        
        Modern systems rely on ACPI namespace and/or PCI as preferred
        enumeration techniques.  Windows only looks at these, and not
        SMBIOS or SPMI, which has bearing since x86 Linux typically runs
        on platforms also capable of running Windows.  Yes, embedded
        systems are the biggest exception here.

        Bjorn Helgaas also covered many of these points, and a few
        others, in his reply to Bela Lubkin concerning [Patch 2/4] which
        is worth re-reading.
        
I'm looking forward to any feedback or responses of any kind, even
rebuttals.

Thanks,

Myron
        

[1] I was not able to express this point as well as I would have liked.
The point I'm attempting to make is that the IPMI driver, as it
currently exists, is not capable of probing and attaching to a device
during early boot processing to really take advantage of "static"
tables.  The fact that it is capable of being built and run/installed as
a module is a big hint towards such but is not, in itself, definitive.
However, its PCI and ACPI probing mechanisms are definitive in that they
rely on their respective subsystems having already been setup which is
well after early boot processing.

> 
> -corey
> 


-- 
Myron Stowe                             HP Open Source Linux Lab (OSLL)



