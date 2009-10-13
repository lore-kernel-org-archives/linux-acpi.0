From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] pci: increase alignment to make more space for hidden code
Date: Tue, 13 Oct 2009 09:15:03 -0600
Message-ID: <200910130915.04697.bjorn.helgaas@hp.com>
References: <200908072333.24631.storm@sys49152.net> <1255414115.14484.47.camel@dc7800.home> <20091013064901.GD9470@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760219AbZJMPPr@vger.kernel.org>
In-Reply-To: <20091013064901.GD9470@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Ricardo Jorge da Fonseca Marques Ferreira <storm@sys49152.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yannick Roehlly <yannick.roehlly@free.fr>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, x86@kernel.org, andreaorru91@gmail.com, jjorge@free.fr
List-Id: linux-acpi@vger.kernel.org

On Tuesday 13 October 2009 12:49:01 am Ingo Molnar wrote:
> * Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> > In the patch below, I added some extra PCI dumps of the bridge and the 
> > NIC around the ACPI EC init.  The patch also removes Yinghai's 
> > workaround so we should see the original failure, just with a little 
> > more debug.
> 
> Btw., i'd _strongly_ suggest to finally add some sort of pci=verbose 
> easy-to-use debug toggle for users to enable.
> 
> Everything that matters to resource allocation. We should print the BIOS 
> state (Yinghai did a patch for this some time ago and that is upstream 
> already), we should print quirk execution, we should print ACPI AML 
> execution - everything that might matter to PCI allocations.
> 
> An easy-to-use 'give me all the debug info' feature is really important. 
> We have apic=verbose for similar reasons.

Agreed.  That's why I sent such a huge testing patch -- I think we do
a poor job of making this stuff debuggable, so I want to use this problem
as a test case of "what useful stuff can we print to make this easier in
the future."

Bjorn
