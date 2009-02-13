From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] [PATCH] PCI mmconfig without ACPI
Date: Fri, 13 Feb 2009 12:40:41 -0800
Message-ID: <200902131240.42943.jbarnes@virtuousgeek.org>
References: <1233766786.16414.26.camel@localhost.localdomain> <20090204181738.GA16174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090204181738.GA16174@elte.hu>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Ed Swierk <eswierk@aristanetworks.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, February 4, 2009 10:17 am Ingo Molnar wrote:
> But again, nice patch and it would be nice to see this concept hit
> mainline.

Yeah, concept seems fine, and the cleanups you suggested sound good (splitting 
the files would make things clearer, and some of that stuff probably belongs 
in the ACPI or PNP core anyway).

My only concern is that enabling mmconfig w/o a reservation (as might happen 
if ACPI was disabled) may cause problems since it could overlap with other 
space.  That was one of the issues we ran into when enabling it in the first 
place...  But we've worked around it so far so I'm happy to give it a spin 
for the next cycle.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
