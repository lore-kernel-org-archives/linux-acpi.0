From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH 1/4] IPMI: Add one interface to get more info of
	low-level IPMI device
Date: Fri, 15 Oct 2010 13:07:57 +0800
Message-ID: <1287119277.22388.58.camel@localhost.localdomain>
References: <1286869630-18695-1-git-send-email-yakui.zhao@intel.com>
	 <1286869630-18695-2-git-send-email-yakui.zhao@intel.com>
	 <4CB7358F.7040808@acm.org>
	 <1287104855.22388.34.camel@localhost.localdomain>
	 <4CB7C489.3050900@acm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48660 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab0JOFMY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Oct 2010 01:12:24 -0400
In-Reply-To: <4CB7C489.3050900@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Fri, 2010-10-15 at 11:03 +0800, Corey Minyard wrote:
> On 10/14/2010 08:07 PM, ykzhao wrote:
> >
> >> The way you are doing it, there is no need for a refcount, since you are
> >> making a copy of the data.
> >>
> >> Is a copy or a pointer better?  A pointer is generally preferred, it
> >> keeps from having to either store data on the stack or dynamically
> >> allocate it for the copy.  But it's not a huge deal in this case.  A
> >> pointer will require you to dynamically allocate the smi_info structure
> >> so you can free it separately.  But then only the top-level put routine
> >> is required, it can simply free the structure if the refcount is zero.
> >>      
> > When the pointer mechanism is used, we will have to allocate the
> > smi_info structure dynamically. Every time the function of
> > ipmi_get_smi_info, it will be allocated dynamically. And if it fails in
> > the allocation, we can't return the expected value.
> >    
> Well, you misunderstand.  You allocate one copy when the SMI info is 
> created.  And you return a pointer to that with the refcount 
> incremented.  No need to allocate a new one on each call.  Use the 
> refcounts to know when to free it.

The ipmi_smi_info is defined statically in the structure of smi_info. 
	struct smi_info {
		......
        	struct ipmi_smi_info smi_data;
 };

If the pointer mechanism is selected, we can return the pointer of
smi_data. And in such case it seems unnecessary to know when to free it.

> 
> > But when the copy is used, it will be much simpler.  It is the caller's
> > responsibility to prepare the corresponding data structure. They can
> > define it on stack. Of course they can also dynamically allocate it.
> >
> > Can we choose the copy mechanism to make it much simpler?
> >    
> Sure, I think I already said this :).  Just get rid of the refcount stuff.

OK. I will remove the refcount stuff.

> -corey

