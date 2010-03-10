From: Corey Minyard <minyard@acm.org>
Subject: Re: [SPAM] - Re: [PATCH 0/4] ipmi: remove SPMI
 and update core driver with dev_printk - Email found in subject
Date: Wed, 10 Mar 2010 09:20:57 -0600
Message-ID: <4B97B8D9.9090008@acm.org>
References: <20100304033146.30205.68689.stgit@bob.kio><4B8FBE8F.3030203@acm.org>
	<1268176582.2462.1.camel@zim>
	<87AED897FD94E641A438368C41CE08A9448FFB@ka-exchange-1.kontronamerica.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-reply-to: <87AED897FD94E641A438368C41CE08A9448FFB@ka-exchange-1.kontronamerica.local>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Andy Cress <andy.cress@us.kontron.com>
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Myron Stowe <myron.stowe@hp.com>, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Andy Cress wrote:
> Myron,
>
> How about this for an approach with SPMI:
> Rather than remove it entirely, use '#ifdef SPMI_DEPRECATED' around that
> code, so that it can still be enabled at compile time by those that
> later find that they need it. 
> And add a comment with instructions to notify this list if someone finds
> that they need to enable it.   
>
> That should prove conclusively whether it is used/needed or not.
>   
I'd prefer way to prove this without causing people problems in the 
field.  The average user is not going to look at the source code and go 
"Oh, this is what I need to do!"  It will be a painful process for them 
to figure out what happened.

I don't see a way to test this in the field without causing issues.  If 
this code does not hurt anything, then IMHO it needs to stay.  This is a 
legacy driver, really, so removing things of this nature is dangerous.  
If leaving the code in is a problem, then we need to figure something out.

I'm for the "two patch" approach mentioned by Myron.

-corey

> Andy
>
> -----Original Message-----
> From: Myron Stowe [mailto:myron.stowe@hp.com] 
> Sent: Tuesday, March 09, 2010 6:16 PM
> To: Corey Minyard
> Cc: linux-acpi@vger.kernel.org;
> openipmi-developer@lists.sourceforge.net; lenb@kernel.org
> Subject: [SPAM] - Re: [Openipmi-developer] [PATCH 0/4] ipmi: remove SPMI
> and update core driver with dev_printk - Email found in subject
>
> On Thu, 2010-03-04 at 08:07 -0600, Corey Minyard wrote: 
>   
>> Myron Stowe wrote:
>>     
>>> These patches remove the SPMI based IPMI device discovery mechanism
>>>       
> and
>   
>>> update the driver's core to use dev_printk() and its constructs.
>>>
>>>       
> snip 
>   
>>> Ultimately, I would like to see if it is possible to also remove
>>>       
> IPMI's
>   
>>> SMBIOS based device discovery mechanism.
>>>   
>>>       
>> Maybe in an ideal world, but I don't know where an ideal world is, so
>>     
> I 
>   
>> have to live in the one I'm in.  There's plenty of systems that only 
>> document this in SMBIOS tables, there's plenty of systems with broken 
>> ACPI, etc.  So SMBIOS and SPMI are going to have to stay.
>>
>>     
> Discussions concerning this patch series seem to have ceased and I have
> not heard back from anyone that can definitively state that the SPMI
> table is actively being used in the field.
>
> At this point, it seems that the most logical ways to proceed are: 
>       * Take the patch series as it is with the possible risk that we
>         will encounter a system in the field that relies on SPMI.
>         
>       * Or, I can rework the patch series, basically splitting it into
>         two.  The first series would include 
>                 ipmi: Raise precedence of PNP based discovery mechanisms
> (ACPI, PCI),
>                 ipmi: Convert tracking of the ACPI device pointer to a
> PNP device,
>                 ipmi: Update driver to use 'dev_printk()' and its
> constructs,
>         with the second series including 
>                 ipmi: Remove SPMI table based device discovery method,
>                 ipmi: Further 'dev_printk()' conversion that is
> dependent on SPMI removal.
> The idea being that the more contentious second series, now isolated,
> could be easily retracted if necessary.
>         
>
> I do understand that it is possible that we will encounter a system that
> relies on SPMI.  The most likely scenario would seem to be with respect
> to embedded systems.  However, I think it is unlikely for the following
> reasons (as always, please respond to any and all concerns as it is this
> community that are the subject matter experts) and would still like to
> consider removing such:
>
>         The IPMI related SMBIOS and SPMI tables are static, the idea
>         being that such tables can be referenced by the OS very early in
>         its boot related processing; well before the OS has progressed
>         to the point of ACPI namespace based control method
>         availability.  A couple of points concerning such are: they seem
>         relatively redundant with respect to each other, and, the
>         current IPMI driver is not truly capable of taking advantage of
>         such "static" capability[1].
>         
>         IPMI's SPMI table discovery mechanism was championed by HP.
>         This was mainly for HP's proprietary HP-UX OS as it did want to
>         take advantage of the early reference capability that static
>         tables provide (I do not know if SMBIOS was considered, or if
>         so, why it was not considered viable - perhaps someone on this
>         list has that history).  As such, we seriously question whether
>         other vendors have even included SPMI into their BIOS'.
>         
>         Modern systems rely on ACPI namespace and/or PCI as preferred
>         enumeration techniques.  Windows only looks at these, and not
>         SMBIOS or SPMI, which has bearing since x86 Linux typically runs
>         on platforms also capable of running Windows.  Yes, embedded
>         systems are the biggest exception here.
>
>         Bjorn Helgaas also covered many of these points, and a few
>         others, in his reply to Bela Lubkin concerning [Patch 2/4] which
>         is worth re-reading.
>         
> I'm looking forward to any feedback or responses of any kind, even
> rebuttals.
>
> Thanks,
>
> Myron
>         
>
> [1] I was not able to express this point as well as I would have liked.
> The point I'm attempting to make is that the IPMI driver, as it
> currently exists, is not capable of probing and attaching to a device
> during early boot processing to really take advantage of "static"
> tables.  The fact that it is capable of being built and run/installed as
> a module is a big hint towards such but is not, in itself, definitive.
> However, its PCI and ACPI probing mechanisms are definitive in that they
> rely on their respective subsystems having already been setup which is
> well after early boot processing.
>
>   
>> -corey
>>
>>     
>
>
>   


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
